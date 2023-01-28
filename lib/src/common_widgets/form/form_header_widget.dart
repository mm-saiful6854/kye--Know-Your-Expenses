

import 'package:flutter/material.dart';


class FormHeaderWidget extends StatelessWidget {
  FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    this.subtitle,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start
  }) : super(key: key);

  String title, image;
  String? subtitle="";
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: this.crossAxisAlignment,
        children: [
          Image(
              image: AssetImage(image),
              height: size.height * 0.2),
          Text(
            title,
            textAlign: this.textAlign,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            subtitle!,
            textAlign: this.textAlign,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ]);
  }
}