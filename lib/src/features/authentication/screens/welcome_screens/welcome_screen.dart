import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kye/src/constants/colors.dart';
import 'package:kye/src/constants/image_strings.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/constants/text_strings.dart';
import 'package:kye/src/features/authentication/screens/login_screens/login_screen.dart';
import 'package:kye/src/features/authentication/screens/signup_screens/signup_screen.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(mDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
                image: const AssetImage(mWelcomeScreenImage),
                height: size.height * 0.5),
            Column(
              children: [
                Text(
                  mWelcomeTitle,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const Text(mWelcomeSubTitle, textAlign: TextAlign.center),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.to(()=> const LoginScreen()),
                    child: Text(mLogin.toUpperCase()),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(()=> const SignUpScreen()),
                    child: Text(mSignUp.toUpperCase()),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
