import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_auth.dart';

class InfrastructureAuth implements RepoAuth {
  @override
  Future<EntitiesProvider> createUser(EntitiesProvider provider) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<EntitiesProvider> readUser(String uid) {
    // TODO: implement readUser
    throw UnimplementedError();
  }

  @override
  Future<List<EntitiesProvider>> readListUser(UserType userType) {
    // TODO: implement readListUser
    throw UnimplementedError();
  }

  @override
  Future<EntitiesProvider> updateUser(EntitiesProvider entitiesProvider) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String uid) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
