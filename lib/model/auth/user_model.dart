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
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      realname: json['realname'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      bio: json['bio'] as String?,
      pp: json['pp'] as String?,
      interested: json['interested'] as String?,
      permission: json['permission'] as String?,
      status: json['status'] as String?,
      online: json['online'] as String?,
      token: json['token'] as String?,
    );
  }

  @override
  String toString() =>
      "LoginResponse(id: $id,username: $username,realname: $realname,password: $password,email: $email,gender: $gender,birthday: $birthday,bio: $bio,pp: $pp,interested: $interested,permission: $permission,status: $status,online: $online,token: $token)";

  @override
  int get hashCode => Object.hash(id, username, realname, password, email, gender, birthday, bio, pp, interested,
      permission, status, online, token);

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
          token == other.token;
}
