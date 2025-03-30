import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';
import 'package:sehattek_app/ddd/infrastructure/infrastructure_product.dart';
import 'package:sehattek_app/ddd/infrastructure/infrastructure_runner.dart';
import 'package:sehattek_app/ddd/infrastructure/infrastructure_status.dart';

class ServiceOrder {
  Future<List<EntitiesServiceProduct>> readListProduct(
      String providerId) async {
    final res = await InfrastructureProduct().readListProduct(providerId);
    return res.where((e) => e.data != null).map((e) => e.data!).toList();
  }

  Future<List<Map<EntitiesServiceProduct, EntitiesStatusProduct>>>
      readListOrder(String providerId) async {
    final res = await InfrastructureRunner().readListRunner(providerId);
    final listRunner = res.map((e) => e).toList();
    print('listRunner length: ${listRunner.length}');

    // Use Future.wait to process all runners concurrently
    final futures = listRunner.map((runner) async {
      try {
        final resOrder =
            await InfrastructureProduct().readProduct(runner.uidServiceProduct);
        final resStatus =
            await InfrastructureStatus().readStatus(runner.uidStatusProduct);

        if (resOrder.data != null && resStatus != null) {
          return {resOrder.data!: resStatus};
        } else {
          print(
              'Skipping due to null data: resOrder=${resOrder.data}, resStatus=$resStatus');
          return null; // Skip invalid entries
        }
      } catch (error) {
        print('Error processing runner: $runner, Error: $error');
        return null; // Skip on error
      }
    });

    final results = await Future.wait(futures);
    return results
        .where((element) => element != null)
        .cast<Map<EntitiesServiceProduct, EntitiesStatusProduct>>()
        .toList();
  }
}
