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
      statusType: StatusType.fromString(map["type"]),
      detailInfo: map["detail_info"],
      updatedAt: DateTime.parse(map["updated_at"]),
      createdAt: DateTime.parse(map["created_at"]),
    );
  }
}
