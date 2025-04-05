import 'package:advanced_course_udemy/app/app.dart';
import 'package:advanced_course_udemy/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that plugin services are initialized before calling runApp
  await initAppModule();
  runApp(MyApp());
}
