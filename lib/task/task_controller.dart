import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_game/task/first_tap_widget.dart';
import 'package:odc_game/task/second_tap_widget.dart';

class TaskController extends GetxController {
  List<Widget> tabScreens = [FirstTapBarWidget(), TabBarReviewsWidget()];
PageController pageController=PageController();
  int pageViewSelectedIndex = 0;

  void pageTapped(int index) {
    pageViewSelectedIndex = index;

    update();
  }
}
