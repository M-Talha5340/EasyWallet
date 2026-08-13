import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_wallet_app/models/user_model.dart';
import 'package:easy_wallet_app/providers/auth_provider.dart';
import 'package:easy_wallet_app/screens/authwrapper.dart';
import 'package:easy_wallet_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final bool isSignUp;
  final String? name;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.isSignUp,
    this.name,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  bool isVerified = false;

  Timer? timer;
  int seconds = 45;
  final otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    seconds = 45;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    for (var controller in controllers) {
      controller.dispose();
    }

    for (var node in focusNodes) {
      node.dispose();
    }
    otpController.dispose();
    super.dispose();
  }

  bool get isOtpComplete {
    return controllers.every((controller) => controller.text.trim().isNotEmpty);
  }

  String get enteredOtp {
    return controllers.map((controller) => controller.text).join();
  }

  void verifyOtp() async {
    if (!isOtpComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete OTP")),
      );
      return;
    }
    try {
      // 1. Verify OTP
      setState(() {
        isVerified = true;
      });
      final userExists = await AuthService.instance.verifypassword(
        verificationId: widget.verificationId,
        otp: enteredOtp,
        isSignUp: widget.isSignUp,
      );

      if (!mounted) return;

      // 2. SIGN UP
      if (widget.isSignUp) {
        AppUser appUser = AppUser(
          name: widget.name,
          phone: widget.phoneNumber,
          walletBalance: 0.0,
          createdAt: Timestamp.now(),
        );
        if (userExists == false) {
          await context.read<Userprovider>().createUser(appUser);
          if (!mounted) {
            return;
          }       
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AuthWrapper()),
            (route) => false,
          );
        } else {
          context.read<Userprovider>().clearUser();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Already Registered.")));
          Navigator.pop(context);
        }
      } else {
        // 3. SIGN IN

        if (!userExists) {
          // User doesn't exist
          if (!mounted) return;
          //  context.read<Userprovider>().clearUser();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "No such user found. Please create an account first.",
              ),
            ),
          );
          Navigator.pop(context);
          return;
        }
        if (!mounted) {
          return;
        }
        context.read<Userprovider>().setUser();
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        isVerified = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Authentication failed")),
      );
    } catch (e) {
      setState(() {
        isVerified = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          height: 65,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0A7C39),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            onPressed: isOtpComplete ? verifyOtp : null,
            child: isVerified
                ? Center(child: CircularProgressIndicator(color: Colors.white))
                : Text(
                    "Verify & Continue",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
      persistentFooterDecoration: BoxDecoration(color: Colors.white),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 78),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Back Button
              const Text(
                "Verify your number",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 14),

              const Text(
                "Enter the 6-digit code sent to",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),

              const SizedBox(height: 8),

              Text(
                widget.phoneNumber,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              /// OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => otpBox(index)),
              ),

              const SizedBox(height: 45),

              Center(
                child: seconds == 0
                    ? TextButton(
                        onPressed: () {
                          startTimer();

                          /// Resend OTP API/Firebase code will be added
                          /// in Part 4.
                        },
                        child: const Text(
                          "Resend Code",
                          style: TextStyle(
                            color: Color(0xff0A7C39),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                          ),
                          children: [
                            const TextSpan(text: "Resend code in "),
                            TextSpan(
                              text: "0:${seconds.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                color: Color(0xff0A7C39),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 48,
      height: 72,
      child: TextFormField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0xffEEF3F9),
          contentPadding: EdgeInsets.zero,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xff0A7C39), width: 2),
          ),
        ),

        onChanged: (value) {
          setState(() {});
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          }
        },
      ),
    );
  }
}
