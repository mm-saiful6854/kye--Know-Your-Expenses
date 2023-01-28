import 'package:get/get.dart';
import 'package:kye/src/features/authentication/screens/on_boarding_screens/on_boarding_screen.dart';
import 'package:kye/src/features/authentication/screens/welcome_screens/welcome_screen.dart';
import 'package:kye/src/repository/authentication_repository/authentication_repository.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();
  RxBool animate = false.obs;


  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 1000));
    print("startSplashAnimation called");
    //Get.to(()=>WelcomeScreen());
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }

}