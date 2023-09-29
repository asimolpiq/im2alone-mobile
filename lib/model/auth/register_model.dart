class RegisterModel {
  String? username;
  String? realname;
  String? email;
  String? gender;
  String? password;
  String? birthday;

  RegisterModel({
    this.username,
    this.realname,
    this.email,
    this.gender,
    this.password,
    this.birthday,
  });

  RegisterModel copyWith({
    String? username,
    String? realname,
    String? email,
    String? gender,
    String? password,
    String? birthday,
  }) {
    return RegisterModel(
      username: username ?? this.username,
      realname: realname ?? this.realname,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      birthday: birthday ?? this.birthday,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'realname': realname,
      'email': email,
      'gender': gender,
      'password': password,
      'birthday': birthday,
    };
  }

  @override
  String toString() =>
      "RegisterModel(username: $username,realname: $realname,email: $email,gender: $gender,password: $password,birthday: $birthday)";

  @override
  int get hashCode => Object.hash(username, realname, email, gender, password, birthday);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          realname == other.realname &&
          email == other.email &&
          gender == other.gender &&
          password == other.password &&
          birthday == other.birthday;
}
