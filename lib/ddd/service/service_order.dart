import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/infrastructure/infrastructure_order.dart';

class ServiceOrder {
  ServiceOrder();

  void createOrder() {
    // Create order
  }

  void readOrder() {
    // Read order
  }

  Future<List<EntitiesServiceProduct?>> readListOrder(String providerId) async {
    final res = await InfrastructureOrder().readListOrder(providerId);
    if (res[0].type == null) {
      return res.map((e) => e.data).toList();
    } else {
      return [];
    }
  }

  void updateOrder() {
    // Update order
  }

  void deleteOrder() {
    // Delete order
  }
}
