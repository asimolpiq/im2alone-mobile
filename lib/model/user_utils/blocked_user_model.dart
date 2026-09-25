class BlockedUserModel {
  String? id;
  String? username;
  String? pp;

  BlockedUserModel({
    this.id,
    this.username,
    this.pp,
  });

  BlockedUserModel copyWith({
    String? id,
    String? username,
    String? pp,
  }) {
    return BlockedUserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      pp: pp ?? this.pp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'pp': pp,
    };
  }

  factory BlockedUserModel.fromJson(Map<String, dynamic> json) {
    return BlockedUserModel(
      id: json['id']?.toString(),
      username: json['username'] as String?,
      pp: json['pp'] as String?,
    );
  }

  @override
  String toString() => "BlockedUserModel(id: $id,username: $username,pp: $pp)";

  @override
  int get hashCode => Object.hash(id, username, pp);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockedUserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          pp == other.pp;
}
