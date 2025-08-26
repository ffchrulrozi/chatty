import 'package:chatty/routes/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthLoginPage extends StatelessWidget {
  const AuthLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(PATH.DASHBOARD),
          child: const Text("Login"),
        ),
      ),
    );
  }
}
