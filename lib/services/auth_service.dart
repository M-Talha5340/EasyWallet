import 'package:easy_wallet_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone({
  required String phoneNumber,
  required Function(String verificationId) codeSent,
  required Function(String message) onError,
}) async {
  try {
    print("PHONE NUMBER: $phoneNumber");
    print("STARTING PHONE VERIFICATION...");

    // Force Firebase Phone Auth to use reCAPTCHA
    await _auth.setSettings(
      forceRecaptchaFlow: true,
    );

    print("RECAPTCHA FLOW ENABLED");

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      verificationCompleted: (PhoneAuthCredential credential) async {
        print("VERIFICATION COMPLETED AUTOMATICALLY");

        try {
          await _auth.signInWithCredential(credential);
          print("AUTOMATIC SIGN IN SUCCESSFUL");
        } catch (e) {
          print("AUTOMATIC SIGN IN ERROR: $e");
        }
      },

      verificationFailed: (FirebaseAuthException e) {
        print("========== PHONE AUTH ERROR ==========");
        print("CODE: ${e.code}");
        print("MESSAGE: ${e.message}");
        print("DETAILS: ${e.toString()}");
        print("======================================");

        onError(e.message ?? "Verification Failed");
      },

      codeSent: (String verificationId, int? resendToken) {
        print("OTP SENT SUCCESSFULLY");
        print("VERIFICATION ID: $verificationId");

        codeSent(verificationId);
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        print("OTP AUTO RETRIEVAL TIMEOUT");
        print("VERIFICATION ID: $verificationId");
      },
    );
  } catch (e) {
    print("VERIFY PHONE EXCEPTION: $e");
    onError(e.toString());
  }
}

  Future<bool> verifypassword({
    required String verificationId,
    required String otp,
    required bool isSignUp,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    if (isSignUp) {
      await _auth.signInWithCredential(credential);
      final userExists = await FirestoreServices.instance.checkDoc(isSignUp);
      if (userExists) {
        return true;
      }
    } else {
      await _auth.signInWithCredential(credential);
      final userExists = await FirestoreServices.instance.checkDoc(isSignUp);
      if (userExists) {
        return true;
      }
    }
    return false;
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
