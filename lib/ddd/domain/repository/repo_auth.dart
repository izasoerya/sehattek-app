import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RepoAuth {
  Future<AuthResponse> signUp(
    String email,
    String password,
    String name,
    String phone,
  );
  Future<AuthResponse> signIn(String email, String password);
  Future<AuthResponse> readSession();
  Future<AuthResponse> readUser(String uid);
  Future<List<AuthResponse>> readListUser(UserType userType);
  Future<AuthResponse> updateUser(AuthResponse entitiesProvider);
  Future<void> deleteUser(String uid);
}
