import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kye/src/features/authentication/screens/login_screens/login_screen.dart';
import 'package:kye/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:kye/src/features/authentication/screens/welcome_screens/welcome_screen.dart';
import 'package:kye/src/features/core/screens/dashboard/dashboard.dart';
import 'package:kye/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:kye/src/repository/user_repository/user_repository.dart';

import '../../features/authentication/models/user_model.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();
  // variables
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;
  UserModel loggedInUser = UserModel(id:"-1", email: "email", password: "password", fullname: "fullname", phoneNo: "phoneNo", balance: 0.0);

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }


  _setInitialScreen(User? user){
      if(user == null){
        print("setInitialScreen called");
        loggedInUser = UserModel(id:"-1", email: "email", password: "password", fullname: "fullname", phoneNo: "phoneNo",balance: 0.0);

        Get.offAll(()=> WelcomeScreen());
      }else{
        Get.offAll(()=>Dashboard());
      }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print("FIREBASE AUTH EXCEPTION- ${ex.message}");
      throw ex;
    } catch(_){
      final ex = SignUpWithEmailAndPasswordFailure();
      print("EXCEPTION - ${ex.message}");
      throw ex;
    }
  }


  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => Get.snackbar("Success",
          "Login Successful.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.brown.withOpacity(0.1),
          colorText: Colors.black)).catchError((error, stackTrace){
        Get.snackbar("Error", "Something went wrong. try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);

        print(error.toString());
      });

      if(firebaseUser.value !=null){
        loggedInUser = UserModel(id:"-1", email: "email", password: "password", fullname: "fullname", phoneNo: "phoneNo", balance: 0.0);
        var userModel = this.getLoggedInUserData();
        //Get.to(() => Dashboard());
      }else{
        Get.offAll(()=> LoginScreen());
      }

    } on FirebaseAuthException catch(e){
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print("FIREBASE AUTH EXCEPTION- ${ex.message}");
      throw ex;
    } catch(_){
      final ex = SignUpWithEmailAndPasswordFailure();
      Get.snackbar("Error", ex.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("EXCEPTION - ${ex.message}");
      throw ex;
    }
  }

  // get logged in user details
  Future<UserModel> getLoggedInUserData() async{
    if(loggedInUser==null || loggedInUser.id=="-1"){
      String? email = firebaseUser.value?.email;
      if(email!=null){
        final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
        loggedInUser = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

        print("id: ${loggedInUser.id}\nFullname: ${loggedInUser.fullname}\n Email: ${loggedInUser.email}");
      }
      else{
        Get.snackbar("error", "Login to continue");
      }
    }
    return loggedInUser;
  }

  Future<void> logout() async {
    try{
      await _auth.signOut();
      loggedInUser = UserModel(id:"-1", email: "email", password: "password", fullname: "fullname", phoneNo: "phoneNo");
    } on FirebaseAuthException catch(e){
    } catch(_){}
  }

}