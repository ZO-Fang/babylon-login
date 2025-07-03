import 'package:babylon/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  static Future<AppUser?> signUp(String name, String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      if (credential.user != null) {
        print('register successfully, now prepare to displayName: $name');

        await credential.user!.updateDisplayName(name);
        await credential.user!.reload();
        final updatedUser = _firebaseAuth.currentUser;

        print('updated displayName: ${updatedUser?.displayName}');

        return AppUser(
          uid: updatedUser!.uid,
          email: updatedUser.email!,
          name: updatedUser.displayName ?? name,
        );
      }
    } catch (e) {
      print('Sign up error: $e');
    }
    return null;
  }



  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }



  static Future<AppUser?> logIn(String email, String password) async {

    try {
      final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password);

      final user = credential.user;

      if (user != null) {

        return AppUser(
            uid: credential.user!.uid,
            email: credential.user!.email!,
            name: user.displayName ?? 'Guest',
        );
      }
      return null;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

}