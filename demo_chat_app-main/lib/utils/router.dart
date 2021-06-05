import 'package:demo_chat_app/views/login/LoginSreen.dart';
import 'package:get/get.dart';

class PageRouter {
  static final route = [
    GetPage(
      name: '/loginView',
      page: () => LoginScreen(),
    ),
  ];
}
