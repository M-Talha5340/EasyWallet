import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Easy Wallet",
          style: TextStyle(
            color: Color(0xff007A33),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payments",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Color(0xff13233D),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Easily send money and pay your bills in\nseconds.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            //======================
            // Send Money Card
            //======================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xff07244D),
                borderRadius: BorderRadius.circular(28),
              ),

              child: Row(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Color(0xff59F27B),
                      size: 40,
                    ),
                  ),

                  const SizedBox(width: 20),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Send Money",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "To any bank or wallet",
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white30,
                    size: 36,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            //==================
            // Two Small Cards
            //==================
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: const Color(0xffEAF8EF),
                          child: Icon(
                            Icons.receipt_long,
                            color: Colors.green.shade700,
                            size: 28,
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          "Pay Bills",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Utilities & more",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: const Color(0xffEEF2FF),
                          child: Icon(
                            Icons.smartphone,
                            color: Colors.indigo.shade300,
                            size: 28,
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          "Mobile Top-up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Instant credit",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            //===================
            // Request Money Card
            //===================
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffDDF8E5),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.green.shade700,
                    child: const Icon(
                      Icons.request_page,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Request Money",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Generate a secure payment link",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            //==================
            // Frequent Contacts
            //==================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Frequent Contacts",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  contactAvatar(icon: Icons.add, name: "New"),

                  contactAvatar(
                    image: "https://i.pravatar.cc/150?img=1",
                    name: "Zoya",
                  ),

                  contactAvatar(
                    image: "https://i.pravatar.cc/150?img=12",
                    name: "Hamza",
                  ),

                  contactAvatar(
                    image: "https://i.pravatar.cc/150?img=25",
                    name: "Mariam",
                  ),

                  contactAvatar(
                    image: "https://i.pravatar.cc/150?img=35",
                    name: "Ali",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            //=========================
            // Popular Billers Heading
            //=========================
            const Text(
              "Popular Billers",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // K-Electric
            billCard(
              icon: Icons.flash_on,
              iconColor: Colors.black,
              iconBg: const Color(0xffF8F8F8),
              title: "K-Electric",
              subtitle: "Electricity Utility",
            ),

            const SizedBox(height: 18),

            // PTCL
            billCard(
              icon: Icons.wifi,
              iconColor: Colors.green.shade700,
              iconBg: const Color(0xffEAF8EF),
              title: "PTCL Broadband",
              subtitle: "Internet & Phone",
            ),

            const SizedBox(height: 18),

            // FBR
            billCard(
              icon: Icons.account_balance,
              iconColor: Colors.red.shade700,
              iconBg: const Color(0xffFFF4F4),
              title: "FBR Tax Payment",
              subtitle: "Government Services",
            ),

            const SizedBox(height: 18),

            // SSGC
            billCard(
              icon: Icons.water_drop_outlined,
              iconColor: Colors.blueGrey,
              iconBg: const Color(0xffF4F6FA),
              title: "SSGC",
              subtitle: "Sui Southern Gas",
            ),            
          ],
        ),
      ),
    );
  }

  Widget billCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: iconBg,
            child: Icon(icon, color: iconColor, size: 30),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                ),
              ],
            ),
          ),

          Icon(Icons.chevron_right, size: 34, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget contactAvatar({String? image, IconData? icon, required String name}) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: image != null ? NetworkImage(image) : null,
            child: image == null
                ? Icon(icon, size: 35, color: Colors.grey.shade700)
                : null,
          ),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
