import 'package:flutter/material.dart';

AppBar appBarMain(BuildContext context) {
  return AppBar(
    
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white54),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  );
}

Widget loadingWiget()
{
  return Image.asset("assets/images/dancin_dog.gif");

}