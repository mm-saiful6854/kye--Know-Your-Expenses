import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kye/src/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginWithEmailAndPassword(String email, String password){
    AuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password);
  }

}