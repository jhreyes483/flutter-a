import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PagoCompletoPage  extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pago completo'),
      ),
      body: const Center(
        child: Column( // distribuye en y
          mainAxisAlignment: MainAxisAlignment.center, // centra en y
          children: [
            Icon( FontAwesomeIcons.star, color: Colors.white54, size:100 ),
            SizedBox(height: 20), // generar una separacion
            Text('Pago realizado correctamente!', style: TextStyle(color: Colors.white, fontSize: 22))

          ],
        )
      ),
    );
  }
}