import 'package:flutter_application_1/models/News.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxString searchLine = "".obs;
  RxList<News> searchResult = <News>[].obs;
}
