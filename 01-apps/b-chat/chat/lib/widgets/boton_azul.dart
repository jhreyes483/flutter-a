import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final VoidCallback? onPressed;

  const BotonAzul({super.key, required this.text, required this.onPressed});@override

  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed:  this.onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 17) ),
        ),
      ), // Texto del botón
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white, 
        elevation      : 2,
        padding        : EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

