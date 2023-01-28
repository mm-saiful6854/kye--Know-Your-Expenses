
import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../models/on_boarding_model.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({Key? key, required this.model}) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(mDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(model.image), height: model.size * 0.4),
          Column(
              children: [
                Text (
                  model.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text (
                  model.subTitle,
                  textAlign: TextAlign.center,
                )]),
          Text(model.counterText)],
      ),
    );
  }
}
