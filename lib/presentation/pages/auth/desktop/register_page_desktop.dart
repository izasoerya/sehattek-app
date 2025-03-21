import 'package:flutter/material.dart';
import 'package:sehattek_app/presentation/router/router.dart';

class RegisterPageDesktop extends StatelessWidget {
  const RegisterPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Register Page',
                style: ThemeData().textTheme.bodyMedium,
              ),
              ElevatedButton(
                onPressed: () => router.go('/login'),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
