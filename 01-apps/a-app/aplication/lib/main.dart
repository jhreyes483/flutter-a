import 'package:aplication/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:aplication/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        // estancias de providers
        ChangeNotifierProvider(create:( _ ) => SocketService() )

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
       // initialRoute: 'status',
       initialRoute: 'home',
        routes: getApplicationRoutes(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: const Center(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}