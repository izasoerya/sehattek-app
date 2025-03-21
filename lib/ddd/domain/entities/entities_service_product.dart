class EntitiesServiceProduct {
  final String uid;
  final String uidProvider;
  final String name;
  final String description;
  final String price;
  final DateTime orderDate;
  final DateTime updateAt;
  final DateTime createdAt;

  EntitiesServiceProduct({
    required this.uid,
    required this.uidProvider,
    required this.name,
    required this.description,
    required this.price,
    required this.orderDate,
    required this.updateAt,
    required this.createdAt,
  });

  factory EntitiesServiceProduct.fromJSON(Map<String, dynamic> map) {
    return EntitiesServiceProduct(
      uid: map['uid'],
      uidProvider: map['uid_provider'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      orderDate: DateTime.parse(map['order_date']),
      updateAt: DateTime.parse(map['update_at']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'uid_provider': uidProvider,
      'name': name,
      'description': description,
      'price': price,
      'order_date': orderDate.toIso8601String(),
      'update_at': updateAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
