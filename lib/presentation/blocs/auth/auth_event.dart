import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';

abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  RegisterEvent(this.email, this.password, this.name, this.phone);
}

class UserLoggedInEvent extends AuthenticationEvent {
  final EntitiesProvider user;
  UserLoggedInEvent(this.user);
}

class UserLoggedOutEvent extends AuthenticationEvent {}
