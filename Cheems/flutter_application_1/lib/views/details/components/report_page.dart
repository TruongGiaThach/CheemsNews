import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/ReportController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  late News news;
  ReportPage({Key? key, required this.news}) : super(key: key);
  final _authenticateController = Get.find<AuthenticController>();
  final _settingController = Get.find<SettingController>();
  final _reportController = Get.put(ReportController());
  var reportController = TextEditingController();
  final FocusNode reportFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _settingController.kPrimaryColor.value,
        title: Text('Report'),
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return KeyboardDismisser(
      gestures: [GestureType.onTap],
      child: GestureDetector(
        //onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(physics: ScrollPhysics(), shrinkWrap: true, children: [
          Obx(() => (_authenticateController.isGuest.value)
              // ignore: deprecated_member_use
              ? FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: _settingController.kPrimaryColor.value,
                  onPressed: () {
                    _showGuestSheet(context);
                  },
                  child: Text(
                    "Log in to report",
                    style: TextStyle(color: Colors.white),
                  ))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: reportController,
                        focusNode: reportFocus,
                        onChanged: (report) {
                          _reportController.reportLine = report;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'writing your report here',
                        ),
                        maxLines: 5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextButton(
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_reportController.reportLine.isNotEmpty) {
                              await _reportController
                                  .sendReport(
                                      _authenticateController.currentUser !=
                                              null
                                          ? _authenticateController
                                              .currentUser!.email
                                          : "Guest",
                                      news.id)
                                  .then((value) => {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Container(
                                                  height: 300,
                                                  child: AlertDialog(
                                                    title:
                                                        Text('Report sended'),
                                                    content: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'We have recive your report',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            'thank you for annouce us about this information',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            reportController
                                                                .text = "";
                                                            Navigator.pop(
                                                                context, 'Yes');
                                                          },
                                                          child: Text('Yes')),
                                                    ],
                                                    elevation: 24,
                                                  ),
                                                ))
                                      })
                                  .catchError((error) => {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Container(
                                                  height: 300,
                                                  child: AlertDialog(
                                                    title: Text(
                                                        'Report not sended'),
                                                    content: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'something went wrong when send',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            'please check your network connection and retry after a while',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, 'Yes');
                                                          },
                                                          child: Text('Yes')),
                                                    ],
                                                    elevation: 24,
                                                  ),
                                                ))
                                      });
                            }
                          },
                          child: Text('Send')),
                    )
                  ],
                )),
        ]),
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
          () => (!_authenticateController.isSigningIn.value)
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
                          _authenticateController.signInWithGoogle(),
                          Navigator.pop(context),
                        },
                      ),
                    ),
                    Center(
                      child: SignInButton(Buttons.FacebookNew,
                          text: "Continute with Facebook",
                          onPressed: () => {
                                _authenticateController.signInWithFacebook(),
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
