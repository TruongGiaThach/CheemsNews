import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Weather.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isdayTime;

  WeatherSummary(
      {required this.condition,
      required this.temp,
      required this.feelsLike,
      required this.isdayTime});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Text(
              '${_formatTemperature(this.temp)}°ᶜ',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${_formatTemperature(this.feelsLike)}°ᶜ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        _mapWeatherConditionToImage(this.condition, this.isdayTime),
      ]),
    );
  }

  String _formatTemperature(double t) {
    var temp = (t.round().toString());
    return temp;
  }

  Widget _mapWeatherConditionToImage(
      WeatherCondition condition, bool isDayTime) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = Image.asset(
          'assets/images/thunder_storm.png',
          width: 50,
          height: 50,
        );
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/images/cloudy.png', width: 50, height: 50);
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? image = Image.asset('assets/images/light_cloud.png',
                width: 50, height: 50)
            : image = Image.asset('assets/images/light_cloud-night.png',
                width: 50, height: 50);
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        image = Image.asset('assets/images/drizzle.png', width: 50, height: 50);
        break;
      case WeatherCondition.clear:
        isDayTime
            ? image =
                Image.asset('assets/images/clear.png', width: 50, height: 50)
            : image = Image.asset('assets/images/clear-night.png',
                width: 50, height: 50);
        break;
      case WeatherCondition.fog:
        image = Image.asset('assets/images/fog.png', width: 50, height: 50);
        break;
      case WeatherCondition.snow:
        image = Image.asset('assets/images/snow.png', width: 50, height: 50);
        break;
      case WeatherCondition.rain:
        image = Image.asset('assets/images/rain.png', width: 50, height: 50);
        break;
      case WeatherCondition.atmosphere:
        image = Image.asset('assets/images/fog.png', width: 50, height: 50);
        break;

      default:
        image = Image.asset('assets/images/unknown.png', width: 50, height: 50);
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
