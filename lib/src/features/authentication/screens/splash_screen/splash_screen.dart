import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kye/src/common_widgets/animation/fade_in_animation_model.dart';
import 'package:kye/src/constants/colors.dart';
import 'package:kye/src/constants/image_strings.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/constants/text_strings.dart';
import 'package:kye/src/common_widgets/animation/fade_in_animation_controller.dart';


import '../../../../common_widgets/animation/fade_in_animation.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MFadeInAnimation(
              durationInMillisecond: 1600,
              animatePosition: MFadeInAnimatePosition(
                topBefore: -30, topAfter: 0, leftBefore:  -30, leftAfter: 0
              ),
              child: Image(
                image: AssetImage(mSplashTopIcon),
              ),
            ),

            MFadeInAnimation(
              durationInMillisecond: 1600,
              animatePosition: MFadeInAnimatePosition(
                topBefore: 50, topAfter: 120, leftBefore: -80, leftAfter: 30
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(mAppName, style: Theme.of(context).textTheme.headline6),
                Text(MAppTagLine, style: Theme.of(context).textTheme.headline5),
              ]),
            ),

            MFadeInAnimation(durationInMillisecond: 2400,
              animatePosition: MFadeInAnimatePosition(
                bottomBefore: 0, bottomAfter: 100,
              ),
              child: Image(image: AssetImage(mSplashImage), height: screenSize.height*0.5, width:screenSize.width,),),
            Positioned(
              bottom: 30,
              right: mDefaultSize,
              child: Container(
                width: mSplashContainerSize,
                height: mSplashContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: mPrimaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
