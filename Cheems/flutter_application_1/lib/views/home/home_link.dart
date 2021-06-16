import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/GetNewsController.dart';
import 'package:flutter_application_1/models/Title.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../widgets.dart';
import 'components/home_body.dart';

class HomeLink extends StatelessWidget {
  HomeLink({
    Key? key,
  }) : super(key: key);
  final _homeController = Get.put(HomeController());
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
          onPressed: () {},
        ),
        backgroundColor: kPrimaryColor,
        actions: [
          Container(
            height: 20,
            width: size.width * .85,
            //color: Colors.black,
            // ignore: deprecated_member_use
            child: ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) => NavTitle(
                text: titles[index],
              ),
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
      body: BodyHome(),
    );
  }
}
