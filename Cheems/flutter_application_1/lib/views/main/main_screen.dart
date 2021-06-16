import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/views/home/home_link.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

class MainScreen extends StatelessWidget {
  var _authenticController = Get.put(AuthenticController());
  final _mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authenticController.initilizeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text("Error!")));
        }

        // Once complete, show your application
        else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: SafeArea(
              child: Obx(() => (_mainController.currentIndex == 0)
                  ? HomeLink()
                  : HomeLink()),
            ),
            bottomNavigationBar: buildBottomNavigationBar(context),
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

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _mainController.currentIndex.value,
      selectedItemColor: kPrimaryColor,
      backgroundColor: kPrimaryColor.withOpacity(.2),
      selectedFontSize: 16,
      iconSize: 22,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          // ignore: deprecated_member_use
          title: Text('Trang chủ'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          // ignore: deprecated_member_use
          title: Text('Yêu thích'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          // ignore: deprecated_member_use
          title: Text('Cá nhân'),
        ),
      ],
      onTap: (index) {
        _mainController.currentIndex.value = index;
      },
    );
  }
}
