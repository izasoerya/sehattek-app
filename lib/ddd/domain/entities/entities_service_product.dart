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
    try {
      return EntitiesServiceProduct(
        uid: map['uid']?.toString() ?? 'Unknown UID',
        uidProvider: map['uid_provider']?.toString() ?? 'Unknown Provider',
        name: map['name'] ?? 'Unknown Name',
        description: map['description'] ?? 'No Description',
        price: map['price']?.toString() ?? '0',
        orderDate: map['order_datetime'] != null
            ? DateTime.parse(map['order_datetime'])
            : DateTime.now(), // Default to current date if null
        updateAt: map['update_at'] != null
            ? DateTime.parse(map['update_at'])
            : DateTime.now(), // Default to current date if null
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : DateTime.now(), // Default to current date if null
      );
    } catch (e) {
      print('Error parsing JSON: $map, Error: $e');
      rethrow; // Re-throw the error to handle it in the calling code
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'uid_provider': uidProvider,
      'name': name,
      'description': description,
      'price': price,
      'order_datetime': orderDate.toIso8601String(),
      'update_at': updateAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
