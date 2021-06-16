import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/News.dart';

import '../../../constants.dart';
import '../../widgets.dart';


class Body extends StatelessWidget {
  Body({Key? key,required News product}) : super(key: key);
  late News product;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kPrimaryColor.withOpacity(.1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                product.title,
                style: titleTextFieldTextStyle(),
              ),
              SizedBox(height: 10),
             
              SizedBox(height: 10),
              
            ],
          ),
        ),
      ),
    );
  }
}
