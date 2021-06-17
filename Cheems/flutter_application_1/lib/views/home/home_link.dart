
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/views/home/components/typeNewsViews/listTypeViews.dart';
import 'package:flutter_application_1/views/home/components/typeNewsViews/typeNewsViews.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'components/home_body.dart';

class HomeLink extends StatelessWidget {
  HomeLink({
    Key? key,
  }) : super(key: key);
  final _homeController = Get.put( HomeController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        // ignore: deprecated_member_use
        leading: FlatButton(
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {
            _homeController.typeIndex.value = 0;
          },
        ),
        backgroundColor: kPrimaryColor,
        actions: [
          Container(
            height: 20,
            width: size.width * .85,
            child: ListView.builder(
              itemCount: _homeController.listType.length,
              itemBuilder: (context, index) => NavTitle(
                text: _homeController.listType[index].name,
                press: changeIndex(index + 1),
              ),
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
      body: Obx(() => (_homeController.typeIndex.value == 0)
          ? BodyHome()
          : TypeNewsViews(
              typeNews: _homeController
                  .listType[_homeController.typeIndex.value - 1].name)),
    );
  }

  changeIndex(int i) {
    _homeController.typeIndex.value = i;
  }
}
