class EntitiesProvider {
  final String uid;
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final DateTime createdAt;

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
      phoneNumber: map['phone_number'],
      email: map['email'],
      password: map['password'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
