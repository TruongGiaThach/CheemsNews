import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/GetNewsController.dart';
import 'package:flutter_application_1/models/Title.dart';
import 'package:get/get.dart';
import 'header_with_search_box.dart';
import 'list_plant_card.dart';
import 'title_with_more_btn.dart';

class BodyHome extends StatelessWidget {
  BodyHome({
    Key? key,
  }) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          HeaderWithSearchBox(
            name: 'Anh Tú',
          ),
          CustomTitleList(
            text: titles[0]
          ),
          CustomTitleList(
            text: titles[1]),
          CustomTitleList(
            text: titles[2]
          
          ),
          CustomTitleList(
            text: titles[3]
          
          ),
        ],
      ),
    );
  }
}

class CustomTitleList extends StatelessWidget {
  CustomTitleList({Key? key, required this.text}) : super(key: key);

  final String text;
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithMoreBtn(
          title: text,
          press: () {},
        ),
        ListPlantCard(topic: text),
      ],
    );
  }
}
