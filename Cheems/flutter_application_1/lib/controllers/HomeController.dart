import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController{
  var isDataChange = false.obs;
  late List<Thumbnail> listThumb = [];
  HomeController();

  getListThumb() async{
    listThumb = [];
    this.listThumb = await FirestoreService.instance.getAllNews();
    isDataChange.value = true;
    if (listThumb.length == 1){
      var item = 0;
      while (item <10) {
        listThumb.add(listThumb[0]);
        item++;
      }
    }
    print(listThumb.length);
  }

}