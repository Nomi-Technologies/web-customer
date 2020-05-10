import 'package:flutter/material.dart';
import 'package:moPass/screens/directory_screen.dart';
import 'package:moPass/screens/menuitem_screen.dart';

class NomiApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) {
          return MaterialApp(
            title: 'Nomi',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primaryColor: Colors.black,
              accentColor: Color.fromRGBO(25, 25, 25, 1),
              fontFamily: 'HKGrotesk',
              unselectedWidgetColor: Colors.white,
            ),
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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        accentColor: Color.fromRGBO(25, 25, 25, 1),
        fontFamily: 'HKGrotesk',
        unselectedWidgetColor: Colors.white,
      ),
      home: widget,
    ),
    settings: settings,
  );
}