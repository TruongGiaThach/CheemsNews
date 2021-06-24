import 'package:flutter_application_1/API/connectAPI.dart';
import 'package:flutter_application_1/models/Forecast.dart';

class ForecastService {
  Future<Forecast> getWeather(String city) async {
    final ConnectApi connectApi = ConnectApi();
    final location = await connectApi.getLocation(city);
    return await connectApi.getWeather(location);
  }
}
