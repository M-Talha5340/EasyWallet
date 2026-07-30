import 'package:easy_wallet_app/screens/signup.dart';
import 'package:easy_wallet_app/screens/wallet_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EasyWalletLoginScreen extends StatefulWidget {
  const EasyWalletLoginScreen({super.key});

  @override
  State<EasyWalletLoginScreen> createState() => _EasyWalletLoginScreenState();
}

class _EasyWalletLoginScreenState extends State<EasyWalletLoginScreen> {
  bool obscure = true;
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _autoValidate = false;
  
  @override
  void dispose() {
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate ?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffEEF2FF),
                Color(0xffF8FFF8),
              ],
            ),
          ),
          child: SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
              
                    /// Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Color(0xff007A2F),
                          size: 42,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Easy Wallet ",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff007A2F),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
              
                    const SizedBox(height: 10),
              
                    const Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
              
                    const SizedBox(height: 15),
              
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: .15),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
              
                          const Text(
                            "Mobile Number ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black54,
                            ),
                          ),
              
                          const SizedBox(height: 15),
              
                          TextFormField(
                            validator: validatePhone,
                            decoration: InputDecoration(
                              hintText: "e.g. 03005002001",
                              prefixIcon: const Icon(Icons.person_outline),
                              filled: true,
                              fillColor: const Color(0xffEEF2FF),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
              
                          const SizedBox(height: 25),
              
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "PASSWORD",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xff007A2F),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
              
                          const SizedBox(height: 15),
              
                          TextFormField(
                            validator: validatePassword,
                            obscureText: obscure,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: const Color(0xffEEF2FF),
                              hintText: "e.g. Abc@123",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
              
                          const SizedBox(height: 25),
              
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff007A2F),
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {
                                  setState(() {
                                    _autoValidate = true;
                                  });
                                if(_formKey.currentState!.validate()){
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>WalletScreen()));
                                }

                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
              
                          const SizedBox(height: 25),
              
                          RichText(
                            textAlign: TextAlign.center,
                            text:  TextSpan(
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                                  ),
                              children: [
                                TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                  ..onTap =(){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>EasyWalletSignUpScreen()));
                                  },
                                  text: "Create an Account",
                                  style: TextStyle(
                                    color: Color(0xff007A2F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  
                                ),
                              
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    const SizedBox(height: 20),
              
                    const Icon(
                      Icons.security,
                      color: Colors.blueGrey,
                    ),
              
                    const SizedBox(height: 10),
              
                    const Text(
                      "END-TO-END ENCRYPTED",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 2,
                        color: Colors.blueGrey,
                      ),
                    ),
              
                    const SizedBox(height: 10),
              
                    const Text(
                      "Regulated by the State Bank of Pakistan.\nMember of the Electronic Money Institution framework.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
              
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}