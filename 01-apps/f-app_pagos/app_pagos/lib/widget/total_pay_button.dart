import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_pagos/bloc/pagar/pagar_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalPayButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 15), // evita que el contenido se pegue a los bordes
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total', style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold  )),
              Text('250.55 USD', style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold ))
            ],
          ),

          BlocBuilder<PagarBloc, PagarState>(
            builder: (context, state) {
              print(state);
              return _BtnPay(state: state);
            },
          )
          
        ],
      ),
    );
  }

}

class _BtnPay extends StatelessWidget {

  final  PagarState state;

  const _BtnPay({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return state.tarjetaActiva 
    ? buildBotonTarjeta(context)
    : buildAppleAndGooglePay(context);
  }

  Widget buildBotonTarjeta(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: const Row(
        children: [
          Icon( FontAwesomeIcons.solidCreditCard, color: Colors.white),
          Text('  Pagar', style: TextStyle(color: Colors.white, fontSize: 22))
        ],
      ),

      onPressed: (){}
      );
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: const Row(
        children: [
          Icon( FontAwesomeIcons.google, color: Colors.white),
          Text(' Pay', style: TextStyle(color: Colors.white, fontSize: 22))
        ],
      ),

      onPressed: (){}
      );
  }
}