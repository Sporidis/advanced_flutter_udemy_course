import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // Private Named Constructor: const MyApp._internal();
  // This is a private constructor that can only be called within the class.
  MyApp._internal();

  int appState = 0;

  // Static Instance: static const MyApp instance = MyApp._internal();
  // This creates a single instance of MyApp using the private constructor.
  static final MyApp instance = MyApp._internal();

  // Factory Constructor: factory MyApp() => instance;
  // This factory constructor returns the single instance created above.
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
