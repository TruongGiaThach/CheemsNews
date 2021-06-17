import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';

import 'package:flutter_application_1/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/homedemo/Thumbnail.dart';

import 'package:flutter_application_1/views/widgets.dart';
import 'package:get/get.dart';
/*
class HomeScreen extends StatelessWidget {
  final _homeController = Get.put(HomeController());
  final _authController = Get.put(AuthenticController());
  late myUser _user;
  late int _signInType;
  HomeScreen(myUser user, int signInType) {
    _user = user;
    _signInType = signInType;
  } //1 - gg sign in  2- fb sign in
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.network(
                          _user.photoUrl,
                          height: 50,
                          width: 50,
                          fit: BoxFit.scaleDown,
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        _user.displayName,
                        style: textFieldTextStyle(),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        if (_signInType == 1)
                          _authController.signOutGoogle();
                        else if (_signInType == 2)
                          _authController.signOutFacebook();
                      },
                      child: new Icon(
                        Icons.logout_outlined,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(children: [
          GestureDetector(
            onTap: () => {
              _showPicker(context),
            },
            child: Column(children: [
              CircleAvatar(
                backgroundColor: Colors.cyan[100],
                radius: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: Image.network(
                    _user.photoUrl,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () => {_homeController.getListThumb()},
            child: Image.asset("assets/images/userIcon.png"),
          ),
          Obx(
            () => (_homeController.isDataChange.value)
                ? Expanded(
                    child: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _homeController.listThumb.length,
                          itemBuilder: (context, index) {
                            return ThumbnailView(
                                _homeController.listThumb[index]);
                          }),
                    ),
                  )
                : Container(),
          ),
        ]),
      ),
    );
  }
}
*/