import 'package:get/state_manager.dart';

class MainController extends GetxController{
  var currentIndex = 0.obs;
  
  MainController();
  gotoHome(){
    currentIndex.value = 0;
  }
   gotoCollection(){
    currentIndex.value = 1;
  }
   gotoSetting(){
    currentIndex.value = 5;
  }
}