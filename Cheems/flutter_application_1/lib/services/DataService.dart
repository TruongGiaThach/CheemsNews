import 'dart:convert';
import 'package:flutter_application_1/models/event.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class DataService extends GetxController {
  RxList<events> dataresult = RxList();
  RxList<events> dataresult2 = RxList();

  Future<String> loadAssets(name) async {
    return await rootBundle.loadString(name);
  }

  Future<List<events>> loadEventData(String a) async {
    var jsonString = await loadAssets(a);
    List<events> results = [];
    List jsonData = jsonDecode(jsonString);
    jsonData.forEach((element) {
      String dateString = element['date'];
      String name = element['name'];
      var dateArr = dateString.split("/");
      var date =
          new DateTime(2021, int.parse(dateArr[1]), int.parse(dateArr[0]));
      events event = events(date, name);
      results.add(event);
    });
    return results;
  }

  // get events
  getResult() async {
    dataresult.value = await loadEventData('assets/json/events.json');
  }

  @override
  void onInit() {
    super.onInit();
    getResult();
    getResult2();
  }

  //get lunar events
  getResult2() async {
    dataresult2.value = await loadEventData('assets/json/lunar_events.json');
  }
}
