import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try{

      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      print(account);
      return account;

    }catch(e){
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