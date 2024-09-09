// mateapp
import 'package:app_pagos/pages/home_page.dart';
import 'package:app_pagos/pages/pago_completo_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'stripeApp',
     // initialRoute: 'home',
      initialRoute: 'home',
      routes: {
        'home': (_)          => HomePage(),
        'pago_completo': (_) => PagoCompletoPage(),
      }, 
      theme:ThemeData.light().copyWith(
        primaryColor: Color.fromARGB(255, 39, 71, 118),
        scaffoldBackgroundColor: Color.fromARGB(255, 30, 32, 38),
      )
    );
  }
}