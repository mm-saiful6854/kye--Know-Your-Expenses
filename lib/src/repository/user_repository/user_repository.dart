import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kye/src/repository/authentication_repository/authentication_repository.dart';

import '../../features/authentication/models/user_model.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _authRepo = Get.put(AuthenticationRepository());




  createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson())
        .whenComplete(
            () => Get.snackbar("Success",
              "Your Account hase been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.brown.withOpacity(0.1),
              colorText: Colors.black)
    ).catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong. try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red);

      print(error.toString());
    });
  }


  // fetch User details
  Future<UserModel> getUserDetails(String email) async{
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  //all users
  Future<List<UserModel>> getAllUser() async{
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }


}














