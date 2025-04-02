class EntitiesAdmin {
  final String uid;
  final String name;
  final String email;
  final String? password;
  final DateTime? createdAt;

  EntitiesAdmin({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  factory EntitiesAdmin.fromJSON(Map<String, dynamic> map) {
    return EntitiesAdmin(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
