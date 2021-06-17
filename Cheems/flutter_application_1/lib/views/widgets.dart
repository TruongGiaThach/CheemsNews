import 'package:flutter/material.dart';

AppBar appBarMain(BuildContext context) {
  return AppBar(
    //title: Image.asset(      'assets/images/tmpIcon.png',      height: 55,    ),
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


TextStyle textFieldTextStyle() {
  return TextStyle(color: Colors.blue, fontSize: 16);
}
TextStyle titleTextFieldTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 18);
}
TextStyle minimzeTextStyle() {
  return TextStyle(color: Colors.blue, fontSize: 14);
}
TextStyle newsTiltleTextStyle() {
  return TextStyle(color: Colors.black54, fontSize: 30);
}
TextStyle newsBodyTextStyle() {
  return TextStyle(color: Colors.black87, fontSize: 18,height: 1.5);
}
