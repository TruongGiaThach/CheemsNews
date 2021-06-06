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
   
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
