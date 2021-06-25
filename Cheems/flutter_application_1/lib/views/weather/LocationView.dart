import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final double longitude;
  final double latitude;
  final String city;

  LocationView(
      {
      required this.longitude,
      required this.latitude,
      required this.city}
      );


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
      children: [
        Text('${this.city.toUpperCase()}',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            )
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 15),
            SizedBox(width: 10),
            Text(this.longitude.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
            Text(' , ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
            Text(this.latitude.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
          ],
        )
      ]),
    );
  }
}