import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_runner.dart';

abstract class RepoRunner {
  Future<EntitiesServiceRunner> createRunner(EntitiesServiceRunner runner);
  Future<EntitiesServiceRunner> readRunner(String runnerId);
  Future<List<EntitiesServiceRunner>> readListRunner(String providerId);
  Future<EntitiesServiceRunner> updateRunner(
      String productId, String providerId);
  Future<EntitiesServiceRunner> updateStatusProduct(
    StatusType statusType,
    String providerId,
  );
  Future<void> deleteRunner(EntitiesServiceRunner runner);
}
