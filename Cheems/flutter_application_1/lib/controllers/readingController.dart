
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class ReadingController extends GetxController {
  News? news;
  ReadingController(){news = null;}
  var hasData = false.obs;

  fletchNews(String id) async{
    
    news = await FirestoreService.instance.getNewsById(id);
    if (news != null)
      hasData.value = true;
  }
}
