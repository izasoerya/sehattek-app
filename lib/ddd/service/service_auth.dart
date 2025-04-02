import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_admin.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';
import 'package:sehattek_app/ddd/infrastructure/infrastructure_auth.dart';

class ServiceAuth {
  Future<EntitiesProvider> providerLogin(String email, String password) async {
    final res = await InfrastructureAuth().signIn(email, password);
    EntitiesProvider user = EntitiesProvider(
      uid: res.user!.id,
      name: res.user!.userMetadata?['username'] ?? 'Unknown User',
      phoneNumber: res.user!.phone ?? '',
      email: res.user!.email ?? '',
      password: res.session!.accessToken,
      createdAt: DateTime.parse(res.user!.createdAt),
    );
    return user;
  }

  Future<Map<EntitiesProvider?, EntitiesAdmin?>> signUp(
    String email,
    String password,
    String name,
    String phone,
    bool isAdmin,
  ) async {
    print('email: $email');
    final res = await InfrastructureAuth().signUp(
      email,
      password,
      name,
      phone,
      isAdmin,
    );
    final user = isAdmin
        ? EntitiesProvider(
            uid: res.user!.id,
            name: res.user!.userMetadata?['username'] ?? 'Unknown User',
            phoneNumber: res.user!.phone ?? '',
            email: res.user!.email ?? '',
            password: res.session!.accessToken,
            createdAt: DateTime.parse(res.user!.createdAt),
          )
        : null;
    final admin = isAdmin
        ? EntitiesAdmin(
            uid: res.user!.id,
            name: res.user!.userMetadata?['username'] ?? 'Unknown User',
            email: res.user!.email ?? '',
            password: res.session!.accessToken,
            createdAt: DateTime.parse(res.user!.createdAt),
          )
        : null;
    return {user: admin};
  }

  Future<List<EntitiesProvider>> fetchListProvider() async {
    final res = await InfrastructureAuth().readListUser(UserType.provider);
    return res;
  }
}
