import 'package:flutter_application_1/models/Comment.dart';
import 'package:flutter_application_1/models/News.dart';
import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/state_manager.dart';

class ReadingController extends GetxController {
  News? news;
  ReadingController() {
    news = null;
  }
  var isNewCmt = false.obs;
  var hasData = false.obs;
  var bottomIndex = 0.obs;

  fletchNews(String id) async {
    news = await FirestoreService.instance.getNewsById(id);
    if (news != null)
      hasData.value = true;
    else
      hasData.value = false;
  }

  addComment(Comments cmt) async {
    if (news != null)
      await FirestoreService.instance.addCmt(this.news!.id, cmt);
  }

  Future<List<Comments>> getListCmt() async {
    List<Comments> tmp = [];
    if (this.news != null)
      tmp = await FirestoreService.instance.getAllCmt(this.news!.id);
    if (tmp != []) tmp.sort((cmt1,cmt2)=>cmt1.time.compareTo(cmt2.time) );
    return tmp;
  }
}
