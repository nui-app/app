class AuthN {
  final String uuid;
  final String token;

  AuthN({
    this.uuid,
    this.token,
  });

  factory AuthN.fromJSON(Map<String, dynamic> json) => AuthN(
    uuid: json['uuid'] as String,
    token: json['token'] as String,
  );
}
