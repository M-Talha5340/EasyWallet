
import 'package:easy_wallet_app/models/user_model.dart';
import 'package:easy_wallet_app/services/auth_service.dart';
import 'package:easy_wallet_app/services/firestore_service.dart';
import 'package:flutter/material.dart';

class Userprovider extends ChangeNotifier {
  AppUser? _user;
  AppUser? get user => _user;

  Future<void> createUser(AppUser appuser) async {
    try {
      _user = appuser;
      await FirestoreServices.instance.createUser(appuser: appuser);                    
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setUser() async {
    try {
      final user = await FirestoreServices.instance.getUser();
      _user = user;
      if (user != null ){
      }
    } catch (e) {
      rethrow;
    } finally {
      if (_user != null) {
        notifyListeners();
      }
    }
  }

  // Future<void> deleteAccount(String ?password)async {
  //      try{
  //           await FirestoreServices.instance.deleteUser(password);
  //      }catch(_){
  //       rethrow;
  //      }
  // }

  // Future<void> updateUser(AppUser user) async {

  //   try {

  //     await FirestoreServices.instance.updateUser(user);
  //     _user = user;

  //   } catch (e) {
  //     throw Exception( "Failed to Update User");
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  // Future<String> uploadProfileImage(File file)async{
  //    try{
  //       String url = await FirestoreServices.instance.uploadProfileImage(file);
  //       return url;
  //    }
  //    catch(e){
  //      rethrow;
  //    }

  // }
  void clearUser() async {
       _user = null;       
    await AuthService.instance.logoutUser();
  }
}
