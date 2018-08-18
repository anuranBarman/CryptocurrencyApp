import 'package:flutter/material.dart';
import 'ui/firstscreen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MyHomePage();
    }
}

class MyHomePage extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _MyHomePageState();
    }

}

class _MyHomePageState extends State<MyHomePage> {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        home: FirstScreen(),
        theme: ThemeData(fontFamily: 'Roboto',primaryColor: Colors.white,primaryColorDark: Colors.white,)
      );
    }
}
