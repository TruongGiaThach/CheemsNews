import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/Weather.dart';
import 'package:flutter_application_1/services/TempConvertService.dart';

class DailySummaryView extends StatelessWidget {
  final Weather weather;

  DailySummaryView({required this.weather});

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
        toBeginningOfSentenceCase(DateFormat('EEE').format(this.weather.date));

    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(dayOfWeek ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
              Text(
                  "${TemperatureConvert.kelvinToCelsius(this.weather.temp).round().toString()}°",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                    alignment: Alignment.center,
                    child: _mapWeatherConditionToImage(this.weather.condition)))
          ],
        ));
  }

  Widget _mapWeatherConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/images/thunder_storm.png',
            width: 30, height: 30);
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/images/cloudy.png', width: 30, height: 30);
        break;
      case WeatherCondition.lightCloud:
        image =
            Image.asset('assets/images/light_cloud.png', width: 30, height: 30);
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        image = Image.asset('assets/images/drizzle.png', width: 30, height: 30);
        break;
      case WeatherCondition.clear:
        image = Image.asset('assets/images/clear.png', width: 30, height: 30);
        break;
      case WeatherCondition.fog:
        image = Image.asset('assets/images/fog.png', width: 30, height: 30);
        break;
      case WeatherCondition.snow:
        image = Image.asset('assets/images/snow.png', width: 30, height: 30);
        break;
      case WeatherCondition.rain:
        image = Image.asset('assets/images/rain.png', width: 30, height: 30);
        break;
      case WeatherCondition.atmosphere:
        image =
            Image.asset('assets/images/atmosphere.png', width: 30, height: 30);
        break;

      default:
        image = Image.asset('assets/images/light_cloud.png');
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
