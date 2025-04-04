import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_admin.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';
import 'package:sehattek_app/ddd/service/service_auth.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_event.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  AuthenticationBloc() : super(AuthenticationInitial()) {
    final currentSession = _supabaseClient.auth.currentSession;
    if (currentSession != null) {
      final bool isAdmin =
          currentSession.user.userMetadata?['isAdmin'] ?? false;
      if (!isAdmin) {
        final provider = EntitiesProvider(
          uid: currentSession.user.id,
          name: currentSession.user.userMetadata?['username'] ?? 'Unknown User',
          phoneNumber: currentSession.user.phone ?? '',
          email: currentSession.user.email ?? '',
          password: currentSession.accessToken,
          createdAt: DateTime.parse(currentSession.user.createdAt),
        );
        emit(UserLoggedIn(provider, null));
      } else {
        final admin = EntitiesAdmin(
          uid: currentSession.user.id,
          name: currentSession.user.userMetadata?['username'] ?? 'Unknown User',
          email: currentSession.user.email ?? '',
          password: currentSession.accessToken,
          createdAt: DateTime.parse(currentSession.user.createdAt),
        );
        emit(UserLoggedIn(null, admin));
      }
    } else {
      emit(AuthenticationUnauthenticated());
    }

    _supabaseClient.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;
      if (event == AuthChangeEvent.signedIn && session != null) {
        final bool isAdmin = session.user.userMetadata?['isAdmin'] ?? false;

        if (!isAdmin) {
          final provider = EntitiesProvider(
            uid: session.user.id,
            name: session.user.userMetadata?['username'] ?? 'Unknown User',
            phoneNumber: session.user.phone ?? '',
            email: session.user.email ?? '',
            password: session.accessToken,
            createdAt: DateTime.parse(session.user.createdAt),
          );
          add(UserLoggedInEvent(provider, null));
        } else {
          final admin = EntitiesAdmin(
            uid: session.user.id,
            name: session.user.userMetadata?['username'] ?? 'Unknown User',
            email: session.user.email ?? '',
            password: session.accessToken,
            createdAt: DateTime.parse(session.user.createdAt),
          );
          add(UserLoggedInEvent(null, admin));
        }
      } else if (event == AuthChangeEvent.signedOut) {
        add(UserLoggedOutEvent());
      }
    });

    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<UserLoggedInEvent>(
      (event, emit) => emit(UserLoggedIn(event.user, event.admin)),
    );
    on<UserLoggedOutEvent>(
      (event, emit) => emit(AuthenticationUnauthenticated()),
    );
  }

  Future<void> _onLogin(
      LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );

      if (response.session == null || response.user == null) {
        emit(AuthenticationFailure('Invalid credentials'));
        return;
      }
      if (event.isAdmin) {
        // If the user is an admin, emit UserLoggedIn with admin
        final user = EntitiesAdmin(
          uid: response.user!.id,
          name: response.user!.userMetadata!['username'] ?? 'Unknown User',
          email: response.user!.email ?? '',
          password: response.session!.accessToken,
          createdAt: DateTime.parse(response.user!.createdAt),
        );
        emit(UserLoggedIn(null, user));
      } else {
        // If the user is a provider, emit UserLoggedIn with provider
        final user = EntitiesProvider(
          uid: response.user!.id,
          name: response.user!.userMetadata?['username'] ?? 'Unknown User',
          phoneNumber: response.user!.phone ?? '',
          email: response.user!.email ?? '',
          password: response.session!.accessToken,
          createdAt: DateTime.parse(response.user!.createdAt),
        );
        emit(UserLoggedIn(user, null));
      }
    } catch (e) {
      print('Login error: $e');
      emit(AuthenticationFailure('An unexpected error occurred'));
    }
  }

  Future<void> _onRegister(
      RegisterEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final res = await ServiceAuth().signUp(
        event.email,
        event.password,
        event.name,
        event.phone,
        event.isAdmin,
      );
      emit(UserLoggedIn(res.keys.first, res.values.first));
    } catch (e) {
      print('Service error: $e');
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
