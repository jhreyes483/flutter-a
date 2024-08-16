import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = TextEditingController(); // controlador para capturar el texto del imput
  final _focusNode      = FocusNode();

  List<ChatMessage> _messages = [
    ChatMessage(texto: 'Hola mundo', uid: '123'),
    ChatMessage(texto: 'Hola mundo', uid: '1234'),
    ChatMessage(texto: 'Hola mundo', uid: '123'),
    ChatMessage(texto: 'Hola mundo', uid: '1234'),
  ];

  bool _estaEscribiendo = false;
  //const UsuariosPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child           : Text('Ja', style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 39, 114, 205)) ),
              backgroundColor : Colors.blue[100],
              maxRadius       : 14,
            ),
            SizedBox(height: 3),
            Text('Javier Reyes', style : TextStyle(color : Colors.black87,  fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),

      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics    : BouncingScrollPhysics(),
                itemCount  : _messages.length,
                itemBuilder:(_,i) => _messages[i],
                reverse    : true,
              )
            ),

            Divider(height: 1),
            Container(
              color: Colors.white,
              child:  _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat(){
  
    return SafeArea( // se adapta segun la pantalla para que no se oculte
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8.0),
        child: Row(
          children: [
            Flexible( // hace que se expanda en su totalidad
              child: TextField( // Input
                controller   : _textController,
                onSubmitted  : _handleSubmit,
                onChanged    : (String texto){
                setState(() {
                    if( texto.trim().length > 0 ){
                      _estaEscribiendo = true;
                    }else{
                      _estaEscribiendo = false;
                    }
                  });
                },
                focusNode: _focusNode,
                decoration : InputDecoration.collapsed( // quita la linea de abajo del input
                  hintText: 'Enivar mensaje'
                ),
              ),
            ),
                    /// Boton de enviar
            Container(
              margin: EdgeInsets.symmetric(horizontal:  4.0),
              child : Platform.isIOS // seleccion de Ios o Android
              ? CupertinoButton(
                child     : Text('Enviar'), 
                onPressed : _estaEscribiendo ? () =>  _handleSubmit(_textController.text) : null
                ) 
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme( // cuando se desabilita el boton queda gris
                  data: IconThemeData( color: Colors.blue[400] ),
                  child: IconButton(
                    highlightColor : Colors.transparent, // color que resalta cuando hace click
                    splashColor    : Colors.transparent, // color que resalta cuando hace click
                    icon           : Icon(Icons.send), 
                    onPressed      : _estaEscribiendo ? () =>  _handleSubmit(_textController.text) : null
                    ,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );

  }


  _handleSubmit(String texto){
    print(texto);    
    _textController.clear(); // limpia la caja de texto
    _focusNode.requestFocus(); // hace que el teclado no se vaya al presionar enter

    final newMessage = new ChatMessage(texto: texto, uid: '123');

    _messages.insert(0,newMessage);
    setState(){
      _estaEscribiendo = false;
    }
  }
}

