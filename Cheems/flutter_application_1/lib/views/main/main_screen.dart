import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/views/StockChart/chartBuilder.dart';
import 'package:flutter_application_1/views/favorite/fav_link.dart';
import 'package:flutter_application_1/views/home/home_link.dart';
import 'package:flutter_application_1/views/person/person_link.dart';
import 'package:flutter_application_1/views/weather/weather_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

final _settingController = Get.find<SettingController>();

// ignore: must_be_immutable
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
                      : (_mainController.currentIndex.value == 2)
                          ? WeatherView()
                          : (_mainController.currentIndex.value == 3)
                              ? Chart()
                              : (_mainController.currentIndex.value == 4)
                                  ? PersonLink()
                                  : Container(
                                      color: _settingController
                                          .kPrimaryColor.value
                                          .withOpacity(.1),
                                      child: Center(
                                        child: Text("Underdevelopment"),
                                      ),
                                    )),
            ),
            bottomNavigationBar:
                Obx(() => myBar(_mainController.currentIndex.value)),
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
                          child: Image.asset(
                              "assets/images/ponl.gif"),
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
      selectedColor: _settingController.kPrimaryColor.value,
      strokeColor: _settingController.kPrimaryColor.value,
      unSelectedColor: Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.favorite),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.cloud),
        ),
        CustomNavigationBarItem(
           icon: Icon(Icons.shopping_cart),
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
