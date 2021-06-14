import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class ReadingController extends GetxController {
  News? news;
  ReadingController();
  var hasData = false.obs;

  fletchNews(String id) async {
    news = null;
    /*await FirestoreService.instance.getNewsById(id).then((value) => {
          if (value != null)
            {
              news = value,
              hasData.value = true,
            }
        });*/
    hasData.value = !hasData.value;
  }
}
