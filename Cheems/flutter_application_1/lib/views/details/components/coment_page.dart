import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/controllers/readingController.dart';
import 'package:flutter_application_1/models/Comment.dart';
import 'package:flutter_application_1/views/details/components/comment_card.dart';
import 'package:flutter_application_1/views/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class CommentPage extends StatelessWidget {
  CommentPage({Key? key}) : super(key: key);
  final _authenticateController = Get.find<AuthenticController>();
  final _settingController = Get.find<SettingController>();
  final _readingController = Get.find<ReadingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
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
                  "Log in to comment",
                  style: TextStyle(color: Colors.white),
                ))
            : Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      style: newsBodyTextStyle(),
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_comment_outlined))
                  ],
                ),
              )),
        FutureBuilder(
          future: _readingController.getListCmt(),
          builder: (context, AsyncSnapshot<List<Comments>> snapshot) {
            if (snapshot.hasError) {
              return Container(
                color: _settingController.kPrimaryColor.value.withOpacity(.1),
                child: Center(
                  child: Text("There are some error when load comments"),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) if (snapshot
                .hasData) if (snapshot.data!.length != 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CommentCard(cmt: snapshot.data![index]);
                  }); // show list news
            } else
              return Container(
                  child: Center(
                child: Text("You don't have any news in collection"),
              ));
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
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
                        onPressed: () {
                          _authenticateController.signInWithGoogle();
                        },
                      ),
                    ),
                    Center(
                      child: SignInButton(Buttons.FacebookNew,
                          text: "Continute with Facebook",
                          onPressed: () =>
                              {_authenticateController.signInWithFacebook()}),
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
