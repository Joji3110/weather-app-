import 'package:flutter/material.dart';
import 'package:wether_example/screens/location_screen.dart';
import 'package:wether_example/screens/weather_worecast_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LocationScreen(),
    );
  }
}
