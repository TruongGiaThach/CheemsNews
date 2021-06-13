import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController{
  var isDataChange = false.obs;
  late List<Thumbnail> listThumb = [];
  HomeController();

  getListThumb() async{
    this.listThumb = await FirestoreService.instance.getAllNews();
    isDataChange.value = true;
  }
}