import 'package:babylon/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {
  final stream = FirebaseAuth.instance.authStateChanges();

  await for (final user in stream) {
    if (user != null) {

      // wait for a while to ensure user's name is updated.
      await Future.delayed(Duration(milliseconds: 500));

      // refresh user's info
      await user.reload();
      final currentUser = FirebaseAuth.instance.currentUser;

      print('displayName: ${currentUser?.displayName}');

      yield AppUser(
        uid: currentUser!.uid,
        email: currentUser.email!,
        name: currentUser.displayName ?? 'New user',
      );
    } else {
      yield null;
    }
  }
});
