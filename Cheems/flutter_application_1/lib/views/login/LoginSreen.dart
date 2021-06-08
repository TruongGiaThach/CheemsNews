import 'package:flutter_application_1/controllers/AuthenticController.dart';
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
                                    Image.asset("assets/images/tmpIcon.png")),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              "Demo Login",
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
                          SizedBox(height: 40),
                          buildSignIn(),
                        ],
                      ),
                    ),
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
                              child: Image.asset("assets/images/tmpIcon.png")),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Demo Login",
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

  Widget buildSignIn() {
    return Obx(
      () => (!_authenticController.isSigningIn.value)
          ? Column(
              children: [
                SignInButtonBuilder(
                  image: Image.asset("assets/images/googleIcon.png",height: 30,width: 30,) ,
                  backgroundColor: Colors.blue[300]!,
                  text: "Continute with Google",
                  onPressed: () {
                    _authenticController.signInWithGoogle();
                  },
                ),
                SignInButton(Buttons.FacebookNew,
                    text: "Continute with Facebook",
                    onPressed: () =>
                        {_authenticController.signInWithFacebook()})
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
