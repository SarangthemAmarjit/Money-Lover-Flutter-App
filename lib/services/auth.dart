import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Create user obj based on FirebaseUser

  Future Googlesignout() async {
    try {
      return await _googleSignIn.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
