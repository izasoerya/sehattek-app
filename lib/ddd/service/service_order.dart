import 'package:sehattek_app/core/utils/enumeration.dart';
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
    print('res0 = ${res[0].message} ${res[0].type}, ${res[0].data}');
    return res.map((e) => e.data).toList();
    if (res[0].type == ErrorType.unknown) {
      print('Success: ${res[0].message}');
    } else {
      print('Error: ${res[0].message}');
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
