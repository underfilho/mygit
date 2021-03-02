import 'package:flutter/services.dart';
import 'package:mygit/pages/home_page.dart';
import 'package:mygit/utils/mycolors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Git',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryTextTheme: TextTheme(
          headline1: TextStyle(
              color: myTheme.textColor,
              fontSize: 30,
              fontWeight: FontWeight.normal),
          headline2: TextStyle(
              color: myTheme.textColor,
              fontSize: 25,
              fontWeight: FontWeight.normal),
          subtitle1: TextStyle(
              color: myTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w100),
          subtitle2: TextStyle(color: myTheme.textColor),
          caption: TextStyle(
              color: myTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w300),
        ),
      ),
      home: HomePage(),
    );
  }
}
