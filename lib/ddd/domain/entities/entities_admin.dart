class EntitiesAdmin {
  final String uid;
  final String email;
  final String password;
  final DateTime createdAt;

  EntitiesAdmin({
    required this.uid,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  factory EntitiesAdmin.fromJSON(Map<String, dynamic> map) {
    return EntitiesAdmin(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
