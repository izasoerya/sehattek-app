import 'package:sehattek_app/ddd/domain/entities/entities_service_runner.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_runner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfrastructureRunner implements RepoRunner {
  const InfrastructureRunner();

  @override
  Future<EntitiesServiceRunner> createRunner(
      EntitiesServiceRunner runner) async {
    // TODO: implement createRunner
    throw UnimplementedError();
  }

  @override
  Future<EntitiesServiceRunner> readRunner(String runnerId) async {
    // TODO: implement readRunner
    throw UnimplementedError();
  }

  @override
  Future<List<EntitiesServiceRunner>> readListRunner(String providerId) async {
    try {
      final res = await Supabase.instance.client
          .from('service_runner')
          .select()
          .eq('uid_provider', providerId);
      return res.map((e) => EntitiesServiceRunner.fromJSON(e)).toList();
    } on Exception catch (e) {
      print('error fetching runner: $e');
      return [];
    }
  }

  @override
  Future<EntitiesServiceRunner> updateRunner(
      EntitiesServiceRunner runner) async {
    // TODO: implement updateRunner
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRunner(EntitiesServiceRunner runner) async {
    // TODO: implement deleteRunner
    throw UnimplementedError();
  }
}
