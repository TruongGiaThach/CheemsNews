import 'package:flutter_application_1/controllers/AnalyticController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/statisticModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/httpServices.dart';
import 'package:flutter/src/rendering/custom_paint.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.time, this.value);
  final String time;
  final double value;
}
class BarData {
  BarData(this.time, this.value);
  final String time;
  final int value;
}

class Chart extends StatelessWidget {
  final _analyticController = Get.find<AnalyticController>();
  final _settingController = Get.find<SettingController>();
  StatisticModel? stockData;
  @override
  Widget build(BuildContext context) {
    final HttpService httpService = HttpService();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "ANALYTICS",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
          actions: [],
          backgroundColor: _settingController.kPrimaryColor.value,
        ),
        drawer: SizedBox(
          width: 200,
          child: Drawer(
            elevation: 0,
            child: Container(
              color: Colors.black87,
              child: ListView(
                children: [
                  SizedBox(
                    height: 60,
                    child: DrawerHeader(
                        decoration: BoxDecoration(
                            color: _settingController.kPrimaryColor.value),
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.zero,
                                  splashRadius: 20,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new)),
                            ),
                            Center(
                                child: Text(
                              "Settings",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            )),
                          ],
                        )),
                  ),
                  Text(
                    'Currency',
                    style: TextStyle(fontSize: 24, color: Colors.white54),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextButton(
                          onPressed: () {
                            _analyticController.name.value = "IBM";
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('IBM'))),
                      TextButton(
                          onPressed: () {
                            _analyticController.name.value = "AAPL";
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('AAPL'))),
                      TextButton(
                          onPressed: () {
                            _analyticController.name.value = "MSFT";
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('MSFT'))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black87,
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      _analyticController.timeWindow.value = "1Day";
                    },
                    child: Text('Day')),
                TextButton(
                    onPressed: () {
                      _analyticController.timeWindow.value = "1Week";
                    },
                    child: Text('Week')),
                TextButton(
                    onPressed: () {
                      _analyticController.timeWindow.value = "1Month";
                    },
                    child: Text('month')),
                TextButton(
                    onPressed: () {
                      _analyticController.timeWindow.value = "1Year";
                    },
                    child: Text('Year')),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Center(
                  child: Obx(() => Text(
                        _analyticController.name.value,
                        style: TextStyle(fontSize: 18, color: Colors.white60),
                      )),
                ),
              ),
            ],
          ),
          Obx(() => FutureBuilder(
              future: httpService.getStats(_analyticController.name.value,
                  _analyticController.timeWindow.value),
              builder: (BuildContext context,
                  AsyncSnapshot<StatisticModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    stockData = snapshot.data;
                    _analyticController.stockPrice.value =
                        stockData != null ? stockData!.c.last : 0;
                    _analyticController.stockPriceChangePer.value =
                        stockData != null
                            ? ((stockData!.c.last - stockData!.o.last) /
                                    stockData!.o.last *
                                    100)
                                .toPrecision(2)
                            : 0;
                    return Column(
                      children: [
                        RichText(
                            text: _analyticController.stockPrice.value != 0
                                ? TextSpan(children: [
                                    TextSpan(
                                        text: "price: ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white60)),
                                    TextSpan(
                                        text:
                                            "${_analyticController.stockPrice.value.toString()} ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white60)),
                                    TextSpan(
                                        text:
                                            "${_analyticController.stockPriceChangePer.value.toString()}%",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: _analyticController
                                                        .stockPriceChangePer
                                                        .value >=
                                                    0
                                                ? Colors.greenAccent
                                                : Colors.redAccent)),
                                  ])
                                : TextSpan(text: "0")),
                        Container(
                          color: Colors.black45,
                          alignment: Alignment.centerLeft,
                          child: Text("Stock price:",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white60)),
                        ),
                        SizedBox(
                          child: LayoutBuilder(
                            builder: (_,constraints) => Container(
                              width: constraints.widthConstraints().maxWidth,
                              height: 275,
                              color:Colors.black45,
                              child: CustomPaint(
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries>[
                                    // Initialize line series
                                    if (_analyticController.timeWindow == "1Day")
                                      LineSeries<ChartData, String>(
                                          dataSource: [
                                            ChartData('0',stockData!.c.reduce(min)),
                                            ChartData('1',stockData!.c[0]),
                                            ChartData('2',stockData!.c[0] ),
                                            ChartData('3',stockData!.c[0] ),
                                            ChartData('4',stockData!.c[0]),
                                            ChartData('5',stockData!.c[0] ),
                                            ChartData('6',stockData!.c[0] ),
                                            ChartData('7',stockData!.c[0]),
                                            ChartData('8',stockData!.c[0]),
                                            ChartData('9',stockData!.c[0]),
                                            ChartData('10', stockData!.c[0]),
                                            ChartData('11', stockData!.c[0]),
                                            ChartData('12', stockData!.c[0]),
                                            ChartData('13', stockData!.c[0]),
                                            ChartData('14', stockData!.c[0]),
                                            ChartData('15', stockData!.c[0]),
                                            ChartData('16', stockData!.c[0]),
                                            ChartData('17', stockData!.c[0]),
                                            ChartData('18', stockData!.c[0]),
                                            ChartData('19', stockData!.c[0]),
                                            ChartData('20', stockData!.c[0]),
                                            ChartData('21', stockData!.c[0]),
                                            ChartData('22', stockData!.c[0]),
                                            ChartData('23',stockData!.c.reduce(max)),
                                          ],
                                          xValueMapper: (ChartData sales, _) => sales.time,
                                          yValueMapper: (ChartData sales, _) => sales.value,
                                          color: Colors.transparent
                                      )
                                    else if(_analyticController.timeWindow == "1Week")
                                      LineSeries<ChartData, String>(
                                          dataSource: [
                                            ChartData('Mon',stockData!.c.reduce(min)),
                                            ChartData('Tue',stockData!.c[0]),
                                            ChartData('Wed',stockData!.c[0] ),
                                            ChartData('Thu',stockData!.c[0] ),
                                            ChartData('Fri',stockData!.c[0]),
                                            ChartData('Sat',stockData!.c[0] ),
                                            ChartData('Sun',stockData!.c.reduce(max)),
                                          ],
                                          xValueMapper: (ChartData sales, _) => sales.time,
                                          yValueMapper: (ChartData sales, _) => sales.value,
                                          color: Colors.transparent
                                      )
                                    else if(_analyticController.timeWindow == "1Month")
                                        LineSeries<ChartData, String>(
                                            dataSource: [
                                              ChartData('1st',stockData!.c.reduce(min)),
                                              ChartData('4th',stockData!.c[0]),
                                              ChartData('7th',stockData!.c[0] ),
                                              ChartData('10th',stockData!.c[0] ),
                                              ChartData('13th',stockData!.c[0]),
                                              ChartData('16h',stockData!.c[0] ),
                                              ChartData('19th',stockData!.c[0] ),
                                              ChartData('22th',stockData!.c[0]),
                                              ChartData('25th',stockData!.c[0]),
                                              ChartData('28th',stockData!.c.reduce(max)),
                                            ],
                                            xValueMapper: (ChartData sales, _) => sales.time,
                                            yValueMapper: (ChartData sales, _) => sales.value,
                                            color: Colors.transparent
                                        )
                                      else
                                        LineSeries<ChartData, String>(
                                            dataSource: [
                                              ChartData('Jan',stockData!.c.reduce(min)),
                                              ChartData('Feb',stockData!.c[0]),
                                              ChartData('Mar',stockData!.c[0] ),
                                              ChartData('Apr',stockData!.c[0] ),
                                              ChartData('May',stockData!.c[0]),
                                              ChartData('Jun',stockData!.c[0] ),
                                              ChartData('Jul',stockData!.c[0] ),
                                              ChartData('Aug',stockData!.c[0]),
                                              ChartData('Sep',stockData!.c[0]),
                                              ChartData('Oct',stockData!.c[0] ),
                                              ChartData('Nov', stockData!.c[0]),
                                              ChartData('Dec',stockData!.c.reduce(max)),
                                            ],
                                            xValueMapper: (ChartData sales, _) => sales.time,
                                            yValueMapper: (ChartData sales, _) => sales.value,
                                            color: Colors.transparent
                                        )
                                  ],
                                ),
                                painter: StockCandlesPainter(stockData: stockData),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black45,
                          alignment: Alignment.centerLeft,
                          child: Text("Trading volume:",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white60)),
                        ),
                        SizedBox(
                          child: LayoutBuilder(
                            builder: (_, constraints) => Container(
                              width: constraints.widthConstraints().maxWidth,
                              height: 185,
                              color: Colors.black45,
                              child: CustomPaint(
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries>[
                                    // Initialize line series
                                    if (_analyticController.timeWindow == "1Day")
                                      LineSeries<BarData, String>(
                                          dataSource: [
                                            BarData('0',stockData!.v.reduce(min)),
                                            BarData('1',stockData!.v[0]),
                                            BarData('2',stockData!.v[0] ),
                                            BarData('3',stockData!.v[0] ),
                                            BarData('4',stockData!.v[0]),
                                            BarData('5',stockData!.v[0] ),
                                            BarData('6',stockData!.v[0] ),
                                            BarData('7',stockData!.v[0]),
                                            BarData('8',stockData!.v[0]),
                                            BarData('9',stockData!.v[0]),
                                            BarData('10', stockData!.v[0]),
                                            BarData('11', stockData!.v[0]),
                                            BarData('12', stockData!.v[0]),
                                            BarData('13', stockData!.v[0]),
                                            BarData('14', stockData!.v[0]),
                                            BarData('15', stockData!.v[0]),
                                            BarData('16', stockData!.v[0]),
                                            BarData('17', stockData!.v[0]),
                                            BarData('18', stockData!.v[0]),
                                            BarData('19', stockData!.v[0]),
                                            BarData('20', stockData!.v[0]),
                                            BarData('21', stockData!.v[0]),
                                            BarData('22', stockData!.v[0]),
                                            BarData('23',stockData!.v.reduce(max)),
                                          ],
                                          xValueMapper: (BarData sales, _) => sales.time,
                                          yValueMapper: (BarData sales, _) => sales.value,
                                          color: Colors.transparent
                                      )
                                    else if(_analyticController.timeWindow == "1Week")
                                      LineSeries<BarData, String>(
                                          dataSource: [
                                            BarData('Mon',stockData!.v.reduce(min)),
                                            BarData('Tue',stockData!.v[0]),
                                            BarData('Wed',stockData!.v[0] ),
                                            BarData('Thu',stockData!.v[0] ),
                                            BarData('Fri',stockData!.v[0]),
                                            BarData('Sat',stockData!.v[0] ),
                                            BarData('Sun',stockData!.v.reduce(max)),
                                          ],
                                          xValueMapper: (BarData sales, _) => sales.time,
                                          yValueMapper: (BarData sales, _) => sales.value,
                                          color: Colors.transparent
                                      )
                                    else if(_analyticController.timeWindow == "1Month")
                                        LineSeries<BarData, String>(
                                            dataSource: [
                                              BarData('1st',stockData!.v.reduce(min)),
                                              BarData('4th',stockData!.v[0]),
                                              BarData('7th',stockData!.v[0] ),
                                              BarData('10th',stockData!.v[0] ),
                                              BarData('13th',stockData!.v[0]),
                                              BarData('16h',stockData!.v[0] ),
                                              BarData('19th',stockData!.v[0] ),
                                              BarData('22nd',stockData!.v[0]),
                                              BarData('25th',stockData!.v[0]),
                                              BarData('28th',stockData!.v.reduce(max)),
                                            ],
                                            xValueMapper: (BarData sales, _) => sales.time,
                                            yValueMapper: (BarData sales, _) => sales.value,
                                            color: Colors.transparent
                                        )
                                      else
                                        LineSeries<BarData, String>(
                                            dataSource: [
                                              BarData('Jan',stockData!.v.reduce(min)),
                                              BarData('Feb',stockData!.v[0]),
                                              BarData('Mar',stockData!.v[0] ),
                                              BarData('Apr',stockData!.v[0] ),
                                              BarData('May',stockData!.v[0]),
                                              BarData('Jun',stockData!.v[0] ),
                                              BarData('Jul',stockData!.v[0] ),
                                              BarData('Aug',stockData!.v[0]),
                                              BarData('Sep',stockData!.v[0]),
                                              BarData('Oct',stockData!.v[0] ),
                                              BarData('Nov', stockData!.v[0]),
                                              BarData('Dec',stockData!.v.reduce(max)),
                                            ],
                                            xValueMapper: (BarData sales, _) => sales.time,
                                            yValueMapper: (BarData sales, _) => sales.value,
                                            color: Colors.transparent
                                        )
                                  ],
                                ),
                                painter: StockVolumePainter(stockData: stockData),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    return Column(
                      children: [
                        Center(
                        child:Text(
                          'price: ',
                          style: TextStyle(fontSize: 18, color: Colors.white60),
                        ),),
                        Container(
                          color: Colors.black45,
                          alignment: Alignment.centerLeft,
                          child: Text("Stock price:",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white60)),
                        ),
                        SizedBox(
                          height: 275,
                          child: SfCartesianChart(backgroundColor: Colors.black45),
                        ),
                        Container(
                          color: Colors.black45,
                          alignment: Alignment.centerLeft,
                          child: Text("Trading volume:",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white60)),
                        ),
                        SizedBox(
                          height: 185,
                          child: SfCartesianChart(backgroundColor: Colors.black45),
                        ),
                      ],
                    );
                  }
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Connect Timeout!!!",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                }
                return Column(
                  children: [
                    Center(
                      child:Text(
                        'price: ',
                        style: TextStyle(fontSize: 18, color: Colors.white60),
                      ),),
                    Container(
                      color: Colors.black45,
                      alignment: Alignment.centerLeft,
                      child: Text("Stock price:",
                          style:
                              TextStyle(fontSize: 18, color: Colors.white60)),
                    ),
                    SizedBox(
                      height: 275,
                      child: SfCartesianChart(backgroundColor: Colors.black45),
                    ),
                    Container(
                      color: Colors.black45,
                      alignment: Alignment.centerLeft,
                      child: Text("Trading volume:",
                          style:
                              TextStyle(fontSize: 18, color: Colors.white60)),
                    ),
                    SizedBox(
                      height: 185,
                      child: SfCartesianChart(backgroundColor: Colors.black45),
                    ),
                  ],
                );
              })),
        ]));
  }
}

