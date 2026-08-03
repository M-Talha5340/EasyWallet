
import 'package:easy_wallet_app/screens/history.dart';
import 'package:easy_wallet_app/screens/payment.dart';
import 'package:easy_wallet_app/screens/setting.dart';
import 'package:easy_wallet_app/screens/wallet_screen.dart';
import 'package:easy_wallet_app/widgets/customnavbar.dart';
import 'package:flutter/material.dart';


class Navbar extends StatefulWidget {  
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<Navbar> {
 
  int selectedIndex = 0;

   late List<Widget> screens ;

    // AppBar buildAppBar(){
    //   if (selectedIndex == 0 || selectedIndex == 1 ){
    //       return AppBar(
    //     title: const Text(
    //       "TaskFlow",
    //       style: TextStyle(
    //         fontSize: 34,
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff0D47A1),
    //       ),
    //     ),
       
    //     actions: [                  
    //             //  Selector<Userprovider, String?>(
    //             //                selector: (_, provider) => provider.user!.profileimg,              
    //             //                builder: (context, imgurl, child) {                
    //             //                  return  CircleAvatar(
    //             //     radius: 30,
    //             //     backgroundImage: imgurl != null
    //             //         ? NetworkImage(imgurl)
    //             //         : null,
    //             //     child: imgurl == null
    //             //         ? const Icon(Icons.person, size: 50, color: Color.fromARGB(255, 94, 92, 92))
    //             //         : null,
                  
    //             //                  );
    //             //                },
    //             //              ),
         
    //     ],
    //   );
    //   }
    //     return   AppBar(
    //     title: const Text(
    //       "T",
    //       style: TextStyle(
    //         fontSize: 34,
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff0D47A1),
    //       ),
    //     ),
       
    //     actions: [
    //         PopupMenuButton<String>(            
    //         position: PopupMenuPosition.under,
    //         shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10),
    //         ),            
    //         offset: Offset(0,12),
    //         iconColor: Color(0xff0D47A1),              
    //         color: Colors.white,
    //         iconSize: 30,                        
    //         onSelected: (value) async{
    //           if (value == "Logout"){
    //              context.read<Taskprovider>().clear();
    //                   context.read<Userprovider>().clearUser();
    //                   await FirebaseAuth.instance.signOut();
    //           }
    //         },
    //         itemBuilder: (context) => [              
    //           PopupMenuItem(
    //             value: "Logout",                
    //             child: Row(
    //               children: [
    //                 Icon(Icons.logout,color:Color(0xff0D47A1),),                    
    //                 SizedBox(width: 10),
    //                 Text("Logout ",style: TextStyle(color: Color(0xff0D47A1)),),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
  
                  
    //     ],
    //   );
      
    // }   
    
    @override
   void initState(){
        super.initState();
        screens =[WalletScreen(),HistoryScreen(),PaymentScreen(),SettingScreen()];
   }
   
  @override
  Widget build(BuildContext context) {    
    return Scaffold(             
      bottomNavigationBar: WalletBottomBar(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),     
       backgroundColor: const Color(0xffF5F6FC),      
      body: screens[selectedIndex], 
    
    );
  }
}
