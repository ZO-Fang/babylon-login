import 'package:babylon/design/styled_button.dart';
import 'package:babylon/design/styled_text.dart';
import 'package:babylon/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:babylon/models/app_user.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle('Babylon'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledText(
              'Hey, ${user.name}!',
            ),
            const StyledText('You are successfully logged in.'),
            const SizedBox(height:20),
            StyledButton(
              onPressed: () {
                AuthService.signOut();
              },
              child:const StyledButtonText('log out')
            )
          ]
        )


      ),
    );
  }
}
