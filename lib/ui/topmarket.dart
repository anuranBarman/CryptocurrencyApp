import 'package:flutter/material.dart';
import '../model/news.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/topmarketmodel.dart';

class TopMarketScreen extends StatefulWidget {
  String symbol;

  TopMarketScreen(this.symbol);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TopMarketState();
  }
}

class _TopMarketState extends State<TopMarketScreen> {
  Future<List<TopMarketData>> fetchMarkets() async {
    List<TopMarketData> markets = [];
    var url =
        'https://min-api.cryptocompare.com/data/top/exchanges/full?fsym=${widget.symbol}&tsym=INR';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Map<String, dynamic> responseJSON = json.decode(response.body);
      if (responseJSON["Data"]["Exchanges"] != null &&
          responseJSON["Data"]["Exchanges"].length > 0) {
        for (int i = 0; i < responseJSON["Data"]["Exchanges"].length; i++) {
          markets.add(
              TopMarketData.fromJSON(responseJSON["Data"]["Exchanges"][i]));
        }
        print(markets.length);
        return markets;
      }
    } else {
      // If that response was not OK, throw an error.
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var widthFinal = (MediaQuery.of(context).size.width - 50.0) / 3;
    return FutureBuilder<List<TopMarketData>>(
      future: fetchMarkets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 250.0,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20.0,
                        child: Text('#',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontFamily: 'RobotoBold'),textAlign: TextAlign.center,),
                      ),
                      Container(
                        width: widthFinal,
                        child: Text('Exchange',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontFamily: 'RobotoBold'),textAlign: TextAlign.center,),
                      ),
                      Container(
                        width: widthFinal,
                        child: Text('Pair',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontFamily: 'RobotoBold'),textAlign: TextAlign.center,),
                      ),
                      Container(
                        width: widthFinal,
                        child: Text('Price',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontFamily: 'RobotoBold'),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                  Divider(color: Colors.black54,height: 10.0,),
                  Expanded(
                    child: ListView.builder(
                    
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Row(
                        children: <Widget>[
                          Container(
                            width: 20.0,
                            child: FittedBox(
                              child: Text('${index+1}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                              fit:BoxFit.scaleDown,
                            ),
                          ),
                          Container(
                            width: widthFinal,
                            child: FittedBox(
                              child: Text(
                            '${snapshot.data[index].market}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                              fit: BoxFit.scaleDown,
                            ),
                          )
                          ,
                          Container(
                            width: widthFinal,
                            child: FittedBox(
                              child: Text(
                            '${snapshot.data[index].fromSymbol}/${snapshot.data[index].toSymbol}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                              fit: BoxFit.scaleDown,
                            ),
                          )
                          ,
                          Container(
                            width: widthFinal,
                            child: FittedBox(
                              child: Text(
                            '\u20B9 ${snapshot.data[index].price.toDouble().toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black54,height: 10.0,)
                        ],
                      );
                    },
                  ),
                  )
                ],
              ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            height: 100.0,
            child: Center(
              child: Text('No Markets Available'),
            ),
          );
        } else {
          return Container(
            height: 250.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
