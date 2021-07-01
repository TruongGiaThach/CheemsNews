import 'package:firebase_core/firebase_core.dart';
import 'package:get/state_manager.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  late Future<FirebaseApp> firestoreConnect;
  gotoHome() {
    currentIndex.value = 0;
  }

  gotoCollection() {
    currentIndex.value = 1;
  }

  gotoSetting() {
    currentIndex.value = 4;
  }
}
