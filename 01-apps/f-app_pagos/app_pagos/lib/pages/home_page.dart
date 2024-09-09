
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:app_pagos/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_pagos/bloc/pagar/pagar_bloc.dart';
import 'package:app_pagos/data/tarjetas.dart';
import 'package:app_pagos/pages/tajeta_page.dart';
import 'package:app_pagos/widget/total_pay_button.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pagarBloc = BlocProvider.of<PagarBloc>(context); 

    final size = MediaQuery.of(context).size; //dimenciones de la pantalla

    return Scaffold(
      appBar: AppBar (
        title: Text('Pagar'),

        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async{
              /*
              laoding 
              mostrarLoading(context);
              await Future.delayed(Duration(seconds: 1)); // tiempo de la alerta
              Navigator.pop(context); // cierre de la alerta
              */
              mostrarAlerta(context, 'Hola','Mundo');
            }
          )
        ],
      ),
      body: Stack( //  superponer widgets uno sobre otro
        children: [

          Positioned( // Centrar en el eje X
            width: size.width,
            height: size.height,
            top:200,

            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.9 /* correo hacia un lado para que se vea el borde la la otra tarjeta */
              ),
              physics: const BouncingScrollPhysics(),
            
              itemCount: tarjetas.length,
              itemBuilder: (_, i){

                final tarjeta = tarjetas[i];

                return Listener(
                  onPointerDown: (event) {
                    print(tarjeta.cardHolderName);
                    
                    pagarBloc.add(
                      OnSeleccionartarjeta(tarjeta: tarjeta)
                    );
        

                    Navigator.push(context, navegarFadeIn(context, TarjetaPage()));
                  },
                  child: Hero( // animacion
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
            
                );
              }),
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