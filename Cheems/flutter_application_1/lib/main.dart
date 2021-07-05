import 'package:flutter_application_1/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'Binding/MainScreenBinding.dart';
import 'controllers/SettingController.dart';

void main() {
  timeDilation = 2.0;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    var _settingController = Get.put(SettingController(), permanent: true);
    return GetMaterialApp(
      title: 'Cheems News',
      initialBinding: mainSrceenBinding(),
      theme: ThemeData(
        scaffoldBackgroundColor: _settingController.kBackgroundColor,
        primaryColor: _settingController.kPrimaryColor.value,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: _settingController.kTextColor),
        primarySwatch: Colors.blue,
      ),
      smartManagement: SmartManagement.keepFactory,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      getPages: PageRouter.route,
      initialRoute: '/mainView',
    );
  }
}
