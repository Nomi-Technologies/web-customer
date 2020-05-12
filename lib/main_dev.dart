import 'package:flutter/material.dart';
import 'package:moPass/app_config.dart';
import 'package:moPass/nomi_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final app = new AppConfig(
    apiBaseUrl: "http://localhost:3000",
    child: NomiApp()
  );

  runApp(app);
}