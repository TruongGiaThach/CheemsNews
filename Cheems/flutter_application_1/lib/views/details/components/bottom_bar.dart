import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:flutter_application_1/views/details/components/coment_page.dart';
import 'package:get/get.dart';

Widget buildBottomBar(Color backgroundColor, Color primaryColor) {
  final controller = Get.find<ReadingController>();
  return Obx(() => Wrap(
        children: <Widget>[
          CustomNavigationBar(
            backgroundColor: backgroundColor,
            selectedColor: primaryColor,
            strokeColor: primaryColor,
            currentIndex: controller.bottomIndex.value,
            iconSize: 30,
            onTap: (index) {
              controller.bottomIndex.value = index;
              if (index == 1){
                Get.to(CommentPage());
              }
            },
            items: [
              CustomNavigationBarItem(
                icon: Icon(Icons.format_size_outlined),
              ),
              CustomNavigationBarItem(
                icon: Icon(Icons.comment_bank_outlined),
              ),
              CustomNavigationBarItem(icon: Icon(Icons.ios_share_outlined)),
            ],
          ),
        ],
      ));
}
