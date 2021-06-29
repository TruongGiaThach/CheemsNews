import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/FavoriteController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/views/favorite/fav_item_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

import '../widgets.dart';

class FavoriteLink extends StatelessWidget {
  FavoriteLink({Key? key}) : super(key: key);

  final _settingController = Get.find<SettingController>();
  final controller = Get.find<FavoriteController>();
  final authController = Get.find<AuthenticController>();
  final mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return Obx(() => (_settingController.kPrimaryColor.value != null)
        ? Scaffold(
            backgroundColor:
                _settingController.kPrimaryColor.value.withOpacity(.1),
            appBar: AppBar(
              title: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Yêu thích",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              backgroundColor: _settingController.kPrimaryColor.value,
            ),
            body: Obx(() => (!authController.isGuest.value)
                ? FutureBuilder(
                    future:
                        controller.loadListFav(authController.currentUser!.uid),
                    builder: (context, AsyncSnapshot<List<News>> snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          color: _settingController.kPrimaryColor.value
                              .withOpacity(.1),
                          child: Center(
                            child: Text(
                                "There are some error when load your collection"),
                          ),
                        );
                      }
                      if (snapshot.connectionState ==
                          ConnectionState
                              .done) if (snapshot
                          .hasData) if (snapshot.data!.length != 0) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return FavItem(context, snapshot.data![index]);
                            }); // show list news
                      } else
                        return Container(
                            child: Center(
                          child: Text("You don't have any news in collection"),
                        ));
                      return Center(
                        child: loadingWiget(),
                      );
                    },
                  )
                : Container(
                    color:
                        _settingController.kPrimaryColor.value.withOpacity(.1),
                    child: Center(
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: _settingController.kPrimaryColor.value,
                            onPressed: () {
                              _showGuestSheet(context);
                              mainController.gotoHome();
                            },
                            child: Text(
                              "Login to your collection",
                              style: TextStyle(color: Colors.white),
                            ))))))
        : Center(
            child: Text("Error when load primary color"),
          ));
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
