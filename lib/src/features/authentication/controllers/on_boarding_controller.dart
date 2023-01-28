import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnBoardingController extends GetxController{
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  void skip(){
    controller.jumpToPage(page: 2);
  }
  void onPageChangeCallBack(int activePageIndex) {
    print(activePageIndex);
    currentPage.value = activePageIndex;
  }

  void animateToNextSlide(){
    int nextPage = controller.currentPage+1;
    controller.animateToPage(page: nextPage);
  }

}