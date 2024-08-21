import 'package:flutter/material.dart';

class Pagina2Page extends StatefulWidget {


  @override
  State<Pagina2Page> createState() => _Pagina2PageState();
}

class _Pagina2PageState extends State<Pagina2Page> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title:Text('pagina 2'),
      ),
      body: Center(
        child: Text('body'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.accessibility_new),
        onPressed: (){
          Navigator.pushNamed(context, 'pagina1');
        }
      ),
    );
  }
}