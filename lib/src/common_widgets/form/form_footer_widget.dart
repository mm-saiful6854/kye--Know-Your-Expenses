import 'package:flutter/material.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';


class FormFooterWidget extends StatelessWidget {
  const FormFooterWidget({
    Key? key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            label: const Text(mSignInWithGoogle),
            onPressed: () {},
            icon: const Image(
              image: AssetImage(mGoogleLogoImage),
              width: 30.0,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text.rich(
            TextSpan(
              text: mDontHaveAnAccount,
              style: Theme.of(context).textTheme.bodyText1,
              children: const [
                TextSpan(
                  text: mSignUp,
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