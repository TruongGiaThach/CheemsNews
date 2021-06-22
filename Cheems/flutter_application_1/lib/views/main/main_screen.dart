import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/FavoriteController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/views/favorite/fav_link.dart';
import 'package:flutter_application_1/views/home/home_link.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

class MainScreen extends StatelessWidget {
  var _authenticController = Get.find<AuthenticController>();
  final _mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _authenticController.initilizeFirebase(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("Error!")));
        }

        // Once complete, show your application
        else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            extendBody: true,
            body: SafeArea(
              child: Obx(() => (_mainController.currentIndex.value == 0)
                  ? HomeLink()
                  : (_mainController.currentIndex.value == 1)
                      ? FavoriteLink()
                      : Center(
                          child: Text("Underdevelopment"),
                        )),
            ),
            bottomNavigationBar: Obx(() => myBar(_mainController
                .currentIndex.value)), //buildBottomNavigationBar(context),
          );
        } else
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset("assets/images/tmpIcon.png")),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "CheemsNews",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Lottie.asset(
                              "assets/images/factoryAnimation.json"),
                        ),
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("Initilizing..."),
                      ],
                    ),
                  ),
                  SizedBox(height: 40)
                ],
              ),
            ),
          );
      },
    );
  }

  CustomNavigationBar myBar(int i) {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: kPrimaryColor,
      strokeColor: Color(0x30040307),
      unSelectedColor: Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.search),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_circle),
        ),
      ],
      currentIndex: i,
      onTap: (index) {
        _mainController.currentIndex.value = index;
      },
    );
  }
}
