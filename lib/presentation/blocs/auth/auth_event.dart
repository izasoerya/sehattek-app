import 'package:sehattek_app/ddd/domain/entities/entities_admin.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';

abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final bool isAdmin;
  LoginEvent(this.email, this.password, this.isAdmin);
}

class RegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final bool isAdmin;

  RegisterEvent(this.email, this.password, this.name, this.phone, this.isAdmin);
}

class UserLoggedInEvent extends AuthenticationEvent {
  final EntitiesProvider? user;
  final EntitiesAdmin? admin;

  UserLoggedInEvent(this.user, this.admin);
}

class UserLoggedOutEvent extends AuthenticationEvent {}

class CheckSessionEvent extends AuthenticationEvent {}
