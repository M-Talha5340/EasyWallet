import 'package:easy_wallet_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Easy Wallet",
          style: TextStyle(
            color: Color(0xff007A2F),
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==========================
            // Profile Card
            //==========================
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 15,
                  ),
                ],
              ),

              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/200?img=5",
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.greenAccent,
                          child: Icon(
                            Icons.workspace_premium,
                            color: Colors.green.shade900,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Selector<Userprovider, String?>(
                          selector: (p0, provider) => provider.user?.name,
                          builder: (context, value, child) {
                            return Text(
                              value??"Name",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Founders' Circle • Account Level 3",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffDDF8E5),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.green.shade300),
                          ),
                          child: const Text(
                            "PREMIUM MEMBER",
                            style: TextStyle(
                              color: Color(0xff007A2F),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "ACCOUNT & SECURITY",
              style: TextStyle(
                color: Color(0xff06752D),
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 20),

            _settingCard(
              children: [
                _settingTile(Icons.person_add_alt_1_outlined, "Manage KYC"),
                Divider(height: 0.5, thickness: 0),
                _settingTile(Icons.pin_outlined, "Change PIN"),
              ],
            ),
            const SizedBox(height: 15),

            Text(
              "PREFERENCES",
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 3,
                color: Color(0xff0B7A36),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _settingCard(
              children: [
                _settingTile(
                  Icons.notifications_none,
                  "Notifications",
                  trailingText: "On",
                ),

                Divider(height: 0.5, thickness: 0),

                _settingTile(
                  Icons.language,
                  "Language",
                  trailingText: "Eng(US)",
                ),

                Divider(height: 0.5, thickness: 0),

                _settingTile(
                  Icons.dark_mode_outlined,
                  "Theme",
                  trailingText: "Light",
                ),
              ],
            ),
            const SizedBox(height: 15),

            Text(
              "SUPPORT",
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 3,
                color: Color(0xff0B7A36),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _settingCard(
              children: [
                _settingTile(Icons.help_center, "Help Center"),

                Divider(height: 0.5, thickness: 0),

                _settingTile(Icons.chat_bubble_outline, "Contact Us"),

                Divider(height: 0.5, thickness: 0),

                _settingTile(
                  Icons.dark_mode_outlined,
                  "Theme",
                  trailingText: "Light",
                ),
              ],
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                context.read<Userprovider>().clearUser();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  color: const Color(0xffFFF5F5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: .5),
                      blurRadius: 15,
                      offset: Offset(3, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_outlined, size: 35, color: Colors.red),
                    Text(
                      "LogOut",
                      style: TextStyle(color: Colors.red, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 10),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _settingTile(IconData icon, String title, {String? trailingText}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: const Color(0xffEEF8F0),
        child: Icon(icon, color: const Color(0xff06752D), size: 30),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(color: Colors.black54, fontSize: 17),
            ),
          const SizedBox(width: 10),
          const Icon(Icons.chevron_right, size: 32),
        ],
      ),
    );
  }
}
