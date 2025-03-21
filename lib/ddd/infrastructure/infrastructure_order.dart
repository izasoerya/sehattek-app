import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_order.dart';

class InfrastructureOrder implements RepoOrder {
  @override
  Future<EntitiesServiceProduct> createOrder(EntitiesServiceProduct order) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<EntitiesServiceProduct> readOrder(String orderId) {
    // TODO: implement getOrderById
    throw UnimplementedError();
  }

  @override
  Future<List<EntitiesServiceProduct>> readListOrder(String providerId) {
    // TODO: implement getOrdersByProviderId
    throw UnimplementedError();
  }

  @override
  Future<EntitiesServiceProduct> updateOrder(EntitiesServiceProduct order) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOrder(EntitiesServiceProduct order) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }
}
