import 'package:flutter/material.dart';
import '../model/CryptoData.dart';
import 'newsscreen.dart';
import 'topmarket.dart';
import 'coinchart.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  CryptoData cryptoData;

  SecondScreen(this.cryptoData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SecondScreen();
  }
}

class _SecondScreen extends State<SecondScreen> {
  Future<String> fetchAvgPrice() async {
    var url =
        'https://min-api.cryptocompare.com/data/dayAvg?fsym=${widget.cryptoData.symbol}&tsym=INR';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Map<String, dynamic> responseJSON = json.decode(response.body);
      if (responseJSON["INR"] != null) {
        return (responseJSON["INR"] as num).toStringAsFixed(2);
      }
    } else {
      // If that response was not OK, throw an error.
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  widget.cryptoData.name,
                  style: TextStyle(
                      fontFamily: 'RobotoBold',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                widget.cryptoData.symbol,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 80.0,
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                  '\u20B9 ${widget.cryptoData.quoteData.price.toDouble().toStringAsFixed(2)}',
                  style: TextStyle(
                      fontFamily: 'RobotoLight',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35.0),
                  textAlign: TextAlign.center,
                ),
                ),
                FutureBuilder(
                  future: fetchAvgPrice(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FittedBox(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Average Price Today:',
                              style: TextStyle(
                                  fontFamily: 'RobotoLight',
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\u20B9 ${snapshot.data}',
                              style: TextStyle(
                                fontFamily: 'RobotoBold',
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ]),
            ),
            Container(
              height: 340.0,
              child: Card(
                child: SimpleTimeSeriesChart(widget.cryptoData.symbol),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Coin Info',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontFamily: 'RobotoBold',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Market Cap',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'RobotoLight',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\u20B9 ${widget.cryptoData.quoteData.market_cap.toDouble().toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'RobotoLight',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Volume (24h)',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'RobotoLight',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\u20B9 ${widget.cryptoData.quoteData.volume_24h.toDouble().toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'RobotoLight',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Supply',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'RobotoLight',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.cryptoData.total_supply.toDouble().toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'RobotoLight',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                '${widget.cryptoData.name} News',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontFamily: 'RobotoBold',
                    fontWeight: FontWeight.bold),
              ),
            ),
            NewsScreen(250.0, widget.cryptoData.symbol),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Top Markets',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontFamily: 'RobotoBold',
                    fontWeight: FontWeight.bold),
              ),
            ),
            TopMarketScreen(widget.cryptoData.symbol)
          ],
        ),
      ),
    );
  }
}
