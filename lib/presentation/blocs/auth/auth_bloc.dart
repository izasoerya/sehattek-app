import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_event.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final response = await Supabase.instance.client.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );

        if (response.session != null && response.user != null) {
          print('Login success');
          EntitiesProvider user = EntitiesProvider(
            uid: response.user!.id,
            name: response.user!.userMetadata?['username'] ?? 'Unknown User',
            phoneNumber: response.user!.phone ?? '',
            email: response.user!.email ?? '',
            password: response.session!.accessToken,
            createdAt: DateTime.parse(response.user!.createdAt),
          );
          emit(UserLoggedIn(user));
        }
      } catch (e) {
        print('Login error: $e');
        emit(AuthenticationFailure('An unexpected error occurred'));
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final response = await Supabase.instance.client.auth.signUp(
          email: event.email,
          password: event.password,
          data: {
            'username': event.name,
            'phone': event.phone,
          },
        );

        if (response.user != null && response.session == null) {
          print('Register success');
          EntitiesProvider user = EntitiesProvider(
            uid: response.user!.id,
            name: event.name,
            phoneNumber: event.phone,
            email: event.email,
            password: event.password,
            createdAt: DateTime.parse(response.user!.createdAt),
          );
          emit(UserLoggedIn(user));
        }
      } catch (e) {
        print('Register error: $e');
        emit(AuthenticationFailure('An unexpected error occurred'));
      }
    });
  }
}
