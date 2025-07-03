import 'package:babylon/design/styled_button.dart';
import 'package:babylon/design/styled_text.dart';
import 'package:babylon/services/auth_service.dart';
import 'package:flutter/material.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Form (
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //intro text
                  const Center(child: StyledText('login to your account')),
                  const SizedBox(height: 16),

                  //email address
                  TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          label: const Text('email')
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'please enter your email';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 16),

                  //password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        label: const Text('password')
                    ),
                    validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your password';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 16),

                  //error message shows here
                  if(_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red)
                    ),

                  //submit button
                  StyledButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          setState(() {
                            _errorMessage = null;
                          });

                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          final user = await AuthService.logIn(email, password);

                          if(user == null){
                            setState(() {
                              _errorMessage = 'Incorrect email or password';
                            });
                          }

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill in all fields correctly'))
                          );
                        }
                        },
                    child: const StyledButtonText('Log in'),
                  )
                ]
            )
        )
    );
  }
}
