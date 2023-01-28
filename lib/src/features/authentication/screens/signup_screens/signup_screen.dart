import 'package:flutter/material.dart';
import 'package:kye/src/constants/image_strings.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/constants/text_strings.dart';
import 'package:kye/src/features/authentication/controllers/signup_controller.dart';
import 'package:kye/src/features/authentication/screens/signup_screens/signup_footer_widget.dart';
import 'package:kye/src/features/authentication/screens/signup_screens/signup_form.dart';

import '../../../../common_widgets/form/form_header_widget.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(mDefaultSize),
            child: Column(
              children: [
                FormHeaderWidget(
                  title: mSignUpTitle,
                  subtitle: mSignUpSubTitle,
                  image: mSignInImage,
                ),
                const SignUpForm(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
