import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

// 10
enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
/*
  SocketService(){
    this._initConfig();
  }
*/

  void connect() async {

    final token = await AuthService.getToken();

    // Dart client
    this._socket = IO.io(Environment.socketUrl, {
      'transports' : ['websocket'],
      'autoConnect': true,
      'forceNew' : true, // cada vez que el ciente se desconecta y se vuelve a conectar va crear una nueva estancia 
      'extraHeaders' : {
        'x-token': token
      }
    });
    this._socket.onConnect((_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

/*
    socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
*/
  this._socket.on('disconnect', (_)  {
      //print('desconexxon 1111');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
  });

  this._socket.on('nuevo-mensaje', (payload) {
    print('nuevo-mensaje:');
    print(payload.containsKey('nombre') ? 'nombre:' + payload['nombre'] : ''  );
    print(payload.containsKey('mensaje') ? 'mensaje:' + payload['mensaje']: '' );      
    print(payload.containsKey('mensaje2') ? 'mensaje2:' + payload['mensaje2']: 'No hay msg2' );    
  });

    //socket.on('event', (data) => print(data));
  
    //socket.on('fromServer', (_) => print(_));
  } 

  void disconnect(){
    this._socket.disconnect();
  }

}