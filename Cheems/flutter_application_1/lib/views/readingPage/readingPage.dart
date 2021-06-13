import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/readingController.dart';

import 'package:flutter_application_1/views/widgets.dart';
import 'package:get/get.dart';

class ReadingPage extends StatelessWidget {
  late String iD;
  late var _readingController;
  ReadingPage(String id) {
    _readingController = Get.put(ReadingController(id));
    this.iD = id;
  }
  @override
  Widget build(BuildContext context) {
    if (_readingController.news != null ){
      return Text(_readingController.news,style: textFieldTextStyle(),);
    }else return Text("No data",style: textFieldTextStyle(),);
  }
}
