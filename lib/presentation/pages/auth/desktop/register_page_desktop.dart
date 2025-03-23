import 'package:flutter/material.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/text_input.dart';
import 'package:sehattek_app/core/widgets/atom/toggle_button_general.dart';
import 'package:sehattek_app/core/widgets/molecule/footer.dart';
import 'package:sehattek_app/presentation/router/router.dart';

class RegisterPageDesktop extends StatefulWidget {
  const RegisterPageDesktop({super.key});

  @override
  State<RegisterPageDesktop> createState() => _RegisterPageDesktopState();
}

class _RegisterPageDesktopState extends State<RegisterPageDesktop> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
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
                        'Create an Account',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Sign up to get started',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const ToggleButtonGeneral(),
                  const Spacer(),
                  TextInput(
                    controller: _name,
                    label: 'Nama',
                    hintText: 'Nama',
                    type: TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  TextInput(
                    controller: _phone,
                    label: 'No. Telepon',
                    hintText: 'No. Telepon',
                    type: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
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
                  const Spacer(),
                  ButtonGeneral(
                    label: const Text('Sign Up'),
                    onPressed: () => router.go('/login'),
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
