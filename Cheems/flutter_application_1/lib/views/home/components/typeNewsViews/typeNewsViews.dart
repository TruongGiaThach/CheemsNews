import 'package:flutter/material.dart';

class TypeNewsViews extends StatelessWidget {
  TypeNewsViews({Key? key, required String typeNews}) : super(key: key);

  late String typeNews;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Text(typeNews),
    );
  }
}
