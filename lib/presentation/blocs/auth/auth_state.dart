import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class UserLoggedIn extends AuthenticationState {
  final EntitiesProvider user;
  UserLoggedIn(this.user);
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String error;
  AuthenticationFailure(this.error);
}
