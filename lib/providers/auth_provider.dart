import 'package:babylon/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {
  //创建一个能自动销毁的 Stream Provider，用于监听和管理用户的认证状态（登录/登出），并将 Firebase 的用户数据转换为应用内的 AppUser 模型
  //当没有东西需要监听时会自动释放资源
  //async*用来生成一个异步的 Stream，并通过 yield 或 yield* 连续返回多个值，适用于：
  // 定时推送数据（如心跳、倒计时）
  // 数据分页加载
  // 响应 Firebase 实时数据、Socket、传感器等流式事件

  final stream = FirebaseAuth.instance.authStateChanges();
  /**
   * authStateChanges()：
      Firebase Auth 提供的 Stream<User?>，会在以下情况推送事件：
      用户登录 → 推送 User 对象。
      用户登出 → 推送 null。
      用户信息更新（如修改名称）→ 推送更新后的 User 对象。
   */

  await for (final user in stream) {
    //if user is logged in
    if (user != null) {

      // wait for a while to ensure user's name is updated.
      await Future.delayed(Duration(milliseconds: 500));

      // refresh user's info
      await user.reload();
      final currentUser = FirebaseAuth.instance.currentUser;

      print('displayName: ${currentUser?.displayName}');

      //将 Firebase 的 User 对象转换为应用内的 AppUser 模型，并通过流推送给监听者consumer
      //if user is logged in, authProvider yields AppUser object to consumer
      yield AppUser(
        uid: currentUser!.uid,
        email: currentUser.email!,
        name: currentUser.displayName ?? 'New user',
      );
    } else {
      //if user is not logged in,then authProvider yields null to consumer
      yield null;
    }
  }
});
