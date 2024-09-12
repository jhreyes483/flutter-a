import 'package:auth_app/services/google_signin_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          backgroundColor: Colors.blue, // Color de fondo de la AppBar
          foregroundColor: Colors.white, // Color del texto y los íconos en la AppBar
          title: const Text('AuthApp - google - Apple' ),
          actions: [
            IconButton(
                icon: const Icon(FontAwesomeIcons.doorOpen), onPressed: () {})
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white, // Color de fondo del Container
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    splashColor: Colors.transparent, 
                    minWidth: double.infinity, // toma todo el ancho
                    height: 40,
                    color: Colors.red,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.google, color: Colors.white),
                        Text(' Sign in whit Google', style: TextStyle(color: Colors.white, fontSize: 17))
                      ],
                    ), 

                    onPressed: ()  {
                      GoogleSignInService.signInWithGoogle();
                    }
                )
              ],
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
    );
  }
}
