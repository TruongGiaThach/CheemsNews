import 'package:flutter_application_1/services/FirestoreService.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  String reportLine = "";

  Future<void> sendReport(String email, String newID) async {
    await FirestoreService.instance.addReport(email, newID, reportLine);
  }
}
