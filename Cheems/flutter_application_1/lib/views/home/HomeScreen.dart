import 'package:flutter_application_1/controllers/AuthenticController.dart';
import 'package:flutter_application_1/models/ChatUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final _authController = Get.put(AuthenticController());
  late final ChatUser _user;
  late final int _signInType;
  HomeScreen(ChatUser user, int signInType) {
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
                        _authController.signOutGoogle();
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
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: GestureDetector(
          onTap: () => {
            _showPicker(context),
          },
          child: CircleAvatar(
            backgroundColor: Colors.cyan[100],
            radius: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: Image.network(
                _user.photoUrl,
                height: 80,
                width: 80,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ),
    );

    /*
    return Scaffold(
        appBar: appBarMain(context) ,
        body: Column(
         
          children: [
            (_signInType == 1)?Image.asset("assets/images/googleIcon.png")
              :Image.asset("assets/images/facebookIcon.png"),
            SizedBox(height: 30,),
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        _user.photoUrl,
                        height: 40,
                        width: 40,
                      ), 
                      
                      Text(_user.displayName,style: textFieldTextStyle(),),
                    ],               
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: ()=>{
                      _authController.signOutGoogle()
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      decoration:BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ), 
                      child: Text("Loggout",style: titleTextFieldTextStyle(),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
    );*/
  }
}
