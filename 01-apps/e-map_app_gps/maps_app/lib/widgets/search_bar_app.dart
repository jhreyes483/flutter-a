import 'package:flutter/material.dart';

class SearchBarApp extends StatelessWidget {
  const SearchBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        // color: Colors.red,
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: (){
           print('ddddd');
          },
          child: Container( 
          padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 13),
          child: const Text('Donde quieres ir?', style: const TextStyle(color: Colors.black87)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5)
              )
            ]
          ),
          

          )
        ),
      ),
    );
  }
}