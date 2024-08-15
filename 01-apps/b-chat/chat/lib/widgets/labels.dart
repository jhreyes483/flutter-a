import 'package:flutter/material.dart';
class Labels extends StatelessWidget {
  final String rutaNavegar;
  final String texto2;
  final String texto1;

  

  const Labels({
    super.key, 
    required this.rutaNavegar, 
    required this.texto1, 
    required this.texto2
    });@override

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.texto1, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector( // permite ponerle cualquier texto lo reconocerlo
            child: Text(this.texto2, style: TextStyle( color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.rutaNavegar);
            },
          )
        ],
      ),
    );
  }
}