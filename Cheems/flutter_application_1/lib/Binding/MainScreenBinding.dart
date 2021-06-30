import 'package:flutter_application_1/controllers/AnalyticController.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/CalendarController.dart';
import 'package:flutter_application_1/controllers/FavoriteController.dart';
import 'package:flutter_application_1/controllers/ForecastController.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/controllers/ReportController.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:flutter_application_1/services/DataService.dart';
import 'package:flutter_application_1/services/ForecastService.dart';
import 'package:flutter_application_1/utils/utilsCalendar.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class mainSrceenBinding extends Bindings {
  @override
  void dependencies() {
    //service
    Get.put(DataService()); //calender Binding
    Get.put(ForecastService());
    //controller
    Get.put(AuthenticController());
    Get.put(HomeController());
    Get.put(MainController());
    Get.put(ReadingController());
    Get.put(FavoriteController());
    Get.put(XuLiEvent()); //calender Binding
    Get.put(calendarController()); //calender Binding
    Get.put(ForecastController()); //Weather Binding
    Get.put(AnalyticController()); //Analytic Binding
  }
}
