import 'package:flutter/material.dart';
import 'package:sehattek_app/presentation/router/router.dart';

class LoginPageMobile extends StatelessWidget {
  const LoginPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Page',
                style: ThemeData().textTheme.bodyMedium,
              ),
              ElevatedButton(
                onPressed: () => router.go('/register'),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
