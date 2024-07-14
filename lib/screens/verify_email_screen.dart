import 'package:flutter/material.dart';
import 'package:teacher_review/services/auth/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({super.key});

  final user = AuthService.firebase().currentUser;

  Future<void> _resendVerificationEmail(BuildContext context) async {
    try {
      await AuthService.firebase().sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification email sent!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send verification email: $e')),
      );
    }
  }

  Future<void> _checkEmailVerification(BuildContext context) async {
    await AuthService.firebase().initialize();
    final user = AuthService.firebase().currentUser;
    if (user!.isEmailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email not verified yet.')),
      );
    }
  }

  Future<void> _cancelAndSignOut(BuildContext context) async {
    await AuthService.firebase().logOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A verification email has been sent to ${user?.email}.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please verify your email to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _resendVerificationEmail(context),
              child: const Text(
                'Resend verification email',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _checkEmailVerification(context),
              child: const Text('I have verified my email'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _cancelAndSignOut(context),
              child: const Text(
                'Cancel and sign out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
