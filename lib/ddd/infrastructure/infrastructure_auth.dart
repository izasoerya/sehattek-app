import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfrastructureAuth implements RepoAuth {
  InfrastructureAuth();

  @override
  Future<AuthResponse> signUp(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    AuthResponse response = AuthResponse(user: null, session: null);
    try {
      response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'username': name, 'phone': phone},
      );
      await Supabase.instance.client.from('provider_profile').insert({
        'uid': response.user!.id,
        'name': response.user!.userMetadata?['username'] ?? 'Unknown User',
      });
      if (response.user == null || response.session == null) {
        return throw Exception('User or session is null');
      }
    } catch (e) {
      print('Register error: $e');
      return throw Exception('An unexpected error occurred');
    }
    return response;
  }

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    AuthResponse response;
    try {
      response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null || response.session == null) {
        return throw Exception('User or session is null');
      }
    } catch (e) {
      print('Login error: $e');
      return throw Exception('An unexpected error occurred');
    }
    return response;
  }

  @override
  Future<AuthResponse> readSession() async {
    AuthResponse response = AuthResponse(user: null, session: null);
    try {
      if (response.user == null || response.session == null) {
        return throw Exception('User or session is null');
      }
    } catch (e) {
      print('Session error: $e');
      return throw Exception('An unexpected error occurred');
    }
    return response;
  }

  @override
  Future<AuthResponse> readUser(String uid) {
    // TODO: implement readUser

    throw UnimplementedError();
  }

  @override
  Future<List<AuthResponse>> readListUser(UserType userType) async {
    try {
      final res = await Supabase.instance.client.auth.admin.listUsers();
      print(res);
      return res
          .map((e) => AuthResponse(
                user: e,
                session: null,
              ))
          .toList();
    } catch (e) {
      print('List user error: $e');
      return throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<AuthResponse> updateUser(AuthResponse provider) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String uid) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
