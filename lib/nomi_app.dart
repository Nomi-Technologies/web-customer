import 'package:flutter/material.dart';
import 'package:moPass/screens/menuitem_screen.dart';

class NomiApp extends StatelessWidget {

  final theme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(242, 243, 245, 1.0),
    primaryColor: Colors.white,
    buttonColor: Colors.black,
    fontFamily: 'HKGrotesk',
    accentColor: Color.fromRGBO(83, 131, 236, 1),
    dividerColor: Color.fromRGBO(83, 131, 236, 0.15),
    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 18.0, color: Colors.black),
      bodyText2: TextStyle(fontSize: 18.0, color: Colors.black, fontStyle: FontStyle.italic),
      headline1: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
    ),
    unselectedWidgetColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: MenuItemScreen(id: 1)
    );
  }
}