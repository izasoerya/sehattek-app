import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/core/utils/textfield_validator.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/button_oauth.dart';
import 'package:sehattek_app/core/widgets/atom/hero_card.dart';
import 'package:sehattek_app/core/widgets/atom/text_button_general.dart';
import 'package:sehattek_app/core/widgets/atom/text_input.dart';
import 'package:sehattek_app/core/widgets/atom/toggle_button_general.dart';
import 'package:sehattek_app/core/widgets/molecule/footer.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_event.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';
import 'package:sehattek_app/presentation/router/router.dart';

class LoginPageDesktop extends StatefulWidget {
  const LoginPageDesktop({super.key});

  @override
  State<LoginPageDesktop> createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, snapshot) {
        if (snapshot is UserLoggedIn) {
          print('User logged in');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Center(
              child: HeroCard(
                child: Form(
                  key: _formKey, // Form key to handle validation
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
                        validator: TextfieldValidator.validateEmail,
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        controller: _password,
                        label: 'Password',
                        hintText: 'Password',
                        type: TextInputType.visiblePassword,
                        validator: TextfieldValidator.validatePassword,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButtonGeneral(
                            text: 'Forgot Password?',
                            onPressed: () => router.go('/forgot-password'),
                          ),
                        ],
                      ),
                      ButtonGeneral(
                        label: const Text('Login'),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _email.text.isNotEmpty &&
                              _password.text.isNotEmpty) {
                            context.read<AuthenticationBloc>().add(
                                  LoginEvent(_email.text, _password.text),
                                );
                          }
                        },
                      ),
                      const AuthSeparator(),
                      ButtonOauth(
                        label: 'Google',
                        icon: Icons.g_translate_outlined,
                        onPressed: () async {
                          // Handle OAuth logic here (Google login)
                          print("OAuth login triggered");
                        },
                      ),
                      SizedBox(height: 10),
                      TextButtonGeneral(
                        text: 'Belum Punya Akun?',
                        onPressed: () => router.go('/register'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Footer(), // Footer always at the bottom
        ],
      ),
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
