import 'package:sehattek_app/ddd/domain/entities/entities_service_runner.dart';

abstract class RepoRunner {
  Future<EntitiesServiceRunner> createRunner(EntitiesServiceRunner runner);
  Future<EntitiesServiceRunner> readRunner(String runnerId);
  Future<List<EntitiesServiceRunner>> readListRunner(String providerId);
  Future<EntitiesServiceRunner> updateRunner(EntitiesServiceRunner runner);
  Future<void> deleteRunner(EntitiesServiceRunner runner);
}
