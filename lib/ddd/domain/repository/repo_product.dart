import 'package:sehattek_app/core/utils/error_class.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';

abstract class RepoProduct {
  Future<ErrorWrapper> createProduct(EntitiesServiceProduct product);
  Future<ErrorWrapper> readProduct(String productId);
  Future<List<ErrorWrapper>> readListProduct(String providerId);
  Future<ErrorWrapper> updateProduct(EntitiesServiceProduct product);
  Future<void> deleteProduct(EntitiesServiceProduct product);
}
