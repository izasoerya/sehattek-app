import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/core/utils/textfield_validator.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/auth_container.dart';
import 'package:sehattek_app/core/widgets/atom/text_button_general.dart';
import 'package:sehattek_app/core/widgets/atom/text_input.dart';
import 'package:sehattek_app/core/widgets/atom/toggle_button_general.dart';
import 'package:sehattek_app/core/widgets/molecule/footer.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_event.dart';
import 'package:sehattek_app/presentation/router/router.dart';
import 'package:sizer/sizer.dart';

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
  final _formKey = GlobalKey<FormState>();

  bool admin = true;
  void adminCallback(bool isAdmin) => admin = isAdmin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Center(
            child: AuthContainer(
              child: Form(
                key: _formKey, // Form key to handle validation
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
                    SizedBox(height: 2.h),
                    ToggleButtonGeneral(onChanged: adminCallback),
                    SizedBox(height: 2.h),
                    TextInput(
                      controller: _name,
                      label: 'Nama',
                      hintText: 'Nama',
                      type: TextInputType.name,
                      validator: TextfieldValidator.validateName,
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      controller: _phone,
                      label: 'No. Telepon',
                      hintText: 'No. Telepon',
                      type: TextInputType.number,
                      validator: TextfieldValidator.validatePhoneNumber,
                    ),
                    const SizedBox(height: 10),
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
                    SizedBox(height: 2.h),
                    ButtonGeneral(
                      label: const Text('Sign Up'),
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _name.text.isNotEmpty &&
                            _phone.text.isNotEmpty &&
                            _email.text.isNotEmpty &&
                            _password.text.isNotEmpty) {
                          context.read<AuthenticationBloc>().add(
                                (RegisterEvent(
                                  _email.text,
                                  _password.text,
                                  _name.text,
                                  _phone.text,
                                  admin,
                                )),
                              );
                          router.go('/login');
                        }
                      },
                    ),
                    TextButtonGeneral(
                      text: 'Sudah Punya Akun?',
                      onPressed: () => router.go('/login'),
                    ),
                  ],
                ),
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
