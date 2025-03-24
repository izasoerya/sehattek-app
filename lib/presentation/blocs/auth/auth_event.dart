abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class LogoutEvent extends AuthenticationEvent {}

class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String phone;
  final String email;
  final String password;

  RegisterEvent(this.name, this.phone, this.email, this.password);
}
