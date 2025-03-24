import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String token;

  AuthenticationSuccess(this.token);
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure(this.message);
}

class UserLoggedIn extends AuthenticationState {
  final EntitiesProvider? user;

  UserLoggedIn(this.user);
}
