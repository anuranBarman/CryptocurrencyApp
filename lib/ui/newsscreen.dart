import 'package:flutter/material.dart';
import '../model/news.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsScreen extends StatefulWidget {
  
  double height;
  String symbol;

  NewsScreen(this.height,this.symbol);

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _NewsScreen();
    }
}

class _NewsScreen extends State<NewsScreen> {

  Future<List<NewsModel>> fetchNews() async {
    List<NewsModel> news = [];
    var url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN';
    if(widget.symbol != ""){
      url = url+"&categories=${widget.symbol}";
    }
    final response = await http.get(
        url
        );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Map<String, dynamic> responseJSON = json.decode(response.body);
      if (responseJSON["Data"] != null && responseJSON["Data"].length > 0) {
        for (int i = 0; i < responseJSON["Data"].length; i++) {
          news.add(NewsModel.fromJSON(responseJSON["Data"][i]));
        }
        print(news.length);
        return news;
      }
    } else {
      // If that response was not OK, throw an error.
      return null;
    }
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return FutureBuilder<List<NewsModel>>(
              future: fetchNews(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: widget.height == 0.0 ? MediaQuery.of(context).size.height : widget.height,
                    child: Card(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var datetime = DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data[index].published_on*1000);
                          print(datetime.day);
                          var format = DateFormat("dd/MM/yyyy");
                          var dateString = format.format(datetime);
                          return GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0, left: 20.0, right: 20.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '${snapshot.data[index].title}',
                                    style: TextStyle(
                                        fontFamily: 'RobotoLight',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '${dateString}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 5.0),
                                        child: Container(
                                          width: 20.0,
                                          height: 20.0,
                                          child: Image.network(
                                              '${snapshot.data[index].img}'),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data[index].name}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black87,
                                    height: 10.0,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height -
                                        100,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: 200.0,
                                            child: Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: FittedBox(
                                                child: Image.network(
                                                    '${snapshot.data[index].imageURL}'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20.0, right: 20.0),
                                            child: Text(
                                              '${snapshot.data[index].title}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                  fontFamily: 'RobotoBold'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 10.0,
                                                left: 20.0, right: 20.0),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  '${dateString}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 5.0),
                                                  child: Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    child: Image.network(
                                                        '${snapshot.data[index].img}'),
                                                  ),
                                                ),
                                                Text(
                                                  '${snapshot.data[index].name}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left:20.0,right: 20.0,top: 5.0),
                                            child: Divider(color: Colors.black,height: 10.0,),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0),
                                            child: Text('${snapshot.data[index].body}',style: TextStyle(fontFamily: 'RobotoLight',fontStyle: FontStyle.italic,color: Colors.black38),),
                                          ),
                                          ListTile(
                                            trailing: FlatButton(
                                              textColor: Colors.green,
                                              child: Text('Read More',style: TextStyle(fontFamily: 'RobotoBold'),),
                                              onPressed: () async {
                                                var url = '${snapshot.data[index].url}';
                                                if (await canLaunch(url)) {
                                                  await launch(url,forceWebView: true,forceSafariVC: true);
                                                } else {
                                                  print("Can not launch");
                                                }
                                              },  
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                } else if(snapshot.hasError) {
                  return Container(
                    height: widget.height == 0.0 ? MediaQuery.of(context).size.height : widget.height,
                    child: Center(
                      child: Text('No News Available'),
                    ),
                  );
                } else {
                  return Container(
                    height: widget.height == 0.0 ? MediaQuery.of(context).size.height : widget.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
    }
}