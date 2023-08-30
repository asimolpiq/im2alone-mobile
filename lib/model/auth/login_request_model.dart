class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() => "Response(username: $username,password: $password)";

  @override
  int get hashCode => Object.hash(username, password);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginRequestModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;
}
