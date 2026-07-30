import 'dart:async';

import 'package:easy_wallet_app/screens/signin.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   @override
    void initState(){
      super.initState();
      Timer(const Duration(seconds: 3),(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>EasyWalletLoginScreen()));
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
              /// Bottom Security Badge
              Container(
                height: 78,
                decoration: BoxDecoration(
                  color: const Color(0xff213248),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                          
                    Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xff61FF80),
                      size: 32,
                    ),
                          
                    SizedBox(width: 5),
                          
                    Flexible(
                      child: Text(
                        "Powered by Bank-grade Security",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
      ],
      persistentFooterDecoration: BoxDecoration(
        color: const Color(0xff0E2233),
      ),
    
      backgroundColor: const Color(0xff0E2233),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [              
          
              /// Logo Card
              Container(
                width: 165,
                height: 165,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  border: Border.all(
                    color: const Color(0xff1C4B43),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .35),
                      blurRadius: 45,
                      spreadRadius: 8,
                    )
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      color: const Color(0xff163943),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white12,
                      ),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 72,
                      color: Color(0xff61FF80),
                    ),
                  ),
                ),
              ),                      
              SizedBox(height: 10,),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Easy",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                    TextSpan(
                      text: " Wallet",
                      style: TextStyle(
                        color: Color(0xff61FF80),
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 25),
            
              const Text(
                "ENTERPRISE GRADE FINANCE",
                style: TextStyle(
                  color: Color(0xff7F91B7),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 5,
                
                ),
                textAlign: TextAlign.center,
              ),  
              SizedBox(height: 30,), 
               ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 1,
                  minHeight: 5,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation(
                    Color(0xff61FF80),
                  ),
                ),
              ),                        
               SizedBox(height: 10,),
              Row(
                children: const [
          
                  Text(
                    "Initializing secure session",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          
                  Spacer(),
          
                  Text(
                    "100%",
                    style: TextStyle(
                      color: Color(0xff61FF80),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),                    
          
                            
            ],
          ),
        ),
      ),
    );
  }
}