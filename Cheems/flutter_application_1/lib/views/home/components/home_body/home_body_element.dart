import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/views/home/components/home_body/list_plant_card.dart';
import 'package:get/get.dart';

final _settingController = Get.find<SettingController>();

class HomeBodyElement extends StatelessWidget {
  HomeBodyElement({Key? key, required this.index}) : super(key: key);

  final controller = Get.find<HomeController>();
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _settingController.kDefaultPadding / 2),
          child: GestureDetector(
            onTap: () {
              controller.typeIndex.value = index + 1;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TitleWithCustomUnderline(
                  text: controller.listType[index].name,
                ),
                Icon(Icons.more_rounded,color: _settingController.kPrimaryColor.value.withOpacity(0.4),)
              ],
            ),
          ),
        ),
        ListPlantCard(index: index),
      ],
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(left: _settingController.kDefaultPadding / 4),
            child: Text(
              "${this.text}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() => Container(
                  margin: EdgeInsets.only(
                      right: (_settingController.kDefaultPadding) / 4),
                  height: 7,
                  color:
                      _settingController.kPrimaryColor.value.withOpacity(0.2),
                )),
          )
        ],
      ),
    );
  }
}
