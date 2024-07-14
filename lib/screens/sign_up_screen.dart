import 'package:flutter/material.dart';
import 'package:teacher_review/screens/verify_email_screen.dart';
import 'package:teacher_review/services/auth/auth_service.dart';
import 'package:teacher_review/widget/rectangular_button.dart';
import 'package:teacher_review/widget/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String email = _emailController.text;
      await AuthService.firebase().createUser(
        email: email,
        password: _passwordController.text,
      );
      await AuthService.firebase().sendEmailVerification();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
      );
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
          'Create Account',
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
                      hintText: 'Email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: 'Password',
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const Spacer(),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: RectangularButton(
                          text: 'Create Account',
                          backgroundColor:
                              const Color.fromRGBO(66, 135, 245, 1),
                          textColor: Colors.white,
                          onPressed: _signUp,
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
