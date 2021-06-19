import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:get/get.dart';

class mainSrceenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AuthenticController(), permanent: true);
    Get.put(HomeController());
    Get.put(MainController(), permanent: true);
    Get.put(ReadingController());
  }
}
