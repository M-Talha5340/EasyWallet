import 'package:flutter/material.dart';

class WalletBottomBar extends StatelessWidget {
  final int selectedIndex ;
  final Function(int) onItemTapped;
  const WalletBottomBar({super.key,required this.selectedIndex,required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black12,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,        
        children:  [
          bottomItem(
            icon: Icons.account_balance_wallet_outlined,
            title: "Wallet",
            index: 0
          ),
          bottomItem(
            icon: Icons.history,
            title: "History",
            index: 1,
          ),
          bottomItem(
            icon: Icons.payments_outlined,
            title: "Payments",
            index: 2,
          ),
          bottomItem(
            icon: Icons.settings_outlined,
            title: "Settings",
            index: 3,
          ),
        ],
      ),
    );
  }

Widget bottomItem({
    required IconData icon,
    required String title,
    required int index
  }) {        
        bool selected = selectedIndex == index;        
    return InkWell(
      onTap: () => onItemTapped(index),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xffDFF8E8)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: selected
                      ? const Color(0xff007A33)
                      : Colors.grey.shade700,
                  size: 28,
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: selected
                        ? const Color(0xff007A33)
                        : Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}