import 'dart:io';



import 'package:chat/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/socket_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:chat/models/usuario.dart';



class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController(); // controlador para capturar el texto del imput
  final _focusNode      = FocusNode();
  bool _isInitialized   = false;
  
  late final ChatService   chatService;
  late final SocketService socketService;
  late final AuthService   authService;

  List<ChatMessage> _messages = [];

/*
  List<ChatMessage> _messages = [
    ChatMessage(texto: 'Hola mundo', uid: '123'),
    ChatMessage(texto: 'Hola mundo', uid: '1234'),
    ChatMessage(texto: 'Hola mundo', uid: '123'),
    ChatMessage(texto: 'Hola mundo', uid: '1234'),
  ];
*/
  List<AnimationController> _animationControllers = [];

  bool _estaEscribiendo = false;


  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { // valida que este listo

      this.chatService   = Provider.of<ChatService>(context, listen: false);
      this.socketService = Provider.of<SocketService>(context, listen: false);
      this.authService   = Provider.of<AuthService>(context, listen: false);
      this.socketService.socket.on('mensaje-personal', _escucarMensaje );

      setState(() {
        _isInitialized = true; // Mark as initialized
      });
    });
// 66bfc329d90e698f05729fa3

    // this.socketService.socket.on('mensaje-personal', _escucharMensaje );
    // _cargarHistorial( this.chatService.usuarioPara.uid );
  } 

  void _escucarMensaje(dynamic payload){
    print('tengo mensaje!--------------------------------------- $payload');
    

    final newAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    
    final newMessage = new ChatMessage(
      texto: payload['mensaje'], 
      uid: payload['de'], 
      animationController : newAnimationController
    );

    setState(() {
      _messages.insert(0, newMessage);
      _animationControllers.add(newAnimationController);
      _estaEscribiendo = false;
    });

    newAnimationController.forward().then((_) {
      // Remove the controller once the animation is completed
      _animationControllers.remove(newAnimationController);
      newAnimationController.dispose();
    });
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Center(child: CircularProgressIndicator()); // Muestra carga mietras se inicia el componente
    }
    final usuarioPara = chatService.usuarioPara;



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child           : Text(usuarioPara?.nombre?.substring(0, 2) ?? '' , style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 39, 114, 205)) ),
              backgroundColor : Colors.blue[100],
              maxRadius       : 14,
            ),
            SizedBox(height: 3),
            Text(usuarioPara?.nombre ?? '', style : TextStyle(color : Colors.black87,  fontSize: 12))
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
    if (!_isInitialized) {
      return Center(child: CircularProgressIndicator()); // Muestra carga mietras se inicia el componente
    }
    if (texto.trim().isEmpty) return;

    _textController.clear(); // limpia la caja de texto
    _focusNode.requestFocus(); // hace que el teclado no se vaya al presionar enter

    final newAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    
    final newMessage = new ChatMessage(
      texto              : texto, 
      uid                : this.authService.usuario?.uid??'', 
      animationController : newAnimationController
    );

    setState(() {
      _messages.insert(0, newMessage);
      _animationControllers.add(newAnimationController);
      _estaEscribiendo = false;
    });
    print('envie mensaje');
    print( this.authService.usuario?.uid);
    this.socketService.emit('mensaje-personal',
      {
        'de'      : this.authService.usuario?.uid,
        'para'    : this.chatService.usuarioPara?.uid,
        'mensaje' : texto
      }
    );

    newAnimationController.forward().then((_) {
      // Remove the controller once the animation is completed
      _animationControllers.remove(newAnimationController);
      newAnimationController.dispose();
    });
  }
}

