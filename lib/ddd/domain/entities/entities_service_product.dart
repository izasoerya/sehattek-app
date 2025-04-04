class EntitiesServiceProduct {
  final String uid;
  final String name;
  final String description;
  final String price;
  final String customerName;
  final DateTime orderDate;
  final DateTime updatedAt;
  final DateTime createdAt;

  EntitiesServiceProduct({
    required this.uid,
    required this.name,
    required this.description,
    required this.price,
    required this.customerName,
    required this.orderDate,
    required this.updatedAt,
    required this.createdAt,
  });

  factory EntitiesServiceProduct.fromJSON(Map<String, dynamic> map) {
    try {
      return EntitiesServiceProduct(
        uid: map['uid']?.toString() ?? 'Unknown UID',
        name: map['name'] ?? 'Unknown Name',
        description: map['description'] ?? 'No Description',
        price: map['price']?.toString() ?? '0',
        customerName: map['customer_name'] ?? 'Unknown Customer',
        orderDate: map['order_datetime'] != null
            ? DateTime.parse(map['order_datetime'])
            : DateTime.now(),
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : DateTime.now(),
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'])
            : DateTime.now(),
      );
    } catch (e) {
      print('Error parsing JSON: $map, Error: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'price': price,
      'customer_name': customerName,
      'order_datetime': orderDate.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
