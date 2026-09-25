class RegisterModel {
  String? username;
  String? realname;
  String? email;
  String? gender;
  String? password;
  String? birthday;
  bool? eulaAccepted;

  RegisterModel({
    this.username,
    this.realname,
    this.email,
    this.gender,
    this.password,
    this.birthday,
    this.eulaAccepted,
  });

  RegisterModel copyWith({
    String? username,
    String? realname,
    String? email,
    String? gender,
    String? password,
    String? birthday,
    bool? eulaAccepted,
  }) {
    return RegisterModel(
      username: username ?? this.username,
      realname: realname ?? this.realname,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      birthday: birthday ?? this.birthday,
      eulaAccepted: eulaAccepted ?? this.eulaAccepted,
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
      'eulaAccepted': eulaAccepted,
    };
  }

  @override
  String toString() =>
      "RegisterModel(username: $username,realname: $realname,email: $email,gender: $gender,password: $password,birthday: $birthday,eulaAccepted: $eulaAccepted)";

  @override
  int get hashCode => Object.hash(username, realname, email, gender, password, birthday, eulaAccepted);

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
          birthday == other.birthday &&
          eulaAccepted == other.eulaAccepted;
}
