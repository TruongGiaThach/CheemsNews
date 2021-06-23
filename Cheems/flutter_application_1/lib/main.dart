import 'package:flutter_application_1/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'Binding/MainScreenBinding.dart';

void main() {
  timeDilation = 2.0;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return GetMaterialApp(
      title: 'Demo Login',
      initialBinding: mainSrceenBinding(),
      smartManagement: SmartManagement.keepFactory,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      getPages: PageRouter.route,
      initialRoute: '/mainView',
    );
  }
}
