import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/models/Title.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController{
  var typeIndex = 0.obs;
  List<TypeNews> listType = [];
  HomeController();
  @override
  void onInit() async{
    await getListTopic();
    super.onInit();
  }
  Future<List<TypeNews>> getListTopic() async{
    List<TypeNews> tmp = [];
    tmp = await FirestoreService.instance.getAllTag();
    listType = tmp;
    return tmp;
  }
  
  Future<List<News>> getListThumbWithTopic(String topic,int num) async{
    List<News> tmp = [];
    tmp = await FirestoreService.instance.getLimitNewsWithTag(topic,4);
    if (tmp.length != 0)
    while (tmp.length < num)
      {
        tmp.add(tmp[0]);
      }
    return tmp;
  }

}