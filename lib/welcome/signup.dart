import 'package:babylon/design/styled_button.dart';
import 'package:babylon/design/styled_text.dart';
import 'package:babylon/providers/auth_provider.dart';
import 'package:babylon/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
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
                  const Center(child: StyledText('sign up a new account')),
                  const SizedBox(height: 16),

                  TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_box),
                        label: const Text('full name'),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      }
                  ),

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
                       if (value.length < 8) {
                         return 'password must be greater than or equal to 8 characters';
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


                  StyledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _errorMessage = null;
                        });

                        final name = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        final user = await AuthService.signUp(name, email, password);

                        if(user == null){
                          setState(() {
                            _errorMessage = 'incorrect information';
                          });
                        }

                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Sign up successfully! Welcome'))
                          );

                          ref.invalidate(authProvider); // 标记 authProvider 失效，触发刷新

                          print('✅ User created: ${user.email}, UID: ${user.uid}');

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Sign up failed. Please try again.'))
                          );
                        }


                      }
                    },
                    child: const StyledButtonText('Sign Up'),
                  )

                ]
            )
        )
    );
  }
}
