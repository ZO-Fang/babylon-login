import 'package:babylon/providers/auth_provider.dart';
import 'package:babylon/welcome/homepage.dart';
import 'package:flutter/material.dart';
import 'package:babylon/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'models/app_user.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: Consumer(
          builder: (context, ref, child) {
            final AsyncValue<AppUser?> user = ref.watch(authProvider);
            //在这里，authProvider将用户状态的变化传递给变量user
            /**
             * authProvider 是一个 StreamProvider<AppUser?>，监听 Firebase 的 authStateChanges() 流。
                当用户状态变化时（登录/登出），authProvider 会重新构建并返回新的 AsyncValue<AppUser?>：
                用户登录 → AsyncValue.data(AppUser实例)
                用户登出 → AsyncValue.data(null)
                加载中 → AsyncValue.loading()
                错误 → AsyncValue.error(...)
             */

            return user.when(
              data: (value) {
                if (value == null){
                  return const WelcomeScreen();
                }
                return HomePage(user: value);
              },
              error: (error, _) => const Text('error loading auth status...'),
              loading: () => const Text('loading...'),
            );
          }
        )
    );
  }
}