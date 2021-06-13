import 'package:flutter_application_1/views/login/LoginSreen.dart';
import 'package:get/get.dart';

class PageRouter {
  static final route = [
    GetPage(
      name: '/loginView',
      page: () => LoginScreen(),
    )
  ];
}
