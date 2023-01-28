import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kye/src/features/authentication/screens/login_screens/login_screen.dart';
import 'package:kye/src/repository/authentication_repository/authentication_repository.dart';
import 'package:kye/src/repository/user_repository/user_repository.dart';

import '../models/user_model.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phoneNo = TextEditingController();

  final _userRepo = Get.put(UserRepository());


  //cal this function from design & it will do the rest
  void registerUser(String email, String password){
      String? error = AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
      if(error!=null){
        Get.showSnackbar(GetSnackBar(message: error.toString(),));
      }
  }

  void createUser(UserModel user){
    _userRepo.createUser(user);
    registerUser(user.email, user.password);
    Get.offAll(()=> LoginScreen());
  }

}