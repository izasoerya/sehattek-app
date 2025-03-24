import 'package:flutter/material.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/button_oauth.dart';
import 'package:sehattek_app/core/widgets/atom/text_button_general.dart';
import 'package:sehattek_app/core/widgets/atom/text_input.dart';
import 'package:sehattek_app/core/widgets/atom/toggle_button_general.dart';
import 'package:sehattek_app/core/widgets/molecule/footer.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_event.dart';
import 'package:sehattek_app/presentation/router/router.dart';

class LoginPageDesktop extends StatefulWidget {
  const LoginPageDesktop({super.key});

  @override
  State<LoginPageDesktop> createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Center(
            child: Container(
              width: 350,
              height: 420,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
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
                  const Spacer(),
                  const ToggleButtonGeneral(),
                  const Spacer(),
                  TextInput(
                    controller: _email,
                    label: 'Email',
                    hintText: 'Email',
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextInput(
                    controller: _password,
                    label: 'Password',
                    hintText: 'Password',
                    type: TextInputType.visiblePassword,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButtonGeneral(text: 'Lupa Sandi?', onPressed: () {}),
                    ],
                  ),
                  const Spacer(),
                  ButtonGeneral(
                    label: const Text('Login'),
                    onPressed: () => router.go('/register'),
                  ),
                  const AuthSeparator(),
                  ButtonOauth(
                    label: 'Google',
                    icon: Icons.g_translate_outlined,
                    onPressed: () async {
                      final res = AuthenticationBloc()
                          .add(LoginEvent(_email.text, _password.text));
                      print("email: ${_email.text}");
                      print("password: ${_password.text}");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const Footer(), // Footer always at the bottom
      ],
    );
  }
}

class AuthSeparator extends StatelessWidget {
  const AuthSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey.withValues(alpha: 0.5),
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Have Google Account?',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.withValues(alpha: 0.5),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
