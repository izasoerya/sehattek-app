import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/core/utils/error_class.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfrastructureProduct implements RepoProduct {
  @override
  Future<ErrorWrapper> createProduct(EntitiesServiceProduct product) async {
    try {
      print('Creating product: ${product.toJSON()}');
      final res = await Supabase.instance.client
          .from('service_product')
          .insert(product.toJSON())
          .select()
          .single();
      return ErrorWrapper(
          message: '', type: null, data: EntitiesServiceProduct.fromJSON(res));
    } on Exception catch (e) {
      print('Error creating product: $e');
      return ErrorWrapper(
          message: 'Error creating product: $e',
          type: ErrorType.unknown,
          data: null);
    }
  }

  @override
  Future<ErrorWrapper> readProduct(String productId) async {
    try {
      final res = await Supabase.instance.client
          .from('service_product')
          .select()
          .eq('uid', productId)
          .single();
      return ErrorWrapper(
          message: '', type: null, data: EntitiesServiceProduct.fromJSON(res));
    } on Exception catch (e) {
      print(e);
      return ErrorWrapper(message: '$e', type: ErrorType.unknown, data: null);
    }
  }

  @override
  Future<List<ErrorWrapper>> readListProduct(String providerId) async {
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
  Future<ErrorWrapper> updateProduct(EntitiesServiceProduct product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(EntitiesServiceProduct product) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
}
