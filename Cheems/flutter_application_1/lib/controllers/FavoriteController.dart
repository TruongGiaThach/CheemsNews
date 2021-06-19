import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class FavoriteController extends GetxController{
  RxList listID = [].obs;

  _initListFav(String uID) async{
    List<String> tmp = [];
    tmp = await FirestoreService.instance.getListFav(uID);
    listID.value = tmp;
    
  }

  Future<List<News>> loadListFav(String uID) async{
    await _initListFav(uID);
    List<News> tmp = [];
    if (listID.isNotEmpty)
      for (int  i = 0; i < listID.value.length;)
        {
          News? news = await FirestoreService.instance.getNewsById(listID[i]);
          if (news != null)
            tmp.add(news);
        }
   
    return tmp;
  }


}