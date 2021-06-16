import 'package:flutter_application_1/views/home/home_link.dart';
import 'package:flutter_application_1/views/login/LoginSreen.dart';
import 'package:flutter_application_1/views/main/main_screen.dart';
import 'package:get/get.dart';

class PageRouter {
  static final route = [
    GetPage(
      name: '/loginView',
      page: () => LoginScreen(),
    ),
    GetPage(name: '/mainView', page: ()=>MainScreen())
  ];
}
