import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class FavoriteController extends GetxController {
  RxList listID = [].obs;
  Rx<bool> check = false.obs;

  bool checkNew(String newId) {
    return listID.contains(newId);
  }

  Future<void> initListFav(String uID) async {
    List<String> tmp = [];
    if (uID != "") {
      tmp = await FirestoreService.instance.getListFav(uID);
      check.value = true;
    }
    listID.value = tmp;
  }

  Future<List<News>> loadListFav(String uID) async {
    List<News> tmp = [];
    if (listID.isNotEmpty)
      for (int i = 0; i < listID.value.length; i++) {
        News? news = await FirestoreService.instance.getNewsById(listID[i]);
        if (news != null) tmp.add(news);
      }

    return tmp;
  }

  Future addNewsToListFav(MyUser? currentUser, News news) async {
    if (listID.value.contains(news.id)) return;
    listID.add(news.id);
    await FirestoreService.instance
        .updateListFav(currentUser, listID.value as List<String>);
  }

  Future deleteNewsFromListFav(MyUser? currentUser, News news) async {
    if (!listID.value.contains(news.id)) return;
    listID.remove(news.id);
    await FirestoreService.instance
        .updateListFav(currentUser, listID.value as List<String>);
  }
}
