// mateapp
import 'package:app_pagos/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_pagos/bloc/pagar/pagar_bloc.dart';
import 'package:app_pagos/pages/home_page.dart';
import 'package:app_pagos/pages/pago_completo_page.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    StripeService().init();
    
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PagarBloc() ), // usa el bloc en el context de manera global
      ],

      child: MaterialApp(
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
      ),
    );
  }
}