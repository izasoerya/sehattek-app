import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_runner.dart';
import 'package:sehattek_app/ddd/domain/repository/repo_runner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfrastructureRunner implements RepoRunner {
  const InfrastructureRunner();

  @override
  Future<EntitiesServiceRunner> createRunner(
      EntitiesServiceRunner runner) async {
    try {
      final res = await Supabase.instance.client
          .from('service_runner')
          .insert(runner.toJSON())
          .select()
          .single();
      return EntitiesServiceRunner.fromJSON(res);
    } on Exception catch (e) {
      print('Error creating runner: $e');
      return throw Exception('Error creating runner: $e');
    }
  }

  @override
  Future<EntitiesServiceRunner> readRunner(String runnerId) async {
    // TODO: implement readRunner
    throw UnimplementedError();
  }

  @override
  Future<List<EntitiesServiceRunner>> readListRunner(String providerId) async {
    PostgrestList res;
    try {
      res = await Supabase.instance.client
          .from('service_runner')
          .select()
          .eq('uid_provider', providerId);
      if (res.isEmpty) {
        res = await Supabase.instance.client.from('service_runner').select();
      }
      return res.map((e) => EntitiesServiceRunner.fromJSON(e)).toList();
    } on Exception catch (e) {
      print('error fetching runner: $e');
      return [];
    }
  }

  @override
  Future<EntitiesServiceRunner> updateRunner(
      String productId, String providerId) async {
    try {
      final res = await Supabase.instance.client
          .from('service_runner')
          .update({'uid_provider': providerId})
          .eq('uid_service_product', productId)
          .select()
          .single();
      return EntitiesServiceRunner.fromJSON(res);
    } catch (e) {
      print('error updating runner: $e');
      return throw Exception('Error updating runner: $e');
    }
  }

  @override
  Future<EntitiesServiceRunner> updateStatusProduct(
      StatusType statusType, String productId) async {
    try {
      final updatedData = await Supabase.instance.client
          .from('service_runner')
          .update({'uid_status_product': statusType.uid})
          .eq('uid_service_product', productId)
          .select()
          .single();
      return EntitiesServiceRunner.fromJSON(updatedData);
    } on Exception catch (e) {
      print('error updating runner: $e');
      return throw Exception('Error updating runner: $e');
    }
  }

  @override
  Future<void> deleteRunner(EntitiesServiceRunner runner) async {
    // TODO: implement deleteRunner
    throw UnimplementedError();
  }
}
