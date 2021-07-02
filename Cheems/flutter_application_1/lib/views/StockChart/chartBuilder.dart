import 'package:flutter_application_1/controllers/AnalyticController.dart';
import 'package:flutter_application_1/controllers/SettingController.dart';
import 'package:flutter_application_1/models/statisticModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/httpServices.dart';
import 'package:flutter/src/rendering/custom_paint.dart';
import 'package:get/get.dart';

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
                          alignment: Alignment.centerLeft,
                          child: Text("stock price chart",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white60)),
                        ),
                        SizedBox(
                            child: LayoutBuilder(
                          builder: (_, constraints) => Container(
                            width: constraints.widthConstraints().maxWidth,
                            height: 245,
                            color: Colors.black45,
                            child: CustomPaint(
                              painter:
                                  StockCandlesPainter(stockData: stockData),
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("trading volume chart",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white60)),
                        ),
                        SizedBox(
                          child: LayoutBuilder(
                            builder: (_, constraints) => Container(
                              width: constraints.widthConstraints().maxWidth,
                              height: 245,
                              color: Colors.black45,
                              child: CustomPaint(
                                painter:
                                    StockVolumePainter(stockData: stockData),
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
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("stock price chart",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white60)),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("trading volume chart",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white60)),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
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
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("stock price chart",
                          style:
                              TextStyle(fontSize: 18, color: Colors.white60)),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("trading volume chart",
                          style:
                              TextStyle(fontSize: 18, color: Colors.white60)),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
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
        Rect.fromLTWH(bar.centerX - (bar.width / 2), size.height - bar.height,
            bar.width, bar.height),
        bar.paint,
      );
    }
  }

  List<Bar> _generateBars(Size availableSpace) {
    final int maxVolume =
        stockData!.v.reduce((curr, next) => curr > next ? curr : next);
    final pixelPerWindow = availableSpace.width / (stockData!.t.length + 1);

    final pixelPerStockOrder = availableSpace.height / maxVolume;
    List<Bar> bars = [];

    for (int i = 0; i < stockData!.t.length; i++) {
      bars.add(
        Bar(
          width: 3.0,
          height: stockData!.v[i] * pixelPerStockOrder,
          centerX: (i + 1) * pixelPerWindow,
          paint: stockData!.o[i] < stockData!.c[i] ? _gainPaint : _lossPaint,
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

  List<Candlestick> _generateCandles(Size availableSpace) {
    final highest =
        stockData!.h.reduce((curr, next) => curr > next ? curr : next);
    final lowest =
        stockData!.l.reduce((curr, next) => curr < next ? curr : next);
    final pixelPerWindow = availableSpace.width / (stockData!.t.length + 1);

    final pixelPerDollar = availableSpace.height / (highest - lowest);
    final List<Candlestick> candlestick = [];
    for (int i = 0; i < stockData!.t.length; ++i) {
      candlestick.add(Candlestick(
        centerX: (i + 1) * pixelPerWindow,
        wickHighY: (stockData!.h[i] - lowest) * pixelPerDollar,
        wickLowY: (stockData!.l[i] - lowest) * pixelPerDollar,
        candleHighY: (stockData!.o[i] - lowest) * pixelPerDollar,
        candleLowY: (stockData!.c[i] - lowest) * pixelPerDollar,
        candlePaint:
            stockData!.o[i] < stockData!.c[i] ? _gainPaint : _lossPaint,
      ));
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
