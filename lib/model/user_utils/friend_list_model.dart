class FriendListModel {
  String? id;
  String? username;
  String? pp;
  String? bio;

  FriendListModel({
    this.id,
    this.username,
    this.pp,
    this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'pp': pp,
      'bio': bio,
    };
  }

  factory FriendListModel.fromJson(Map<String, dynamic> json) {
    return FriendListModel(
      id: json['id']?.toString(),
      username: json['username'] as String?,
      pp: json['pp'] as String?,
      bio: json['bio'] as String?,
    );
  }

  @override
  String toString() => "FriendListModel(id: $id,username: $username,pp: $pp,bio: $bio)";

  @override
  int get hashCode => Object.hash(id, username, pp, bio);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendListModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          pp == other.pp &&
          bio == other.bio;
}
