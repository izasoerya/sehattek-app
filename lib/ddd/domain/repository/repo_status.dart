import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';

abstract class RepoStatus {
  Future<EntitiesStatusProduct> createStatus(EntitiesStatusProduct status);
  Future<EntitiesStatusProduct> readStatus(String statusId);
  Future<List<EntitiesStatusProduct>> readListStatus(String providerId);
  Future<List<EntitiesStatusProduct>> readListStatusWithType(
      String providerId, String typeId);
  Future<EntitiesStatusProduct> updateStatus(EntitiesStatusProduct status);
  Future<void> deleteStatus(String statusId);
}
