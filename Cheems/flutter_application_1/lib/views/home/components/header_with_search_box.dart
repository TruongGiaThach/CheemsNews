import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants.dart';
import '../../widgets.dart';

class HeaderWithSearchBox extends StatelessWidget {
  HeaderWithSearchBox({
    Key? key,
  }) : super(key: key);

  final authController = Get.put(AuthenticController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: kDefaultPadding * 2.5,
      ),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Obx(() => (!authController.isGuest.value &&
                  authController.currentUser != null)
              ? Container(
                  height: size.height * 0.2 - 27,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding * 2,
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
                        GestureDetector(
                          onTap: () => _showUserSheet(context),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                  authController.currentUser!.photoUrl),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: size.height * 0.2 - 27,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding * 2,
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
                        GestureDetector(
                          onTap: () => _showGuestSheet(context),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            height: 70,
                            width: 70,
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(.23)),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Tìm kiếm",
                          hintStyle:
                              TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset("assets/icons/search.svg"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showUserSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.network(
                      authController.currentUser!.photoUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.scaleDown,
                    ),
                  )),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          if (authController.currentUser!.typeAccount == 1)
                            authController.signOutGoogle();
                          else if (authController.currentUser!.typeAccount == 2)
                            authController.signOutFacebook();
                        },
                        child: SvgPicture.asset(
                          'assets/icons/logout.svg',
                          height: 35,
                          width: 35,
                        )),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          );
        });
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
                        onPressed: () {
                          authController.signInWithGoogle();
                        },
                      ),
                    ),
                    Center(
                      child: SignInButton(Buttons.FacebookNew,
                          text: "Continute with Facebook",
                          onPressed: () =>
                              {authController.signInWithFacebook()}),
                    )
                  ],
                )
              : Wrap(
                  children: [
                    SizedBox(height: 30),
                    Center(child: CircularProgressIndicator()),
                    SizedBox(height: 30),
                    Center(child: Text("Hold up, we're signing you in...")),
                  ],
                ),
        )));
      },
    );
  }
}
