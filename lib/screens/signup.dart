import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_wallet_app/screens/otpverification.dart';
import 'package:easy_wallet_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class EasyWalletSignUpScreen extends StatefulWidget {
  const EasyWalletSignUpScreen({super.key});

  @override
  State<EasyWalletSignUpScreen> createState() => _EasyWalletSignUpScreenState();
}

class _EasyWalletSignUpScreenState extends State<EasyWalletSignUpScreen> {
  String countryCode = "+92";
  final green = const Color(0xff007A33);
  final _formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  bool _autoValidate = false;
  bool isSendingOtp = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  RegExp phoneRegx = RegExp(r'^[3][0-9]{9}$');

  String? validatePhone(String? val) {
    if (val!.isEmpty) {
      return "Enter Phone No";
    }
    if (!val.startsWith("3")) {
      return "Enter a valid no";
    }
    if (!val.contains(phoneRegx)) {
      return "Must be 10 Digits";
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
      persistentFooterButtons: [
        Center(
          child: Column(
            children: [
              Container(
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xffEEF3FF),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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

              const Text(
                "Easy Wallet uses bank-grade security",
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
            ],
          ),
        ),
      ],
      persistentFooterDecoration: BoxDecoration(color: const Color(0xffF6F8FA)),
      body: SafeArea(
        child: Form(
          key: _formkey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 30,
                    ),
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
                            controller: nameController,
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

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F5FF),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: CountryCodePicker(
                                  onChanged: (code) {
                                    countryCode = code.dialCode!;
                                  },
                                  initialSelection: "PK",
                                  favorite: const ["+92", "PK"],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  showFlag: true,
                                  flagWidth: 20,
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              Container(
                                height: 35,
                                width: 1,
                                color: Colors.grey.shade300,
                              ),

                              Expanded(
                                child: TextFormField(
                                  controller: phoneController,
                                  validator: validatePhone,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "300 1234567",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),
                        const Text(
                          "By continuing ,you agree to recieve an SMS with verification code.",
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 15),

                        /// Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                              elevation: 10,
                              shadowColor: green.withValues(alpha: .35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            onPressed: isSendingOtp?null :()async {
                              setState(() {
                                _autoValidate = true;                                
                              });
                              if (_formkey.currentState!.validate()) {
                                 setState(() {
                                    isSendingOtp = true;
                                 });
                                try {
                                    await AuthService.instance.verifyPhone(
                                      phoneNumber:
                                          "$countryCode${phoneController.text}",

                                      codeSent: (verificationId) {
                                        setState(() {
                                          isSendingOtp = false;
                                        });
                                        FocusManager.instance.primaryFocus!.unfocus();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => OtpVerificationScreen(
                                              phoneNumber:
                                                  "$countryCode${phoneController.text}",
                                              verificationId: verificationId,
                                              isSignUp: true,
                                              name: nameController.text,
                                            ),
                                          ),
                                        );                                        
                                      },

                                      onError: (message) {
                                        setState(() {
                                          isSendingOtp = false;
                                        });
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text(message)),
                                        );
                                      },
                                    );
                                  } catch (e) {
                                    setState(() {
                                          isSendingOtp = false;
                                        });
                                    if(!context.mounted){
                                      return;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                              }
                            },
                            child: isSendingOtp?Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            ) :const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Get Code",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
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
