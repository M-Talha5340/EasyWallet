import 'package:easy_wallet_app/providers/auth_provider.dart';
import 'package:easy_wallet_app/screens/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer>
    with SingleTickerProviderStateMixin {
  late Future<void> _future;
  bool _isDataLoaded = false;
  double progress =0.0;    

  @override
  void initState() {
    super.initState();
    _future = _initialize();
    progress = 0.2;
    
  }

  Future<void> _initialize() async {
    setState(() {
      progress =0.6;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    if(!mounted){
      return ;
    }
    await Future.wait([context.read<Userprovider>().setUser()]);
   setState(() {
    _isDataLoaded = true;
    progress=1.0; 
   });
   await Future.delayed(const Duration(milliseconds: 900));
    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }
        if (snapshot.connectionState != ConnectionState.done ||
            !_isDataLoaded) {
          return Scaffold(
            persistentFooterButtons: [
              /// Bottom Security Badge
              Container(
                height: 78,
                decoration: BoxDecoration(
                  color: const Color(0xff213248),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.white10),
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
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            color: const Color(0xff163943),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 72,
                            color: Color(0xff61FF80),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: progress),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, value, child) {
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 5,
                            backgroundColor: Colors.white10,
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xff61FF80),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
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
                          "${(progress * 100 ).toInt()}%",
                          style: TextStyle(
                            color: Color(0xff61FF80),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Navbar(index: 0);
      },
    );
  }
}
