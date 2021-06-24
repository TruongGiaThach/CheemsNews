import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/FavoriteController.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class mainSrceenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticController());
    Get.put(HomeController());
    Get.put(MainController());
    Get.put(ReadingController());
    Get.put(FavoriteController());
  }
}
