import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'components/body.dart';

class PersonLink extends StatelessWidget {
  const PersonLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tôi'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 1,
      ),
      body: Body(),
    );
  }
}
