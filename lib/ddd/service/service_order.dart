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
    final res = await InfrastructureProduct().createProduct(order).then(
      (value) async {
        if (value.isLeft) {
          await InfrastructureRunner().createRunner(
            EntitiesServiceRunner(
              uid: '03b24cf4-f010-45e2-ac35-61216e8fd599',
              uidServiceProduct: value.left.uid,
              uidProvider: providerId,
              uidStatusProduct: StatusType.pending.uid,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
        } else {
          return Right(ErrorWrapper.unknownError('Error creating order'));
        }
      },
    );
    return res!.left;
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
}
