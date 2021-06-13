import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class ReadingController extends GetxController{
  late News news;
  final String idNews;

  ReadingController(this.idNews){ _fletchNews();}

  
  _fletchNews() async{
    news =  await FirestoreService.instance.getNewsById(idNews);
    
  }
}