class FeedsModel {
  String? id;
  String? content;
  String? date;
  String? link;
  String? friendName;
  String? userId;
  String? pp;

  FeedsModel({
    this.id,
    this.content,
    this.date,
    this.link,
    this.friendName,
    this.userId,
    this.pp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'date': date,
      'link': link,
      'friend_name': friendName,
      'user_id': userId,
      'pp': pp,
    };
  }

  factory FeedsModel.fromJson(Map<String, dynamic> json) {
    return FeedsModel(
      id: json['id'] as String?,
      content: json['content'] as String?,
      date: json['date'] as String?,
      link: json['link'] as String?,
      friendName: json['friend_name'] as String?,
      userId: json['user_id'] as String?,
      pp: json['pp'] as String?,
    );
  }

  @override
  String toString() =>
      "FeedsModel(id: $id,content: $content,date: $date,link: $link,friendName: $friendName,userId: $userId, pp: $pp)";

  @override
  int get hashCode => Object.hash(id, content, date, link, friendName, userId, pp);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedsModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          date == other.date &&
          link == other.link &&
          friendName == other.friendName &&
          userId == other.userId &&
          pp == other.pp;
}
