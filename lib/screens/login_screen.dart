import 'package:flutter/material.dart';
import 'package:teacher_review/screens/lobby_screen.dart';
import 'package:teacher_review/screens/verify_email_screen.dart';
import 'package:teacher_review/services/auth/auth_service.dart';
import 'package:teacher_review/widget/rectangular_button.dart';
import 'package:teacher_review/widget/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthService.firebase().logIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final user = AuthService.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LobbyScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connexion',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(66, 135, 245, 1),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(241, 244, 248, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFieldInput(
                      textEditingController: _emailController,
                      isPass: false,
                      hintText: 'Courriel',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: 'Mot de passe',
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Mot de passe oublié?',
                        style:
                            TextStyle(color: Color.fromRGBO(66, 135, 245, 1)),
                      ),
                    ),
                    const Spacer(),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: RectangularButton(
                          text: 'Connexion',
                          backgroundColor:
                              const Color.fromRGBO(66, 135, 245, 1),
                          textColor: Colors.white,
                          onPressed: _login,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
