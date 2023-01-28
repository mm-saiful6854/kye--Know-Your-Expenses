import 'package:get/get.dart';
import 'package:kye/src/repository/authentication_repository/authentication_repository.dart';
import 'package:kye/src/repository/user_repository/user_repository.dart';

import '../../authentication/models/user_model.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());


  getLoggedInUserInfo(){
    return _authRepo.getLoggedInUserData();
  }
}