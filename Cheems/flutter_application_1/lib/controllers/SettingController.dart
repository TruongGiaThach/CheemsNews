import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  // Colors that we use in our app
  Rx<Color> kPrimaryColor = Color(0xFF00CC99).obs;
  Color kTextColor = Color(0xFF3C4046);
  Color kBackgroundColor = Color(0xFFF9F8FD);

  double kDefaultPadding = 20.0;

  Rx<int> idDetal = (-1).obs;
  Rx<double> textSize = 14.0.obs;
  Rx<int> textFont = 0.obs;

  Rx<int> idColor = 0.obs;

  RxList<int> kColor = [
    0xFF00CC99,
    0xFF365C95,
    0xFF9999FF,
    0xFFA29B9B,
  ].obs;

  increaseFontSize() {
    if (this.textSize.value < 18)
      this.textSize.value += 1;
    else
      this.textSize.value = 14;
  }
}
