import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
        home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Container(
          color: Colors.blueAccent, // Color de fondo del Container
          child: Center(
            child: Text(
              'Hello World!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      // initialRoute: 'page1',
      /*
      routes: {
        //'page1': (context) => Page1(),
        //'page2': (context) => Page2(),
      },
      */
    )  
    );
  }
}