
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kye/src/features/authentication/screens/login_screens/login_screen.dart';

import '../../../../constants/image_strings.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(mGoogleLogoImage),
              width: 30.0,
            ),
            label: const Text("Sign Up with google"),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Get.to(()=> LoginScreen());
          },
          child: Text.rich(
            TextSpan(
              text: "Already have an Account?",
              style: Theme.of(context).textTheme.bodyText1,
              children: const [
                TextSpan(
                  text: " Login",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

