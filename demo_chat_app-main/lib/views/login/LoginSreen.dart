import 'package:demo_chat_app/controllers/AuthenticController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticController _authenticController =
      Get.put(AuthenticController());
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
              child: Center(
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
                                child:
                                    Image.asset("assets/images/messenger.png")),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              "Demo Chat App",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //Image.asset("assets/images/bg.png"),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Lottie.asset("assets/images/prm.json"),
                          ),
                          buildSignIn(),
                        ],
                      ),
                    ),
                    Text("Group 24 - SE114.L21"),
                    SizedBox(height: 40)
                  ],
                ),
              ),
            ),
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
                              child:
                                  Image.asset("assets/images/messenger.png")),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Demo Chat App",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Lottie.asset("assets/images/prm.json"),
                        ),
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("Initilizing..."),
                      ],
                    ),
                  ),
                  Text("Group 24 - SE114.L21"),
                  SizedBox(height: 40)
                ],
              ),
            ),
          );
      },
    );
  }

  Widget buildSignIn() {
    return Obx(
      () => (!_authenticController.isSigningIn.value)
          ? Column(
              children: [
                SignInButton(
                  Buttons.GoogleDark,
                  text: "Continute with Google",
                  onPressed: () {
                    _authenticController.signInWithGoogle();
                  },
                ),
                SignInButton(
                  Buttons.Facebook,
                  text: "Continute with Facebook",
                  onPressed: () {
                    _authenticController.signInWithFacebook();
                  },
                )
              ],
            )
          : Column(
              children: [
                Center(child: CircularProgressIndicator()),
                SizedBox(height: 30),
                Center(child: Text("Hold up, we're signing you in..")),
              ],
            ),
    );
  }
}
