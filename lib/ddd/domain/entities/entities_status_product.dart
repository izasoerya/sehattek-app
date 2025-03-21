import 'package:sehattek_app/core/utils/enumeration.dart';

class EntitiesStatusProduct {
  final String uid;
  final StatusType statusType;
  final String detailInfo;
  final DateTime updatedAt;
  final DateTime createdAt;

  EntitiesStatusProduct({
    required this.uid,
    required this.statusType,
    required this.detailInfo,
    required this.updatedAt,
    required this.createdAt,
  });

  factory EntitiesStatusProduct.fromJSON(Map<String, dynamic> map) {
    return EntitiesStatusProduct(
      uid: map["uid"],
      statusType: map["status_type"],
      detailInfo: map["detail_info"],
      updatedAt: map["updated_at"],
      createdAt: map["created_at"],
    );
  }
}
