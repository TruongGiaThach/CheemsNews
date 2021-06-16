import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController{
  

  HomeController();

  
   Future<List<News>> getListThumbWithTopic(String topic) async{
    List<News> tmp = [];
    tmp= await FirestoreService.instance.getLimitNewsWithTag(topic);
  
    return tmp;
  }

}