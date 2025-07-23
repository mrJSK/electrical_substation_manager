import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// TODO: Create this file
import 'sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // Auth state listener will navigate to SignInScreen
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Successfully Logged In!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
