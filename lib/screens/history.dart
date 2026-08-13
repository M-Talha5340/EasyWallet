import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedFilter = 0;

  final List<String> filters = ["All", "Income", "Cashback"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Easy Wallet",
          style: TextStyle(
            color: Color(0xff067A2F),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Search Bar
            Container(
              height: 60,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),

                border: Border.all(color: Colors.grey.shade300),
              ),

              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,

                  prefixIcon: Icon(Icons.search),

                  hintText: "Search transactions...",

                  hintStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 45,

              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,

                itemCount: filters.length,

                separatorBuilder: (_, index) => const SizedBox(width: 12),

                itemBuilder: (context, index) {
                  final selected = selectedFilter == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = index;
                      });
                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),

                      padding: const EdgeInsets.symmetric(horizontal: 24),

                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xff067A2F)
                            : const Color(0xffEEF2FA),

                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Center(
                        child: Text(
                          filters[index],

                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black54,

                            fontWeight: FontWeight.bold,

                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),
            const Text(
              "TODAY",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 20),

            _transactionCard(
              icon: Icons.shopping_bag_outlined,
              iconBg: Color(0xffFFEAEA),
              iconColor: Colors.red,
              title: "Khaadi Retail",
              subtitle: "02:45 PM • Lifestyle",
              amount: "-Rs. 12,500",
              amountColor: Color(0xff102A43),
              status: "COMPLETED",
              statusColor: Color(0xff067A2F),
            ),

            const SizedBox(height: 15),

            _transactionCard(
              icon: Icons.account_balance_wallet_outlined,
              iconBg: Color(0xffE9F8EC),
              iconColor: Color(0xff067A2F),
              title: "Salary Deposit",
              subtitle: "09:12 AM • Income",
              amount: "+Rs. 185,000",
              amountColor: Color(0xff067A2F),
              status: "COMPLETED",
              statusColor: Color(0xff067A2F),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  Widget _transactionCard({

  required IconData icon,

  required Color iconBg,

  required Color iconColor,

  required String title,

  required String subtitle,

  required String amount,

  required Color amountColor,

  required String status,

  required Color statusColor,

}) {

  return Container(

    padding: const EdgeInsets.all(5),

    decoration: BoxDecoration(

      color: Colors.white,

      borderRadius: BorderRadius.circular(22),

      border: Border.all(
        color: Colors.grey.shade300,
      ),

      boxShadow: [

        BoxShadow(
          color: Colors.black.withValues(alpha: .04),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),

      ],

    ),

    child: Row(

      children: [

        Container(

          height: 70,

          width: 70,

          decoration: BoxDecoration(

            color: iconBg,

            shape: BoxShape.circle,

          ),

          child: Icon(
            icon,
            color: iconColor,
            size: 34,
          ),

        ),

        const SizedBox(width: 18),

        Expanded(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff102A43),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),

            ],

          ),

        ),

        Column(

          crossAxisAlignment:
              CrossAxisAlignment.end,

          children: [

            Text(
              amount,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: amountColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              status,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),

          ],

        ),

      ],

    ),

  );

}
}
