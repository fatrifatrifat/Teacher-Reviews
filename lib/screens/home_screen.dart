import 'package:flutter/material.dart';
import 'package:teacher_review/screens/lobby_screen.dart';
import 'package:teacher_review/screens/login_screen.dart';
import 'package:teacher_review/screens/sign_up_screen.dart';
import 'package:teacher_review/widget/rectangular_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 244, 248, 1),
      body: Stack(
        children: [
          const Image(
            image: NetworkImage(
              'https://cdn.freebiesupply.com/logos/large/2x/random-logo-png-transparent.png',
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RectangularButton(
                  text: 'Continue as Guest',
                  backgroundColor: const Color.fromRGBO(66, 135, 245, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    try {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LobbyScreen(),
                        ),
                      );
                    } catch (e) {}
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RectangularButton(
                  text: 'Login/SignUp',
                  backgroundColor: Colors.white,
                  textColor: const Color.fromRGBO(66, 135, 245, 1),
                  onPressed: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        final tween = Tween(begin: begin, end: end);
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: curve,
                        );
                        return SlideTransition(
                          position: tween.animate(curvedAnimation),
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account? Create one!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(66, 135, 245, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
