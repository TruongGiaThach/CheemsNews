import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/HomeController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/details/detail_screen.dart';
import 'package:flutter_application_1/views/home/components/home_body/searchPage.dart';
import 'package:flutter_application_1/views/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class HeaderWithSearchBox extends StatelessWidget {
  HeaderWithSearchBox({
    Key? key,
  }) : super(key: key);

  final _settingController = Get.find<SettingController>();

  final authController = Get.find<AuthenticController>();
  final mainController = Get.find<MainController>();
  final homecontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: _settingController.kDefaultPadding * 2.5,
      ),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Obx(() => (!authController.isGuest.value &&
                  authController.currentUser != null)
              ? Container(
                  height: size.height * 0.2 - 27,
                  decoration: BoxDecoration(
                      color: _settingController.kPrimaryColor.value,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: _settingController.kDefaultPadding,
                      right: _settingController.kDefaultPadding,
                      bottom: _settingController.kDefaultPadding * 2,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Cheems News',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/calender');
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: size.height * 0.1,
                          width: size.height * 0.1,
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: PopupMenuButton<int>(
                            offset: Offset(0, size.height * 0.1),
                            padding: EdgeInsets.all(4),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            icon: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                  authController.currentUser!.photoUrl),
                            ),
                            onSelected: (index) {
                              switch (index) {
                                case 1:
                                  mainController.gotoCollection();
                                  break;
                                case 2:
                                  mainController.gotoSetting();
                                  break;
                                case 3:
                                  if (authController.currentUser!.typeAccount ==
                                      1)
                                    authController.signOutGoogle();
                                  else if (authController
                                          .currentUser!.typeAccount ==
                                      2) authController.signOutFacebook();
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text("Colection"),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text("Infor"),
                                value: 2,
                              ),
                              PopupMenuDivider(
                                height: 5,
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Text("Logout"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: size.height * 0.2 - 27,
                  decoration: BoxDecoration(
                      color: _settingController.kPrimaryColor.value,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: _settingController.kDefaultPadding,
                      right: _settingController.kDefaultPadding,
                      bottom: _settingController.kDefaultPadding * 2,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Cheems News',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/calender');
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => _showGuestSheet(context),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            height: size.height * 0.1,
                            width: size.height * 0.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child:
                                  Image.asset('assets/images/guestImage.jpg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: _settingController.kDefaultPadding + 5),
                  height: 54,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: _settingController.kPrimaryColor.value
                                .withOpacity(.23)),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => SearchPage());
                            },
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tìm kiếm",
                                    style: TextStyle(
                                        color: _settingController
                                            .kPrimaryColor.value),
                                  ),
                                  Icon(Icons.search)
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void _showGuestSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
            child: Container(
                child: Obx(
          () => (!authController.isSigningIn.value)
              ? Wrap(
                  children: [
                    Center(
                      child: SignInButtonBuilder(
                        image: Image.asset(
                          "assets/images/googleIcon.png",
                          height: 30,
                          width: 30,
                        ),
                        backgroundColor: Colors.blue[300]!,
                        text: "Continute with Google",
                        onPressed: () => {
                          authController.signInWithGoogle(),
                          Navigator.pop(context),
                        },
                      ),
                    ),
                    Center(
                      child: SignInButton(Buttons.FacebookNew,
                          text: "Continute with Facebook",
                          onPressed: () => {
                                authController.signInWithFacebook(),
                                Navigator.pop(context)
                              }),
                    )
                  ],
                )
              : Wrap(
                  spacing: 20,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Center(child: Text("Hold up, we're signing you in...")),
                  ],
                ),
        )));
      },
    );
  }
}
