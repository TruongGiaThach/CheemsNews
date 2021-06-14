import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/readingController.dart';

import 'package:flutter_application_1/views/widgets.dart';
import 'package:get/get.dart';

class ReadingPage extends StatelessWidget {
  late String iD;
  late var _readingController = Get.put(ReadingController());
  ReadingPage(String id) {
    this.iD = id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: RefreshIndicator(
          onRefresh: () => _readingController.fletchNews(this.iD),
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Obx(() => (_readingController.hasData.isFalse)
                      ? Text("There is no data. Scroll to reload")
                      : Text("Still no data"))),
            ],
          )),
    );
  }
}
//if (_readingController.news != null ){
//      return Text(_readingController.news,style: textFieldTextStyle(),);
//    }else return Text("No data",style: textFieldTextStyle(),);

/*: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _readingController.news!.body.length,
                itemBuilder: (context, index) => Text(
                  _readingController.news!.body[index],
                  style: TextStyle(fontSize: 20, height: 1.5),
                ),
              ),*/