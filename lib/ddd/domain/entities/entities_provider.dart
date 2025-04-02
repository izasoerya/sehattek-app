class EntitiesProvider {
  final String uid;
  final String name;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final DateTime? createdAt;

  EntitiesProvider({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  factory EntitiesProvider.fromJSON(Map<String, dynamic> map) {
    return EntitiesProvider(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phone_number'] ?? '',
      password: map['password'] ?? '',
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
