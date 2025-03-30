import 'package:sehattek_app/core/utils/error_class.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';

abstract class RepoOrder {
  Future<ErrorWrapper> createOrder(EntitiesServiceProduct order);
  Future<ErrorWrapper> readOrder(String orderId);
  Future<List<ErrorWrapper>> readListOrder(String providerId);
  Future<ErrorWrapper> updateOrder(EntitiesServiceProduct order);
  Future<void> deleteOrder(EntitiesServiceProduct order);
}
