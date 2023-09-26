class NotificationModel {
  String? id;
  String? pp;
  String? username;
  String? friendId;
  String? bio;

  NotificationModel({
    this.id,
    this.pp,
    this.username,
    this.friendId,
    this.bio,
  });

  NotificationModel copyWith({
    String? id,
    String? pp,
    String? username,
    String? friendId,
    String? bio,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      pp: pp ?? this.pp,
      username: username ?? this.username,
      friendId: friendId ?? this.friendId,
      bio: bio ?? this.bio,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String?,
      pp: json['pp'] as String?,
      username: json['username'] as String?,
      friendId: json['friend_id'] as String?,
      bio: json['bio'] as String?,
    );
  }

  @override
  String toString() => "NotificationModel(id: $id,pp: $pp,username: $username,friendId: $friendId, bio: $bio)";

  @override
  int get hashCode => Object.hash(id, pp, username, friendId, bio);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          pp == other.pp &&
          username == other.username &&
          friendId == other.friendId &&
          bio == other.bio;
}
