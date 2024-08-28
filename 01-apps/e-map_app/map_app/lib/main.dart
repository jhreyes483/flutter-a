import 'package:flutter/material.dart';
import 'package:map_app/screens/screens.dart';

//mateapp


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapsApp',
      home: GpsAccessScreen()
    );
  }
}