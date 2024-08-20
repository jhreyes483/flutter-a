import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with  ChangeNotifier {

  Usuario? usuario;
  bool _autenticando = false;


  bool get autenticando => this._autenticando;
  set autenticando(bool valor){
    this._autenticando = valor;
    notifyListeners();
  }

  Future login(String email, String password) async {
    this.autenticando = true;

    final data = {
      'email' : email,
      'password' : password
    };
    final uri   = Uri.parse('${Environment.apiUrl}/login');
    final resp  = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    if( resp.statusCode == 200){
        final loginResponse = loginResponseFromJson( resp.body );
        this.usuario       = loginResponse.usuario;
        this.autenticando =false;
        return true;
    }else{
      this.autenticando =false;
      return false;
    }

  }

}