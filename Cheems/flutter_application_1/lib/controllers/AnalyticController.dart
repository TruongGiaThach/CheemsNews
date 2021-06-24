import 'package:get/get.dart';

class AnalyticController extends GetxController {
  RxString name = "AAPL".obs;
  RxString timeWindow = "1Year".obs;
  RxString chartType = "candle".obs;
}
