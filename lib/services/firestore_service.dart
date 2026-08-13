import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_wallet_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  FirestoreServices._();

  static final FirestoreServices instance = FirestoreServices._();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> createUser({required AppUser appuser}) async {
    final user = _auth.currentUser!;

    await _firestore.collection("users").doc(user.uid).set({
      "name": appuser.name,

      "phone": appuser.phone,

      "walletBalance": appuser.walletBalance,

      "createdAt": FieldValue.serverTimestamp(),
    });
  }
  Future<bool> checkDoc(bool isSignUp)async{
    final uid =  _auth.currentUser;             
           final doc = await _firestore.collection("users").doc(uid!.uid).get();
        if(isSignUp){
                 
              if(doc.exists){
               _auth.signOut();
              //  return true;
               }
               else{
                   return false;
               }          
         }
        else{
                if(!doc.exists){
                    _auth.signOut();
                     return false;
                }
        }
       return true;
     
  }

   Future<AppUser?> getUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();
          if(querySnapshot.data() == null){
                  return null;
          }
      return AppUser.fromMap(querySnapshot.data()!);
    }
    return null;
  }


 
}