class StockVolumePainter extends CustomPainter {
  StockVolumePainter({
    this.stockData,
  })  : _lossPaint = Paint()..color = Colors.green.withOpacity(0.5),
        _gainPaint = Paint()..color = Colors.red.withOpacity(0.5);

  final StatisticModel? stockData;
  final Paint _gainPaint;
  final Paint _lossPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) {
      return;
    }
    //generate bar
    List<Bar> bars = _generateBars(size);

    //paint bar
    for (Bar bar in bars) {
      canvas.drawRect(
        Rect.fromLTWH(
            bar.centerX - (bar.width / 2),
            size.height - bar.height - 34,
            bar.width, bar.height),
            bar.paint,
      );
    }
  }

  List<Bar> _generateBars(Size availableSpace){
    final int maxVolume = stockData!.v.reduce(max);
    final pixelPerWindow = (availableSpace.width - 80) / (stockData!.t.length + 1);

    final pixelPerStockOrder = (availableSpace.height - 50) / maxVolume;
    List<Bar> bars = [];

    for(int i = 0; i < stockData!.t.length; i++){
      bars.add(
        Bar(
          width: 3.0,
          height: stockData!.v[i] * pixelPerStockOrder + 2,
          centerX: (i + 1) * pixelPerWindow + 80,
          paint: stockData!.o[i] < stockData!.c[i] ?  _gainPaint : _lossPaint,
        ),
      );
    }
    return bars;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class StockCandlesPainter extends CustomPainter {
  StockCandlesPainter({this.stockData})
      : _wickPaint = Paint()..color = Colors.grey,
        _gainPaint = Paint()..color = Colors.green,
        _lossPaint = Paint()..color = Colors.red;

  final StatisticModel? stockData;
  final Paint _wickPaint;
  final Paint _gainPaint;
  final Paint _lossPaint;
  final double _wickWidth = 1;
  final double _candlesWidth = 3;

  @override
  void paint(Canvas canvas, Size size) {
    if (stockData == null) {
      return;
    }

    //Generate Candles
    List<Candlestick> candlestick = _generateCandles(size);

    //Paint Candlestick
    for (Candlestick candlestick in candlestick) {
      //paintWick
      canvas.drawRect(
        Rect.fromLTRB(
          candlestick.centerX - (_wickWidth / 2),
          size.height - candlestick.wickHighY,
          candlestick.centerX + (_wickWidth / 2),
          size.height - candlestick.wickLowY,
        ),
        _wickPaint,
      );
      canvas.drawRect(
        Rect.fromLTRB(
          candlestick.centerX - (_candlesWidth / 2),
          size.height - candlestick.candleHighY,
          candlestick.centerX + (_candlesWidth / 2),
          size.height - candlestick.candleLowY,
        ),
        candlestick.candlePaint,
      );
    }
  }

  List<Candlestick> _generateCandles(Size availableSpace){
    final highest = stockData!.h.reduce(max);
    final lowest = stockData!.l.reduce(min);
    final pixelPerWindow = (availableSpace.width - 50) / (stockData!.t.length + 1);

    final pixelPerDollar = (availableSpace.height - 50)  / (highest - lowest);
    final List<Candlestick> candlestick = [];
    for(int i = 0 ; i < stockData!.t.length; ++i){
      candlestick.add(
          Candlestick(
            centerX: (i + 1) * pixelPerWindow  + 50,
            wickHighY: (stockData!.h[i] - lowest) * pixelPerDollar + 37,
            wickLowY: (stockData!.l[i] - lowest) * pixelPerDollar + 37,
            candleHighY: (stockData!.o[i] - lowest) * pixelPerDollar + 37,
            candleLowY: (stockData!.c[i] - lowest) * pixelPerDollar + 37,
            candlePaint: stockData!.o[i] < stockData!.c[i] ?  _gainPaint : _lossPaint,
          )
      );
    }
    return candlestick;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class Bar {
  Bar(
      {required this.height,
      required this.width,
      required this.centerX,
      required this.paint});

  final double height;
  final double width;
  final double centerX;
  final Paint paint;
}

class Candlestick {
  Candlestick({
    required this.centerX,
    required this.wickHighY,
    required this.wickLowY,
    required this.candleHighY,
    required this.candleLowY,
    required this.candlePaint,
  });
  double centerX;
  double wickHighY;
  double wickLowY;
  double candleHighY;
  double candleLowY;
  final Paint candlePaint;
}
