class User {
  final String uuid;
  final String email;

  User({
    this.uuid,
    this.email,
  });

  Map<String, dynamic> toJSON() => {
    'uuid': this.uuid,
    'email': this.email,
  };

  factory User.fromJSON(Map<String, dynamic> json) => User(
    uuid: json['uuid'] as String,
    email: json['email'] as String,
  );
}
