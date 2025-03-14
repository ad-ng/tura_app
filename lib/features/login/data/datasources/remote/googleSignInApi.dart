import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApiService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: dotenv.env['SERVER_CLIENT_ID'],
    scopes: ['email', 'profile'],
  );

  // Google Sign-In method
  void googleSignIn() async {
    try {
      // Trigger the sign-in process
      var user = await _googleSignIn.signIn();

      if (user != null) {
        print("User signed in: ${user.displayName}");

        // Get the authentication details (ID Token and Access Token)
        GoogleSignInAuthentication auth = await user.authentication;

        String? idToken = auth.idToken;
        String? accessToken = auth.accessToken;

        if (idToken != null) {
          print("ID Token: $idToken");
        } else {
          print("ID Token is null");
        }

        if (accessToken != null) {
          print("Access Token: $accessToken");
        } else {
          print("Access Token is null");
        }

        // Use the tokens for authentication or API calls as needed
      } else {
        print('Sign-in failed or canceled.');
      }
    } catch (e) {
      print('Sign-in error: ${e}');
    }
  }
}
