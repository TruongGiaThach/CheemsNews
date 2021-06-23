import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:get/get.dart';
import 'header_with_search_box.dart';
import 'list_plant_card.dart';
import 'title_with_more_btn.dart';

class BodyHome extends StatelessWidget {
  BodyHome({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2 + 54 ,
          child: HeaderWithSearchBox(),
        ),
        Container(
          child: (controller.listType.isNotEmpty)
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.listType.length,
                  itemBuilder: (context, index) => 

                  
                      CustomeTitleList(text: controller.listType[index].name))
              : Container(
                  height: 50,
                  child:
                      Center(child: Text("Can't load news. Please try later"))),
        )
      ],
    );
  }
}

class CustomeTitleList extends StatelessWidget {
  CustomeTitleList({Key? key, required this.text}) : super(key: key);

  final String text;
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
