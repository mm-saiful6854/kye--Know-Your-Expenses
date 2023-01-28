

import 'package:flutter/material.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
              image: AssetImage(mSignInImage),
              height: size.height * 0.2),
          Text(
            mLoginTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            mLoginSubTitle,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ]);
  }
}