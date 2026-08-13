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
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? "Verification Failed");
      },

      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },

      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
