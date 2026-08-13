import 'package:easy_wallet_app/providers/auth_provider.dart';
import 'package:easy_wallet_app/screens/navbar.dart';
import 'package:easy_wallet_app/screens/rechargewallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});
  String maskPhoneNumber(String phone) {
    if (phone.length <= 4) {
      return phone;
    }

    return "${'*' * (phone.length - 4)}${phone.substring(phone.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 15,
        leadingWidth: 5,
        leading: SizedBox(),
        title: const Text(
          "Easy Wallet",
          style: TextStyle(
            color: Color(0xff007A33),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black87,
              size: 30,
            ),
          ),

          const CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),

            child: Column(
              children: [
                //---------------------------------------
                // Wallet Card
                //---------------------------------------
                Container(
                  height: 220,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),

                    gradient: const LinearGradient(
                      colors: [Color(0xff163A69), Color(0xff05151B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          "CURRENT BALANCE",
                          style: TextStyle(
                            color: Colors.white70,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "PKR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            SizedBox(width: 12),

                            Selector<Userprovider, double?>(
                              selector: (_, provider) =>
                                  provider.user?.walletBalance,
                              builder: (context, balance, child) {
                                return Text(
                                  (balance ?? "0.0").toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        const Spacer(),

                        Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,

                              decoration: BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white38),
                              ),

                              child: const Icon(
                                Icons.contactless,
                                color: Colors.white,
                              ),
                            ),

                            const Spacer(),

                            Selector<Userprovider, String?>(
                              selector: (p0, provider) => provider.user?.phone,
                              builder: (context, phone, child) {
                                return Text(
                                  maskPhoneNumber(phone ?? "0000000"),
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 22,
                                    letterSpacing: 3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                //---------------------------------------
                // Recharge Button
                //---------------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RechargeWalletScreen(),
                        ),
                      );
                    },

                    icon: const Icon(Icons.add, size: 34, color: Colors.white),

                    label: const Text(
                      "Recharge",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007A33),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _actionCard(
                        icon: Icons.near_me,
                        title: "Send Money",
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: _actionCard(
                        icon: Icons.receipt,
                        title: "Pay Bills",
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: _actionCard(
                        icon: Icons.description,
                        title: "Request",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff13233C),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Navbar(index: 1)),
                        );
                      },

                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: Color(0xff007A33),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                transactionCard(
                  icon: Icons.account_balance_wallet_outlined,
                  iconBg: const Color(0xffE6FFF0),
                  title: "Wallet Recharge",
                  date: "Oct 24, 2023",
                  amount: "+PKR 2,000",
                  amountColor: Colors.green,
                ),

                const SizedBox(height: 18),

                transactionCard(
                  icon: Icons.phone_android,
                  iconBg: const Color(0xffEAF2FF),
                  title: "Zong Super Card",
                  date: "Oct 22, 2023",
                  amount: "-PKR 999",
                  amountColor: const Color(0xff13233C),
                ),

                const SizedBox(height: 18),

                transactionCard(
                  icon: Icons.shopping_basket_outlined,
                  iconBg: const Color(0xffEAF2FF),
                  title: "Khyber Store",
                  date: "Oct 20, 2023",
                  amount: "-PKR 1,250",
                  amountColor: const Color(0xff13233C),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionCard({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String date,
    required String amount,
    required Color amountColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(25),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: iconBg,

            child: Icon(icon, color: const Color(0xff007A33), size: 34),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  date,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 24,
                  color: amountColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xffDDFBE7),
                  borderRadius: BorderRadius.circular(25),
                ),

                child: const Text(
                  "SUCCESS",
                  style: TextStyle(
                    color: Color(0xff007A33),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionCard({required IconData icon, required String title}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: .12),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(icon, color: const Color(0xff007A33), size: 35),
              ),
              SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff007A33),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
