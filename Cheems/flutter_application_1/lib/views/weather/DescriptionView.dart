import 'package:flutter/material.dart';

class WeatherDescriptionView extends StatelessWidget {
  final String weatherDescription;

  WeatherDescriptionView({ required this.weatherDescription});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(weatherDescription,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          )),
    );
  }
}