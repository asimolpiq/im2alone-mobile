class User {
  String? id;
  String? username;
  String? realname;
  String? password;
  String? email;
  String? gender;
  String? birthday;
  String? bio;
  String? pp;
  String? interested;
  String? permission;
  String? status;
  String? online;
  String? token;
  bool? isFriend;

  User({
    this.id,
    this.username,
    this.realname,
    this.password,
    this.email,
    this.gender,
    this.birthday,
    this.bio,
    this.pp,
    this.interested,
    this.permission,
    this.status,
    this.online,
    this.token,
    this.isFriend,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'realname': realname,
      'password': password,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'bio': bio,
      'pp': pp,
      'interested': interested,
      'permission': permission,
      'status': status,
      'online': online,
      'token': token,
      'isFriend': isFriend ?? false,
    };
  }

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) return User();
    return User(
      id: _asString(json['id']),
      username: _asString(json['username']),
      realname: _asString(json['realname']),
      password: _asString(json['password']),
      email: _asString(json['email']),
      gender: _asString(json['gender']),
      birthday: _asString(json['birthday']),
      bio: _asString(json['bio']),
      pp: _asString(json['pp']),
      interested: _asString(json['interested']),
      permission: _asString(json['permission']),
      status: _asString(json['status']),
      online: _asString(json['online']),
      token: _asString(json['token']),
      isFriend: _asBool(json['isFriend']),
    );
  }

  @override
  String toString() =>
      "LoginResponse(id: $id,username: $username,realname: $realname,password: $password,email: $email,gender: $gender,birthday: $birthday,bio: $bio,pp: $pp,interested: $interested,permission: $permission,status: $status,online: $online,token: $token, isFriend: $isFriend)";

  @override
  int get hashCode => Object.hash(id, username, realname, password, email, gender, birthday, bio, pp, interested,
      permission, status, online, token, isFriend);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          realname == other.realname &&
          password == other.password &&
          email == other.email &&
          gender == other.gender &&
          birthday == other.birthday &&
          bio == other.bio &&
          pp == other.pp &&
          interested == other.interested &&
          permission == other.permission &&
          status == other.status &&
          online == other.online &&
          token == other.token &&
          isFriend == other.isFriend;

  /// PHP tarafi sayi/string donusumunde tutarsiz olabiliyor; cast yerine coerce et.
  static String? _asString(dynamic value) => value?.toString();

  /// 0/1, "0"/"1", "true"/"false" ve bool degerlerini tolere eder.
  static bool? _asBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final text = value.toString().toLowerCase();
    if (text == 'true' || text == '1') return true;
    if (text == 'false' || text == '0') return false;
    return null;
  }

}
