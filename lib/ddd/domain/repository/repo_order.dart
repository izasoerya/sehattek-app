import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';

abstract class RepoOrder {
  Future<EntitiesServiceProduct> createOrder(EntitiesServiceProduct order);
  Future<EntitiesServiceProduct> readOrder(String orderId);
  Future<List<EntitiesServiceProduct>> readListOrder(String providerId);
  Future<EntitiesServiceProduct> updateOrder(EntitiesServiceProduct order);
  Future<void> deleteOrder(EntitiesServiceProduct order);
}
