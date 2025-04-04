import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfrastructureStatus implements RepoStatus {
  const InfrastructureStatus();

  @override
  Future<EntitiesStatusProduct> createStatus(
      EntitiesStatusProduct status) async {
    throw UnimplementedError();
  }

  @override
  Future<EntitiesStatusProduct> readStatus(String statusId) async {
    try {
      final res = await Supabase.instance.client
          .from('status_product')
          .select()
          .eq('uid', statusId)
          .single();
      return EntitiesStatusProduct.fromJSON(res);
    } catch (e) {
      print('Error fetching status: $e');
      return EntitiesStatusProduct(
        uid: statusId,
        statusType: StatusType.pending,
        detailInfo: 'Unknown',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  @override
  Future<List<EntitiesStatusProduct>> readListStatus(String providerId) async {
    try {
      final res = await Supabase.instance.client
          .from('status_product')
          .select()
          .eq('provider_id', providerId);
      return res.map((e) => EntitiesStatusProduct.fromJSON(e)).toList();
    } on Exception catch (e) {
      print('error fetching list status: $e');
      return [];
    }
  }

  @override
  Future<List<EntitiesStatusProduct>> readListStatusWithType(
      String providerId, String typeId) async {
    // TODO: implement readListStatusWithType
    throw UnimplementedError();
  }

  @override
  Future<EntitiesStatusProduct> updateStatus(
      EntitiesStatusProduct status) async {
    // TODO: implement updateStatus
    throw UnimplementedError();
  }

  @override
  Future<void> deleteStatus(String statusId) async {
    // TODO: implement deleteStatus
    throw UnimplementedError();
  }
}
