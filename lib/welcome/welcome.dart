import 'package:babylon/design/styled_button.dart';
import 'package:babylon/design/styled_text.dart';
import 'package:babylon/welcome/login.dart';
import 'package:babylon/welcome/signup.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool isSigned =  true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle('Babylon'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyledText('Welcome to Babylon'),

              if(isSigned)
                Column(
                    children: [
                      const SignUpForm(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const StyledNote('Already have an account?'),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isSigned = false;
                                    });
                                  },
                                  child: StyledNote('Login in instead')
                              )
                            ]
                        ),
                      )
                    ]
                ),


              if(!isSigned)
                Column(
                    children: [
                      const LoginForm(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const StyledNote('Need a new account?'),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isSigned = true;
                                    });
                                  },
                                  child: StyledNote('Sign up instead')
                              )
                            ]
                        ),
                      )
                    ]
                ),



            ]
          )

        )
      )
    );
  }
}
