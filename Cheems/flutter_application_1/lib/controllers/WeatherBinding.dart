import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/ForecastController.dart';
import 'package:flutter_application_1/services/ForecastService.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    //Service
    Get.put(ForecastService());
    Get.put(ForecastController());
  }
}
