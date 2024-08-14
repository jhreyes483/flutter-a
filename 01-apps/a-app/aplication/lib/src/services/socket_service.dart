import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';


enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;

  get serverStatus => this._serverStatus;

  SocketService(){
    this._initConfig();
  }

  void _initConfig(){
    // Dart client
    IO.Socket socket = IO.io('http://192.168.0.4:3000/', {
      'transports' : ['websocket'],
      'autoConnect': true
    });
    socket.onConnect((_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

/*
    socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
*/
  socket.on('disconnect', (_)  {
      //print('desconexxon 1111');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
  });

  socket.on('nuevo-mensaje', (payload) {
    print('nuevo-mensaje:');
    print('nombre:' + payload['nombre']);
    print('mensaje:' + payload['mensaje']);      
  });

    //socket.on('event', (data) => print(data));
  
    //socket.on('fromServer', (_) => print(_));
  } 

}