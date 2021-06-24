import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:get/get.dart';

final _settingController = Get.find<SettingController>();

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: _settingController.kDefaultPadding / 4,
            ),
            child: Text(
              "${this.text}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -3,
            child: Obx(() => Container(
                  margin: EdgeInsets.only(
                      right: _settingController.kDefaultPadding / 4),
                  height: 7,
                  color: _settingController.kPrimaryColor.value.withOpacity(.4),
                )),
          )
        ],
      ),
    );
  }
}
