import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kye/src/constants/colors.dart';
import 'package:kye/src/constants/image_strings.dart';
import 'package:kye/src/constants/text_strings.dart';
import 'package:kye/src/features/authentication/controllers/on_boarding_controller.dart';
import 'package:kye/src/features/authentication/models/on_boarding_model.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'on_boarding_page_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  int currentPage =0;

  final controller = LiquidController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final obController = OnBoardingController();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
              pages: [
                OnBoardingPageWidget(
                    model: OnBoardingModel(
                        image: mOnBoardingImage1,
                        title: mOnBoardingTitle1,
                        subTitle: mOnBoardingSubTitle1,
                        counterText: mOnBoardingCounter1,
                        bgColor: mOnBoardingPage1Color,
                        size: size.height)),
                OnBoardingPageWidget(
                    model: OnBoardingModel(
                        image: mOnBoardingImage2,
                        title: mOnBoardingTitle2,
                        subTitle: mOnBoardingSubTitle2,
                        counterText: mOnBoardingCounter2,
                        bgColor: mOnBoardingPage2Color,
                        size: size.height)),
                OnBoardingPageWidget(
                    model: OnBoardingModel(
                        image: mOnBoardingImage3,
                        title: mOnBoardingTitle3,
                        subTitle: mOnBoardingSubTitle3,
                        counterText: mOnBoardingCounter3,
                        bgColor: mOnBoardingPage3Color,
                        size: size.height)),
              ],
              onPageChangeCallback: obController.onPageChangeCallBack,
              liquidController: obController.controller,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              enableSideReveal: true),
          Positioned(
            bottom: 40.0,
            child: OutlinedButton(
              child: Container(
                child: Icon(Icons.arrow_forward_ios),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color(0xff272727), shape: BoxShape.circle),
              ),
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.black26),
                shape: CircleBorder(),
                padding: EdgeInsets.all(8),
                foregroundColor: Colors.white,
              ),
              onPressed: obController.animateToNextSlide,
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: TextButton(
              onPressed: obController.skip,
              child: Text("Skip", style: TextStyle(color: Colors.grey)),
            ),
          ),
          Obx (
            ()=> Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                count: 3,
                activeIndex: obController.currentPage.value,
                effect: WormEffect(
                  activeDotColor: Color(0xff272727),
                  dotHeight: 5.0,
                ),
              ),),
          )
        ],
      ),
    );
  }


}
