import 'dart:convert';

import 'package:easy_wallet_app/screens/payfast_checkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RechargeWalletScreen extends StatefulWidget {
  const RechargeWalletScreen({super.key});

  @override
  State<RechargeWalletScreen> createState() => _RechargeWalletScreenState();
}

class _RechargeWalletScreenState extends State<RechargeWalletScreen> {
  double selectedAmount = 1000;
  int selectedMethod = 0;

  final TextEditingController amountController = TextEditingController(
    text: "1000",
  );

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
Future<void> startCheckout(BuildContext context, String paymentId) async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not logged in.");
      return;
    }

    final idToken = await user.getIdToken();

    const baseUrl = "http://192.168.0.104:5032";

    final response = await http.post(
      Uri.parse(
        "$baseUrl/api/Payment/$paymentId/checkout",
      ),
      headers: {
        "Authorization": "Bearer $idToken",
        "Content-Type": "application/json",
      },
    );

    print("STATUS: ${response.statusCode}");
    print("RESPONSE: ${response.body}");

    if (response.statusCode != 200) {
      print("Checkout creation failed.");
      return;
    }

    final data = jsonDecode(response.body);

    final String actionUrl =
        data["checkout"]["actionUrl"];

    final Map<String, String> fields =
        Map<String, String>.from(
      data["checkout"]["fields"],
    );

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PayFastCheckoutScreen(
          actionUrl: actionUrl,
          fields: fields,
        ),
      ),
    );
  } catch (e) {
    print("CHECKOUT ERROR: $e");
  }
}
  Future<void> createPayment() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("No user is currently logged in.");
        return;
      }

      // Get Firebase ID Token
      final idToken = await user.getIdToken();

      print("Firebase UID: ${user.uid}");
      print("ID TOKEN RECEIVED");

      // Replace this with your PC's IPv4 address
      const baseUrl = "http://192.168.0.104:5032";

      final response = await http.post(
        Uri.parse("$baseUrl/api/Payment/create"),
        body: jsonEncode({
          "Amount": selectedAmount.toString(),
          "Content-Type": "application/json",
        }),
        headers: {
          "Authorization": "Bearer $idToken",
          "Content-Type": "application/json",
        },
      );

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("Backend verified : ${data['message']}");
        print("Backend verified Balance Status: ${data['status']}");
      }
    } catch (e) {
      print("ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xff007A33)),
        ),
        title: const Text(
          "Recharge Wallet",
          style: TextStyle(
            color: Color(0xff102A43),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),

          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "Add Money",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff102A43),
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Select or enter an amount to add to your wallet",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(child: _amountButton(500)),

                    const SizedBox(width: 15),

                    Expanded(child: _amountButton(1000)),

                    const SizedBox(width: 15),

                    Expanded(child: _amountButton(5000)),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  "Custom Amount",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xffEEF3F8),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),

                      const Text(
                        "PKR",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: TextFormField(
                          controller: amountController,
                          style: TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(255, 123, 123, 123),
                          ),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  "Select Payment Method",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff102A43),
                  ),
                ),

                const SizedBox(height: 10),

                _paymentMethodCard(
                  index: 0,
                  icon: Icons.credit_card,
                  title: "Card",
                  subtitle: "VISA / MASTERCARD",
                ),

                const SizedBox(height: 18),

                _paymentMethodCard(
                  index: 1,
                  icon: Icons.account_balance,
                  title: "Bank Transfer",
                  subtitle: "1LINK / LOCAL BANKS",
                ),

                const SizedBox(height: 18),

                _paymentMethodCard(
                  index: 2,
                  icon: Icons.account_balance_wallet_outlined,
                  title: "Mobile Wallet",
                  subtitle: "JAZZCASH / EASYPAISA",
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () async {
                      double amount;

                      if (amountController.text.isEmpty) {
                        amount = selectedAmount;
                      } else {
                        amount = double.parse(amountController.text);
                      }
                      await startCheckout(
                        context,
                        "a309f3b4-0adb-43bc-8cbf-aaac0c797fc6",
                      );
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Recharge PKR $amount using ${paymentMethodName()}",
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0A7A34),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue to Pay",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(width: 12),

                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String paymentMethodName() {
    switch (selectedMethod) {
      case 0:
        return "Card";

      case 1:
        return "Bank Transfer";

      case 2:
        return "Mobile Wallet";

      default:
        return "";
    }
  }

  Widget _paymentMethodCard({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool selected = selectedMethod == index;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        setState(() {
          selectedMethod = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffE8FFF0) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? const Color(0xff067A2F) : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: const Color(0xffEEF3F8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: const Color(0xff067A2F), size: 34),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff102A43),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: selected ? const Color(0xff067A2F) : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? const Color(0xff067A2F) : Colors.grey,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountButton(double amount) {
    final bool selected = selectedAmount == amount;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAmount = amount;
          amountController.text = amount.toString();
        });
      },

      child: Container(
        height: 85,

        decoration: BoxDecoration(
          color: selected ? const Color(0xffE8FFF0) : Colors.white,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: selected ? const Color(0xff067A2F) : Colors.grey.shade300,

            width: 2,
          ),
        ),

        child: Center(
          child: Text(
            amount.toString(),

            style: TextStyle(
              fontSize: 26,

              fontWeight: FontWeight.bold,

              color: selected
                  ? const Color(0xff067A2F)
                  : const Color(0xff102A43),
            ),
          ),
        ),
      ),
    );
  }
}
