import 'package:either_dart/either.dart';
import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/core/utils/error_class.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_runner.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';
import 'package:sehattek_app/ddd/infrastructure/infrastructure_product.dart';
import 'package:sehattek_app/ddd/infrastructure/infrastructure_runner.dart';
import 'package:sehattek_app/ddd/infrastructure/infrastructure_status.dart';

class ServiceOrder {
  Future<Either<EntitiesServiceProduct, ErrorWrapper>> createOrder(
      EntitiesServiceProduct order, String providerId) async {
    final productResult = await InfrastructureProduct().createProduct(order);

    if (productResult.isLeft) {
      // Product creation successful
      final createdProduct = productResult.left;

      // Create the runner
      await InfrastructureRunner().createRunner(
        EntitiesServiceRunner(
          uid: '',
          uidServiceProduct: createdProduct.uid,
          uidProvider: providerId,
          uidStatusProduct: StatusType.pending.uid,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Return the created product
      return Left(createdProduct);
    } else {
      // Product creation failed, return the error
      return Right(ErrorWrapper.unknownError('Error creating order'));
    }
  }

  Future<List<EntitiesServiceRunner>> readListRunner(String providerId) async {
    final res = await InfrastructureRunner().readListRunner(providerId);
    return res;
  }

  Future<Either<List<EntitiesServiceProduct>, ErrorWrapper>> readListProduct(
      String providerId) async {
    final res = await InfrastructureProduct().readListProduct(providerId);
    if (res.isLeft) {
      return Left(res.left);
    } else {
      return Right(ErrorWrapper.unknownError('Error reading list of products'));
    }
  }

  Future<Either<EntitiesServiceProduct, ErrorWrapper>> readOrder(
      String orderId) async {
    final res = await InfrastructureProduct().readProduct(orderId);
    if (res.isLeft) {
      return Left(res.left);
    } else {
      return Right(ErrorWrapper.unknownError('Error reading order'));
    }
  }

  Future<
      Either<List<Map<EntitiesServiceProduct, EntitiesStatusProduct>>,
          ErrorWrapper>> readListOrder(String providerId) async {
    final res = await InfrastructureRunner().readListRunner(providerId);
    final listRunner = res.map((e) => e).toList();

    final futures = listRunner.map((runner) async {
      try {
        final resProduct =
            await InfrastructureProduct().readProduct(runner.uidServiceProduct);
        final resStatus =
            await InfrastructureStatus().readStatus(runner.uidStatusProduct);

        if (resProduct.isLeft) {
          return {resProduct.left: resStatus};
        } else {
          return null;
        }
      } catch (error) {
        print('Error processing runner: $runner, Error: $error');
        return Right(
            ErrorWrapper.unknownError('Error processing runner: $runner'));
      }
    });

    final results = await Future.wait(futures);
    return Left(results
        .where((mapped) => mapped != null)
        .toList()
        .cast<Map<EntitiesServiceProduct, EntitiesStatusProduct>>());
  }

  Future<EntitiesServiceRunner> updateStatusOrder(
      StatusType statusType, String productId) async {
    final res =
        await InfrastructureRunner().updateStatusProduct(statusType, productId);
    return res;
  }

  Future<Either<EntitiesServiceRunner, ErrorWrapper>> updateRunnerProviderId(
      String providerId, String productId) async {
    final res =
        await InfrastructureRunner().updateRunner(productId, providerId);
    return Left(res);
  }
}
