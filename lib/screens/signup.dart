import 'package:flutter/material.dart';

class EasyWalletSignUpScreen extends StatefulWidget {
  const EasyWalletSignUpScreen({super.key});

  @override
  State<EasyWalletSignUpScreen> createState() => _EasyWalletSignUpScreenState();
}

class _EasyWalletSignUpScreenState extends State<EasyWalletSignUpScreen> {
  bool hidePassword = true;

  final green = const Color(0xff007A33);
  final _formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _autoValidate= false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validatePassword(String? val) {
    if (val!.isEmpty) {
      return "Enter Password";
    } else {
      bool hasUppercase = false;
      bool hasLowercase = false;
      bool hasDigit = false;
      bool hasSpecialChar = false;
      for (int i = 0; i < val.length; i++) {
        String char = val[i];

        if (char.contains(RegExp(r'[A-Z]'))) {
          hasUppercase = true;
        }
        if (char.contains(RegExp(r'[a-z]'))) {
          hasLowercase = true;
        }
        if (char.contains(RegExp(r'[0-9]'))) {
          hasDigit = true;
        }
        if (char.contains(RegExp(r'[@$!%#^*?&]'))) {
          hasSpecialChar = true;
        }
      }
      if (val.length < 4) {
        return "Must be atleast 4 characters";
      }
      if (!hasUppercase) {
        return "Must contain at least one uppercase letter";
      }

      if (!hasLowercase) {
        return "Must contain at least one lowercase letter";
      }

      if (!hasDigit) {
        return "Must contain at least one number";
      }

      if (!hasSpecialChar) {
        return "Must contain at least one special character";
      }
    }
    return null;
  }

  RegExp phoneRegx = RegExp(r'^[0-9]{11}$');

  String? validatePhone(String? val) {
    if (val!.isEmpty) {
      return "Enter Phone No";
    }
    if (!val.contains(phoneRegx)) {
      return "Must be 11 Digits";
    }

    return null;
  }

  String? validateName(String? name) {
    if (name!.isEmpty) {
      return "Enter Name";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FA),
      body: SafeArea(
        child: Form(
          key: _formkey,
          autovalidateMode:   _autoValidate
               ? AutovalidateMode.onUserInteraction
      : AutovalidateMode.disabled,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  /// Logo
                  Text(
                    "Easy Wallet",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: green,
                    ),
                  ),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0E223D),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Start your journey with Pakistan's\nmost secure digital pro-wallet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: .15),
                          blurRadius: 25,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel("Full Name"),

                        const SizedBox(height: 10),

                        TextFormField(
                          validator: validateName,
                          decoration: InputDecoration(
                            hintText: "e.g. Ahmed Khan",
                            hintStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: const Color(0xffEEF2F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        buildLabel("Mobile Number"),

                        const SizedBox(height: 10),

                        TextFormField(
                          validator: validatePhone,
                          decoration: InputDecoration(
                            hintText: "e.g. 03005002001",
                            hintStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: const Color(0xffEEF2F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        buildLabel("Password"),

                        const SizedBox(height: 10),

                        TextFormField(
                          validator: validatePassword,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: "e.g. Abc@123",

                            hintStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),

                            filled: true,
                            fillColor: const Color(0xffEEF2F8),

                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                              elevation: 10,
                              shadowColor: green.withValues(alpha: .35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                              _autoValidate = true;
                              });
                              if (_formkey.currentState!.validate()) {}
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffEEF3FF),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shield_outlined, color: green),
                        const SizedBox(width: 10),
                        const Text(
                          "END-TO-END ENCRYPTED",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Easy Wallet uses bank-grade security",
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
