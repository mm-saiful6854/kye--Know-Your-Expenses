import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kye/firebase_options.dart';
import 'package:kye/src/features/authentication/screens/login_screens/login_screen.dart';
import 'package:kye/src/features/authentication/screens/on_boarding_screens/on_boarding_screen.dart';
import 'package:kye/src/features/authentication/screens/signup_screens/signup_screen.dart';
import 'package:kye/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:kye/src/features/authentication/screens/welcome_screens/welcome_screen.dart';
import 'package:kye/src/features/core/screens/dashboard/dashboard.dart';
import 'package:kye/src/features/core/screens/expesnses/add_expense_screen.dart';
import 'package:kye/src/features/core/screens/profile/profile_screen.dart';
import 'package:kye/src/repository/authentication_repository/authentication_repository.dart';
import 'package:kye/src/utils/theme/theme.dart';
import 'package:provider/provider.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  /*runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: MAppTheme.lightTheme,
      darkTheme: MAppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      title: 'KYE',
      home: WelcomeScreen(),
    );
  }
}
