import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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

                        const Row(
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

                            Text(
                              "5,420.00",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
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

                            const Text(
                              "**** 8824",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 22,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                //---------------------------------------
                // Recharge Button
                //---------------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 72,

                  child: ElevatedButton.icon(
                    onPressed: () {},

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
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _actionCard(icon: Icons.send, title: "Send Money"),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: _actionCard(
                        icon: Icons.receipt_long,
                        title: "Pay Bills",
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: _actionCard(
                        icon: Icons.request_quote,
                        title: "Request",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 45),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionCard({required IconData icon, required String title}) {
    return Column(
      children: [
        Container(
          height: 140,
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

          child: Center(
            child: Icon(icon, color: const Color(0xff007A33), size: 45),
          ),
        ),

        const SizedBox(height: 15),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff3D3D46),
          ),
        ),
      ],
    );
  }
}
