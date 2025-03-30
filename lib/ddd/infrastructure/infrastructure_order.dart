import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/core/utils/error_class.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfrastructureOrder implements RepoOrder {
  @override
  Future<ErrorWrapper> createOrder(EntitiesServiceProduct order) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<ErrorWrapper> readOrder(String orderId) async {
    try {
      final res = await Supabase.instance.client
          .from('service_product')
          .select()
          .eq('uid', orderId)
          .single();
      return ErrorWrapper(
          message: '', type: null, data: EntitiesServiceProduct.fromJSON(res));
    } on Exception catch (e) {
      print(e);
      return ErrorWrapper(message: '$e', type: ErrorType.unknown, data: null);
    }
  }

  @override
  Future<List<ErrorWrapper>> readListOrder(String providerId) async {
    try {
      final response = await Supabase.instance.client
          .from('service_product')
          .select()
          .eq('uid_provider', providerId);
      return response
          .map(
            (e) => ErrorWrapper(
              message: '',
              type: null,
              data: EntitiesServiceProduct.fromJSON(e),
            ),
          )
          .toList();
    } on Exception catch (e) {
      print('Exception occurred: $e');
      return [
        ErrorWrapper(
          message: '$e',
          type: ErrorType.unknown,
          data: null,
        )
      ];
    }
  }

  @override
  Future<ErrorWrapper> updateOrder(EntitiesServiceProduct order) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOrder(EntitiesServiceProduct order) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }
}
