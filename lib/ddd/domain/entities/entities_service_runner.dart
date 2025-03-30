class EntitiesServiceRunner {
  final String uid;
  final String uidProvider;
  final String uidStatusProduct;
  final String uidServiceProduct;
  final DateTime updatedAt;
  final DateTime createdAt;

  EntitiesServiceRunner({
    required this.uid,
    required this.uidProvider,
    required this.uidStatusProduct,
    required this.uidServiceProduct,
    required this.updatedAt,
    required this.createdAt,
  });

  factory EntitiesServiceRunner.fromJSON(Map<String, dynamic> map) {
    return EntitiesServiceRunner(
      uid: map["uid"],
      uidProvider: map["uid_provider"],
      uidStatusProduct: map["uid_status_product"],
      uidServiceProduct: map["uid_service_product"],
      updatedAt: DateTime.parse(map["updated_at"]),
      createdAt: DateTime.parse(map["created_at"]),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'uid_provider': uidProvider,
      'uid_status_product': uidStatusProduct,
      'uid_service_product': uidServiceProduct,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
