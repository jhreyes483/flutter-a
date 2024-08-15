import 'package:flutter/material.dart';
class Labels extends StatelessWidget {
  final String rutaNavegar;

  

  const Labels({super.key, required this.rutaNavegar});@override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('No tinenes cuenta ?', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector( // permite ponerle cualquier texto lo reconocerlo
            child: Text('Crea una ahora!', style: TextStyle( color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {

              Navigator.pushReplacementNamed(context, this.rutaNavegar);
            },
          )
        ],
      ),
    );
  }
}