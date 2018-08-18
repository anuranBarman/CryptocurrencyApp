import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('This app uses CoinMarketCap API and CryptoCompare API for showing the Data.I am very thankful for their service.\n\n\n'+
        'CoinMarketCap: https://coinmarketcap.com/'+'\n\nCryptoCompare: https://www.cryptocompare.com/ \n\n\n'+
        'Made with ❤ by Anuran Barman.',style: TextStyle(
          fontFamily: 'RobotoLight',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
        ),),
        ),
      );
    }
}