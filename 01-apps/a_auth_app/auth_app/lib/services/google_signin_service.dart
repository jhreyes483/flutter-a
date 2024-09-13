// ignore_for_file: prefer_const_declarations

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


class GoogleSignInService {
  
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  static Future<GoogleSignInAccount?> signInWithGoogle() async {
 try {
      final idToken = null;
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        final String? idToken = auth.idToken;
        print(account);

        // Imprimir el token de ID
        if (idToken != null) {
          print('Token de ID: $idToken');
        } else {
          print('No se pudo obtener el token de ID.');
        }
      } else {
        print('No se pudo autenticar al usuario.');
      }

           // print('======== ID TOKEN ========= ');
      // print( googleKey.idToken );


      /* peticion http backend */      
      final signInWithGoogleEndpoint = Uri(
        scheme: 'https',
        host: 'apple-google-sign-in.herokuapp.com',
        path: '/google'
      );

      final session = await http.post(
        signInWithGoogleEndpoint,
        body: {
          'token': idToken
        }
      );

      print('====== backend =======');
      print( session.body );


      return account;
    } catch (e) {
      print('Error en google signin');
      print(e);
      return null;
    }

  }

  static Future<GoogleSignInAccount?> signOut() async {
    try{

     await _googleSignIn.signOut();

    }catch(e){
      print('Error en google signOut');
      print(e);
      return null;
    }

  }

}