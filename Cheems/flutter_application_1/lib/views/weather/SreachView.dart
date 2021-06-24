import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/ForecastController.dart';

class SearchView extends StatelessWidget {
  final controller = Get.find<ForecastController>();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
        padding: EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 00),
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Expanded(
                child: TextField(
              controller: controller.citycontroller.value,
              focusNode: controller.focusnode,
              decoration: InputDecoration.collapsed(hintText: "Enter City"),
              onChanged: (value) {
                controller.cityview.value = value;
              },
            )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: new Icon(Icons.search),
                onPressed: () async {
                  controller.focusnode.unfocus();
                  await controller.getLatestWeather(controller.cityview.value);
                },
              ),
            ),
          ],
        ));
  }
}
