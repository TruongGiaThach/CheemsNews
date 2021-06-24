import 'package:flutter_application_1/models/Forecast.dart';
import 'package:flutter_application_1/models/location.dart';

abstract class WeatherApi {
  Future<Forecast> getWeather(Location location);
  Future<Location> getLocation(String city);
}
