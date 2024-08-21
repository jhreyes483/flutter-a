import 'package:chat/global/environment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  
  Usuario? usuarioPara;

  Future getChat( String usuarioID ) async {
    final uri   = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');
    final resp  = await http.get(uri,
      headers: {
        'Content-Type' : 'application/json',
        'x-token': await AuthService.getToken(),
      }
    );

    final MensajesResponse = mensajesResponseFromJson(resp.body);
    return MensajesResponse.mensajes;
/*
    if( resp.statusCode == 200){
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario       = loginResponse.usuario;
      this.autenticando =false;

      await this._guardarToken(loginResponse.token);
      return true;
    }else{
      this.logout();
      return false;
    }
  }
*/
  } 

}