import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:either_dart/either.dart';
import 'package:sehattek_app/core/utils/error_class.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_product.dart';

class InfrastructureProduct implements RepoProduct {
  @override
  Future<Either<EntitiesServiceProduct, ErrorWrapper>> createProduct(
      EntitiesServiceProduct product) async {
    try {
      final res = await Supabase.instance.client
          .from('service_product')
          .insert(product.toJSON())
          .select()
          .single();
      return Left(EntitiesServiceProduct.fromJSON(res));
    } on Exception catch (e) {
      print('Error creating product: $e');
      return Right(ErrorWrapper.unknownError('Create Product Error: $e'));
    }
  }

  @override
  Future<Either<EntitiesServiceProduct, ErrorWrapper>> readProduct(
      String productId) async {
    try {
      final res = await Supabase.instance.client
          .from('service_product')
          .select()
          .eq('uid', productId)
          .single();
      return Left(EntitiesServiceProduct.fromJSON(res));
    } on Exception catch (e) {
      print('Error reading product: $e');
      return Right(ErrorWrapper.unknownError('Read Product Error: $e'));
    }
  }

  @override
  Future<Either<List<EntitiesServiceProduct>, ErrorWrapper>> readListProduct(
      String providerId) async {
    try {
      final response = await Supabase.instance.client
          .from('service_product')
          .select()
          .eq('uid_provider', providerId);
      return Left(
          response.map((e) => EntitiesServiceProduct.fromJSON(e)).toList());
    } on Exception catch (e) {
      print('Error reading list of products: $e');
      return Right(ErrorWrapper.unknownError('Read List Product Error: $e'));
    }
  }

  @override
  Future<Either<EntitiesServiceProduct, ErrorWrapper>> updateProduct(
      EntitiesServiceProduct product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(EntitiesServiceProduct product) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
}
