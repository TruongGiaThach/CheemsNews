import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:get/get.dart';

class NavTitle extends StatelessWidget {
  NavTitle({
    Key? key,
    required this.text,
  }) : super(key: key);
  final int text;

  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {controller.typeIndex.value = text + 1},
      child: Text(
        controller.listType[text].name,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
