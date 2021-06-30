import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/MainController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

final _settingController = Get.find<SettingController>();
var _authenticController = Get.find<AuthenticController>();
final _mainController = Get.find<MainController>();

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          child: Obx(() => Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: _settingController.kPrimaryColor.value),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: _authenticController.currentUser != null
                      ? Image.network(
                          _authenticController.currentUser!.photoUrl,
                          width: size.width * .4,
                          fit: BoxFit.fitWidth,
                        )
                      : Image.asset(
                          "assets/images/guestImage.jpg",
                          width: size.width * .4,
                          fit: BoxFit.fitWidth,
                        ),
                ),
              )),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: () {
                _authenticController.currentUser != null
                    ? showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text('LOGOUT'),
                              content: Text('Do you want to logout?'),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Text('No')),
                                TextButton(
                                    onPressed: () {
                                      if (_authenticController
                                              .currentUser!.typeAccount ==
                                          1)
                                        _authenticController.signOutGoogle();
                                      else if (_authenticController
                                              .currentUser!.typeAccount ==
                                          2)
                                        _authenticController.signOutFacebook();
                                    },
                                    child: Text('Yes')),
                              ],
                              elevation: 24,
                            ))
                    : _showGuestSheet(context);
              },
              icon: Icon(
                _authenticController.currentUser != null
                    ? Icons.logout
                    : Icons.login,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _showGuestSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
            child: Container(
                child: Obx(
          () => (!_authenticController.isSigningIn.value)
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
                          _authenticController.signInWithGoogle(),
                          Navigator.pop(context),
                        },
                      ),
                    ),
                    Center(
                      child: SignInButton(Buttons.FacebookNew,
                          text: "Continute with Facebook",
                          onPressed: () => {
                                _authenticController.signInWithFacebook(),
                                Navigator.pop(context),
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
