import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_event.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginEvent>((event, emit) {
      // Show loading state
      emit(AuthenticationLoading());

      // Simulate network request
      Future.delayed(Duration(seconds: 2), () {
        if (event.email == 'admin' && event.password == 'admin') {
          emit(AuthenticationSuccess('token'));
        } else {
          emit(AuthenticationFailure('Invalid email or password'));
        }
      });
    });
  }
}
