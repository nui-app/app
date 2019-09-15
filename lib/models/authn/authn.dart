class AuthN {
  final String uuid;
  final String email;
  final String token;

  AuthN({
    this.uuid,
    this.email,
    this.token,
  });

  Map<String, dynamic> toJSON() => {
    'uuid': this.uuid,
    'email': this.email,
    'token': this.token,
  };

  factory AuthN.fromJSON(Map<String, dynamic> json) => AuthN(
    uuid: json['uuid'] as String,
    email: json['email'] as String,
    token: json['token'] as String,
  );
}
