import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ManuelMarker extends StatelessWidget {
  const ManuelMarker({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; // adapta a toda la pantalla 
    return SizedBox( // similar al container
      width: size.width,
      height: size.height,
      child: Stack( // sirve para colocar un widget encima de otro
        children: [
          Transform.translate( // sube un poco en el offset
            offset: const Offset(0,-22),
            child: Center(
              child: BounceInDown( // animacion para que caiga el icono
                from: 100,
                child:  Icon(Icons.location_on_rounded, size: 50)
                ),
            ),
          )
        ],
      )
    );
  }
}