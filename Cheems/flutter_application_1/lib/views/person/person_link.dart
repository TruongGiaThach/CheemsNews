import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:get/get.dart';
import 'components/body.dart';

final _settingController = Get.find<SettingController>();

class PersonLink extends StatelessWidget {
  const PersonLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text('Tôi'),
            backgroundColor: _settingController.kPrimaryColor.value,
            centerTitle: true,
            elevation: 1,
          ),
          body: Body(),
        ));
  }
}
