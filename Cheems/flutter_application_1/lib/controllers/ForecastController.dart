import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/Forecast.dart';
import 'package:flutter_application_1/models/Weather.dart';
import 'package:flutter_application_1/services/ForecastService.dart';
import 'package:flutter_application_1/services/TempConvertService.dart';

class ForecastController extends GetxController {
  //Forcast Get state
  ForecastService forecastService = Get.find<ForecastService>();

  Rx<bool> isRequestPending = false.obs;
  RxBool isWeatherLoaded = false.obs;
  RxBool isRequestError = false.obs;
  Rx<WeatherCondition> condition = WeatherCondition.atmosphere.obs;
  RxString description = ''.obs;
  Rx<double> minTemp = 0.0.obs;
  Rx<double> maxTemp = 0.0.obs;
  Rx<double> temp = 0.0.obs;
  Rx<double> feelsLike = 0.0.obs;
  Rx<int> locationId = 0.obs;
  Rx<DateTime> lastUpdated = DateTime(0, 0, 0, 0, 0).obs;
  RxString city = ''.obs;
  Rx<double> latitude = 0.0.obs;
  Rx<double> longitude = 0.0.obs;
  RxList<Weather> daily = RxList();
  RxBool isDayTime = false.obs;
  Rx<TextEditingController> citycontroller = TextEditingController().obs;
  RxString cityview = ''.obs;
  final focusnode = FocusNode();

  Future<void> getLatestWeather(String city0) async {
    this.isRequestError.value = false;

    Forecast latest = Forecast(
        lastUpdated: DateTime.now(),
        longitude: 0.0,
        latitude: 0.0,
        daily: daily.value,
        current: Weather(
            condition: WeatherCondition.rain,
            description: 'Non',
            temp: 0.0,
            feelLikeTemp: 0.0,
            cloudiness: 0,
            date: DateTime.now()),
        city: 'Hà Nội',
        isDayTime: false);
    try {
      latest = await forecastService
          .getWeather(city0)
          // ignore: invalid_return_type_for_catch_error
          .catchError((onError) => this.isRequestError.value = true);
    } catch (e) {
      this.isRequestError.value = true;
    }

    this.isWeatherLoaded.value = true;
    updateModel(latest, city0);
    setRequestPendingState(false);
  }

  void setRequestPendingState(bool isPending) {
    this.isRequestPending.value = isPending;
  }

  void updateModel(Forecast forecast, String city0) {
    if (isRequestError.value) return;

    condition.value = forecast.current.condition;
    city.value = city0;
    description.value = (forecast.current.description);
    lastUpdated.value = forecast.lastUpdated;
    temp.value = TemperatureConvert.kelvinToCelsius(forecast.current.temp);
    feelsLike.value =
        TemperatureConvert.kelvinToCelsius(forecast.current.feelLikeTemp);
    longitude.value = forecast.longitude;
    latitude.value = forecast.latitude;
    daily.value = forecast.daily;
    isDayTime.value = forecast.isDayTime;
  }

  Future<void> start() async {
    if (city.value == '') await getLatestWeather('Hà Nội');
  }

  @override
  void onInit() {
    super.onInit();
    start();
  }
}
