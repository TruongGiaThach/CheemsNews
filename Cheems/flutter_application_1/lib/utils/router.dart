import 'package:flutter_application_1/Binding/MainScreenBinding.dart';
import 'package:flutter_application_1/views/main/main_screen.dart';
import 'package:get/get.dart';

class PageRouter {
  static final route = [
    GetPage(
        name: '/mainView',
        page: () => MainScreen(),
        binding: mainSrceenBinding())
  ];
}
