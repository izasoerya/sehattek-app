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

  Future<EntitiesProvider> providerSignUp(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    final res = await InfrastructureAuth().signUp(
      email,
      password,
      name,
      phone,
    );
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
}
