import 'package:flutter/material.dart';
import 'package:moPass/screens/directory_screen.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) {
          return MaterialApp(
            title: 'Nomi',
            theme: theme,
            home: DirectoryScreen(),
          );
        }
      },
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name);
        if (uri.path == '/restaurant') {
          int id;
          final String idStr = uri.queryParameters['id'];
          if (idStr != null && int.tryParse(idStr) != null) {
            id = int.tryParse(idStr);
            return _getMaterialApp(MenuItemScreen(id: id, landingPage: true), settings);
          }
        }
        return _getMaterialApp(DirectoryScreen(), settings);
      },
    );
  }

  Route _getMaterialApp(Widget widget, RouteSettings settings) => MaterialPageRoute(
    builder: (context) => MaterialApp(
      title: 'Nomi',
      theme: theme,
      home: widget,
    ),
    settings: settings,
  );
}