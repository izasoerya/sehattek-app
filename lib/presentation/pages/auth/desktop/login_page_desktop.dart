import 'package:flutter/material.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/button_oauth.dart';
import 'package:sehattek_app/presentation/router/router.dart';
import 'package:sizer/sizer.dart';

class LoginPageDesktop extends StatefulWidget {
  const LoginPageDesktop({super.key});

  @override
  State<LoginPageDesktop> createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> {
  late final width = 100.sw;
  late final height = 100.sh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 450,
        height: 450,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Sign in to Your Account',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            ButtonGeneral(
              label: Text('Login'),
              onPressed: () => router.go('/register'),
            ),
            const SizedBox(height: 10),
            ButtonOauth(
              label: Text('Google'),
              icon: Icons.g_translate_outlined,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
