import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import 'fade_in_animation_controller.dart';
import 'fade_in_animation_model.dart';

class MFadeInAnimation extends StatelessWidget {
  MFadeInAnimation({
    Key? key,
    required this.durationInMillisecond,
    required this.child,
    this.animatePosition,
  }) : super(key: key);

  var controller = Get.put(FadeInAnimationController());
  final int durationInMillisecond;
  MFadeInAnimatePosition? animatePosition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedPositioned(
          duration: Duration(milliseconds: durationInMillisecond),
          top: controller.animate.value ? animatePosition!.topAfter : animatePosition!.topBefore,
          right: controller.animate.value ? animatePosition!.rightAfter : animatePosition!.rightBefore,
          bottom: controller.animate.value ? animatePosition!.bottomAfter : animatePosition!.bottomBefore,
          left: controller.animate.value ? animatePosition!.leftAfter : animatePosition!.leftBefore,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: durationInMillisecond),
            opacity: controller.animate.value ? 1 : 0,
            child:child,
          ),
        ));
  }
}
