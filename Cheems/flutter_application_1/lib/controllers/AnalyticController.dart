import 'package:get/get.dart';

class AnalyticController extends GetxController {
  RxString name = "AAPL".obs;
  RxString timeWindow = "1Day".obs;

  Rx<double> stockPrice = 0.0.obs;
  Rx<double> stockPriceChangePer = 0.0.obs;
}
