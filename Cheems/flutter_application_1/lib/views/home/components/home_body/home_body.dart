import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:get/get.dart';
import 'header_with_search_box.dart';
import 'home_body_element.dart';

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
        HeaderWithSearchBox(),
        Container(
          child: (controller.listType.isNotEmpty)
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.listType.length,
                  itemBuilder: (context, index) => 
                      HomeBodyElement( index: index,))
              : Container(
                  height: 50,
                  child:
                      Center(child: Text("Can't load news. Please try later"))),
        )
      ],
    );
  }
}

