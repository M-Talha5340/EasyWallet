import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_wallet_app/screens/otpverification.dart';
import 'package:easy_wallet_app/screens/signup.dart';
import 'package:easy_wallet_app/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EasyWalletLoginScreen extends StatefulWidget {
  const EasyWalletLoginScreen({super.key});

  @override
  State<EasyWalletLoginScreen> createState() => _EasyWalletLoginScreenState();
}

class _EasyWalletLoginScreenState extends State<EasyWalletLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  String countryCode = "+92";
  bool _autoValidate = false;
  bool isSendingOtp = false;

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffEEF2FF), Color(0xffF8FFF8)],
            ),
          ),
          child: SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 70),

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
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Welcome back",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
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
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              bottom: 5,
                            ),
                            child: const Text(
                              "Mobile Number",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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

                          const SizedBox(height: 18),

                          const Text(
                            "We'll send you an OTP for verification.",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
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
                              onPressed: isSendingOtp?null: () async {
                                setState(() {
                                  _autoValidate = true;                                  
                                });
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isSendingOtp = true;
                                  });
                                  try {
                                    await AuthService.instance.verifyPhone(
                                      phoneNumber:
                                          "$countryCode${phoneController.text}",

                                      codeSent: (verificationId) {
                                        
                                      setState(() {
                                        isSendingOtp= false;
                                      });     
                                      FocusManager.instance.primaryFocus!.unfocus();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => OtpVerificationScreen(
                                              phoneNumber:
                                                  "$countryCode${phoneController.text}",
                                              verificationId: verificationId,
                                              isSignUp: false,
                                            ),
                                          ),
                                        );
                                      },

                                      onError: (message) {
                                        
                                      setState(() {
                                        isSendingOtp= false;
                                      });                   
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text(message)),
                                        );
                                      },
                                    );
                                  } catch (e) {
                                    if(!context.mounted){
                                      setState(() {
                                        isSendingOtp= false;
                                      });                                      
                                      return;
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                }
                              },
                              child: isSendingOtp?Center(
                                child: CircularProgressIndicator(color: Colors.white),
                              ): const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [                                  
                                  Text(
                                    "Send OTP",
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
                                    size: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                              children: [
                                TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              EasyWalletSignUpScreen(),
                                        ),
                                      );
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

                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.security,
                                color: Colors.blueGrey,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "END-TO-END ENCRYPTED",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
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
                        ],
                      ),
                    ),
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
