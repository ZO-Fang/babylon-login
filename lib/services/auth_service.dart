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
  //不返回任何值，用户一旦登出后，FirebaseAuth.instance.currentUser 变为 null
  //接着，FirebaseAuth.instance.authStateChanges()会发送null
  //authProvider通过监听 authStateChanges() 流来实时获取用户认证状态的变化
  // 当 authStateChanges() 发送 null 时，authProvider 会立即感知到这一变化，并通知所有依赖它的 UI 组件更新状态。



  static Future<AppUser?> logIn(String email, String password) async {

    try {
      final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password);

      final user = credential.user;
      //credential.user 是 Firebase Auth 返回的 当前登录成功的用户对象（类型为 User?），包含该用户的基本信息

      if (user != null) {

        return AppUser(
            uid: credential.user!.uid,
            email: credential.user!.email!,
            name: user.displayName ?? 'Guest',
        );
      }
    } catch (e) {
      print('Login error: $e');
    }
    return null;
  }

}