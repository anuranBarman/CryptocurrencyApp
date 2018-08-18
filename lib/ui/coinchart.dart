import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../model/dailycointdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SimpleTimeSeriesChart extends StatefulWidget {
  String symbol;

  SimpleTimeSeriesChart(this.symbol);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SimpleTimeSeriesChart();
  }
}

class _SimpleTimeSeriesChart extends State<SimpleTimeSeriesChart> {
  var url;
  String groupV;

  Widget _createChart(List<DailyCoinData> chartData) {
    return Column(
      children: <Widget>[
        Container(
          height: 250.0,
          child: new charts.TimeSeriesChart(
          _createCoinData(chartData),
          animate: true,
          dateTimeFactory: const charts.LocalDateTimeFactory(),
          behaviors: [charts.PanAndZoomBehavior()],
        ),
        ),
        FittedBox(
          alignment: Alignment.center,
          child: Row(
          children: <Widget>[
            Radio(
              value:
                  'https://min-api.cryptocompare.com/data/histominute?fsym=${widget.symbol}&tsym=INR',
              activeColor: Colors.greenAccent,
              onChanged: (value) {
                setState(() {
                  url = value;
                  groupV=value;
                });
              },
              groupValue: url,
            ),
            Text('1D',style: TextStyle(fontFamily: 'RobotoBold',color: Colors.green,fontWeight: FontWeight.bold),),
            Radio(
              value:
                  'https://min-api.cryptocompare.com/data/histohour?fsym=${widget.symbol}&tsym=INR',
              activeColor: Colors.greenAccent,
              onChanged: (value) {
                setState(() {
                  url = value;
                  groupV=value;
                });
              },
              groupValue: groupV,
            ),
            Text('7D',style: TextStyle(fontFamily: 'RobotoBold',color: Colors.green,fontWeight: FontWeight.bold),),
            Radio(
              value:
                  'https://min-api.cryptocompare.com/data/histoday?fsym=${widget.symbol}&tsym=INR',
              activeColor: Colors.greenAccent,
              onChanged: (value) {
                setState(() {
                  url = value;
                  groupV=value;
                });
              },
              groupValue: groupV,
            ),
            Text('1M',style: TextStyle(fontFamily: 'RobotoBold',color: Colors.green,fontWeight: FontWeight.bold),),
          ],
        ),
        )
      ],
    );
  }

  Future<List<DailyCoinData>> fetchCoinData() async {
    List<DailyCoinData> datas = [];

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Map<String, dynamic> responseJSON = json.decode(response.body);
      if (responseJSON["Data"] != null && responseJSON["Data"].length > 0) {
        for (int i = 0; i < responseJSON["Data"].length; i++) {
          datas.add(DailyCoinData.fromJSON(responseJSON["Data"][i]));
        }
        print(datas.length);
        return datas;
      }
    } else {
      // If that response was not OK, throw an error.
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    url =
        'https://min-api.cryptocompare.com/data/histominute?fsym=${widget.symbol}&tsym=INR';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchCoinData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: _createChart(snapshot.data),
          );
        } else if (snapshot.hasError) {
          return Text('No Chart Data Available');
        } else {
          return Container(
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<DailyCoinData, DateTime>> _createCoinData(
      List<DailyCoinData> dailyCoinData) {
    return [
      new charts.Series<DailyCoinData, DateTime>(
        id: 'Prices',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (DailyCoinData da, _) => da.time,
        measureFn: (DailyCoinData da, _) => da.price.toInt(),
        data: dailyCoinData,
      )
    ];
  }
}
