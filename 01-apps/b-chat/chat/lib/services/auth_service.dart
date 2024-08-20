import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with  ChangeNotifier {

  Usuario? usuario;
  bool _autenticando = false;
  // Create storage
  final _storage = new FlutterSecureStorage();


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

        await this._guardarToken(loginResponse.token);
        return true;
    }else{
      this.autenticando =false;
      return false;
    }

  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token')??'';
    final uri   = Uri.parse('${Environment.apiUrl}/login/renew');
    final resp  = await http.get(uri,
      headers: {
        'Content-Type' : 'application/json',
        'x-token': token,
      }
    );
    print(resp.body);
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


  Future register(String email, String nombre,String password) async {
    final data = {
      'email'    : email,
      'nombre'   : nombre,
      'password' : password
    };
    final uri   = Uri.parse('${Environment.apiUrl}/login/new');
    final resp  = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    print(resp.body);
    this.autenticando = false;
    if( resp.statusCode == 200){
        return true;
    }else{
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  // Getter del token de forma estática
  static Future<String> getToken() async{
      final _storage = new FlutterSecureStorage();
      final token    = await _storage.read(key: 'token');
      return token??'';
  }

  static Future<void> deleteToken() async{
      final _storage = new FlutterSecureStorage();
      await _storage.delete(key: 'token');
  } 




  Future _guardarToken( String token) async{
    return await _storage.write(
      key: 'token', 
      value: token
    );
  }

  Future logout() async{
    return await _storage.delete(
      key: 'token', 
    );
  }

}