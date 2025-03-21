import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';

abstract class RepoAuth {
  Future<EntitiesProvider> createUser(EntitiesProvider provider);
  Future<EntitiesProvider> readUser(String uid);
  Future<List<EntitiesProvider>> readListUser(UserType userType);
  Future<EntitiesProvider> updateUser(EntitiesProvider entitiesProvider);
  Future<void> deleteUser(String uid);
}
