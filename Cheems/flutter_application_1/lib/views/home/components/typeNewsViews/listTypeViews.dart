import 'package:flutter/material.dart';

class NavTitle extends StatelessWidget {
  const NavTitle({
    Key? key,
    required this.text,
    required Function this.press,
  }) : super(key: key);
  final String text;
  final Function press;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () => press,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}