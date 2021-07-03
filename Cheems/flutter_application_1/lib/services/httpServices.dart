import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_application_1/models/statisticModel.dart';

class HttpService {
  final String postsURL = "https://finnhub.io/api/v1/stock/candle?";

  Future<StatisticModel> getStats(String name, String timeWindow) async {
    String apiKey = "c32nksaad3ieculvq3ng";
    String resolution = '';
    int timeRange = 0;
    switch(timeWindow){
      case "1Day": timeRange = 86400;
      resolution = "30";
      break;
      case "1Week": timeRange = 604800;
      resolution = "240";
      break;
      case "1Month": timeRange = 2592000;
      resolution = "D";
      break;
      case "3Month": timeRange = 7776000;
      resolution = "D";
      break;
      case "1Year": timeRange = 31536000;
      resolution = "W";
      break;
    }
    String timea, timeb;
    timeb = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    timeb = timeb.substring(0, timeb.length - 3);
    timea = (int.parse(timeb) - timeRange).toString();
    final response = await get(Uri.parse(postsURL + "symbol=" + name +"&&resolution=" + resolution + "&from=" + timea + "&to=" + timeb +"&token=" + apiKey));

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);

      return StatisticModel.fromJson(responseJson);
    } else {
      throw "Unable to retrieve data.";
    }
  }
}