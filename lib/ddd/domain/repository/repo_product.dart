import 'package:either_dart/either.dart';
import 'package:sehattek_app/core/utils/error_class.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';

abstract class RepoProduct {
  Future<Either<EntitiesServiceProduct, ErrorWrapper>> createProduct(
      EntitiesServiceProduct product);

  Future<Either<EntitiesServiceProduct, ErrorWrapper>> readProduct(
      String productId);

  Future<Either<List<EntitiesServiceProduct>, ErrorWrapper>> readListProduct(
      String providerId);

  Future<Either<EntitiesServiceProduct, ErrorWrapper>> updateProduct(
      EntitiesServiceProduct product);

  Future<void> deleteProduct(EntitiesServiceProduct product);
}
