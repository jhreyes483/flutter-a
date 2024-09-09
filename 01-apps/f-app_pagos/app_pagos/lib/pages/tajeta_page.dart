import 'package:app_pagos/models/tarjeta_credito.dart';
import 'package:app_pagos/widget/total_pay_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class TarjetaPage extends StatelessWidget {
  const TarjetaPage({super.key});

  @override
  Widget build(BuildContext context) {

    final tarjeta =  TarjetaCredito(
      cardNumberHidden: '4242',
      cardNumber: '4242424242424242',
      brand: 'visa',
      cvv: '213',
      expiracyDate: '01/25',
      cardHolderName: 'Fernando Herrera'
    );

    return Scaffold(
      appBar: AppBar( //  superponer widgets uno sobre otro
        title: const Text('Pagar'),
      ),
      body: Stack(
        children: [
        
        Container(),// hace que el Stack tome toda el area de la pantalla

        Hero(
          tag: tarjeta.cardNumber, // es un id unco que se utiliza en ambos widget para encontrar la animacion
          child: CreditCardWidget( // paquete importado
            cardNumber: tarjeta.cardNumberHidden, 
            expiryDate: tarjeta.expiracyDate,
            cardHolderName: tarjeta.cardHolderName,
            cvvCode: tarjeta.cvv,
            showBackView: false,
            onCreditCardWidgetChange: (CreditCardBrand ) {     
            },
          ),
        ),


        Positioned(
            bottom: 0,
            child: TotalPayButton()
            )
        ],
      )
    );
  }
}