// To parse this JSON data, do
//
//     final statisticModel = statisticModelFromJson(jsonString);

import 'dart:convert';

StatisticModel statisticModelFromJson(String str) =>
    StatisticModel.fromJson(json.decode(str));

String statisticModelToJson(StatisticModel data) => json.encode(data.toJson());

class StatisticModel {
  StatisticModel({
    required this.c,
    required this.h,
    required this.l,
    required this.o,
    required this.s,
    required this.t,
    required this.v,
  });

  List<double> c;
  List<double> h;
  List<double> l;
  List<double> o;
  String s;
  List<int> t;
  List<int> v;

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
        c: List<double>.from(json["c"].map((x) => x.toDouble())),
        h: List<double>.from(json["h"].map((x) => x.toDouble())),
        l: List<double>.from(json["l"].map((x) => x.toDouble())),
        o: List<double>.from(json["o"].map((x) => x.toDouble())),
        s: json["s"],
        t: List<int>.from(json["t"].map((x) => x)),
        v: List<int>.from(json["v"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "c": List<dynamic>.from(c.map((x) => x)),
        "h": List<dynamic>.from(h.map((x) => x)),
        "l": List<dynamic>.from(l.map((x) => x)),
        "o": List<dynamic>.from(o.map((x) => x)),
        "s": s,
        "t": List<dynamic>.from(t.map((x) => x)),
        "v": List<dynamic>.from(v.map((x) => x)),
      };
}
