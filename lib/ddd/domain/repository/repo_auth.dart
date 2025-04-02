import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RepoAuth {
  Future<AuthResponse> signUp(
    String email,
    String password,
    String name,
    String phone,
    bool admin,
  );
  Future<AuthResponse> signIn(String email, String password);
  Future<AuthResponse> readSession();
  Future<AuthResponse> readUser(String uid);
  Future<List<EntitiesProvider>> readListUser(UserType userType);
  Future<AuthResponse> updateUser(AuthResponse entitiesProvider);
  Future<void> deleteUser(String uid);
}
