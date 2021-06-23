import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/views/home/components/home_body/list_plant_card.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';

class HomeBodyElement extends StatelessWidget {
  HomeBodyElement({
    Key? key,
   required this.index}
  ) : super(key: key);

  final controller = Get.find<HomeController>();
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
          child: Row(
            children: <Widget>[
              TitleWithCustomUnderline(
                text:  controller.listType[index].name,
              ),
              Spacer(),
              // ignore: deprecated_member_use
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: kPrimaryColor,
                  onPressed: () {
                      controller.typeIndex.value = index + 1;
                    },
                  child: Text(
                    "Xem thêm",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
        ListPlantCard(topic: controller.listType[index].name),
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
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              "${this.text}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
