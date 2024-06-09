import 'package:firebase_auth/firebase_auth.dart';
import 'package:gla_certificate/utils/utils.dart';

class LoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signInMethod(
    String userEmail,
    String userPassword,
  ) async {
    try {
      UserCredential? credential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.toastMessage("user not found");
      } else if (e.code == 'wrong-password') {
        Utils.toastMessage('Wrong password provided.');
      }
    }
    return null;
  }
}
