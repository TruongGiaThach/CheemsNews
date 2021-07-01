import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/models/Title.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  var typeIndex = 0.obs;
  List<TypeNews> listType = [];
  HomeController();
  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> initialize() async {
    await getListTopic();
  }

  Future<List<TypeNews>> getListTopic() async {
    List<TypeNews> tmp = [];
    tmp = await FirestoreService.instance.getAllTag();
    listType = tmp;
    return tmp;
  }

  Future<List<News>> getListThumbWithTopic(String topic, int num) async {
    List<News> tmp = [];
    if (num == 0)
      tmp = await FirestoreService.instance.getAllNewsWithTag(topic);
    else
      tmp = await FirestoreService.instance.getLimitNewsWithTag(topic, num);
    if (tmp.length != 0)
      while (tmp.length < num) {
        tmp.add(tmp[0]);
      }
    return tmp;
  }

  bool checkContainBegin(String str, String str1) {
    str = str.toLowerCase();
    str1 = str1.toLowerCase();
    if (str == "") return false;
    if (str.length > str1.length) return false;
    for (int i = 0; i < str.length; i++) if (str[i] != str1[i]) return false;
    return true;
  }

  Future<List<News>> getListThumbWithName(String name) async {
    List<News> tmp = [];
    if (name.isNotEmpty) {
      tmp = await FirestoreService.instance.getAllNewsWithName(name);
      int i  = 0;

      while (i < tmp.length ) {
        if (!checkContainBegin(name, tmp[i].title)) tmp.removeAt(i);
        else i ++;
      }
    }
    return tmp;
  }
}
