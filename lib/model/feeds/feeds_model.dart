class FeedsModel {
  String? id;
  String? content;
  String? date;
  String? link;
  String? friendName;
  String? userId;
  String? pp;
  int? likes;
  int? views;
  bool? liked;

  FeedsModel({
    this.id,
    this.content,
    this.date,
    this.link,
    this.friendName,
    this.userId,
    this.pp,
    this.likes,
    this.views,
    this.liked,
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
      'likes': likes,
      'views': views,
      'liked': liked,
    };
  }

  factory FeedsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return FeedsModel();
    return FeedsModel(
      id: _asString(json['id']),
      content: _asString(json['content']),
      date: _asString(json['date']),
      link: _asString(json['link']),
      friendName: _asString(json['friend_name']),
      userId: _asString(json['user_id']),
      pp: _asString(json['pp']),
      likes: _asInt(json['likes']),
      views: _asInt(json['views']),
      liked: _asBool(json['liked']),
    );
  }

  @override
  String toString() =>
      "FeedsModel(id: $id,content: $content,date: $date,link: $link,friendName: $friendName,userId: $userId, pp: $pp, likes: $likes, views: $views, liked: $liked)";

  @override
  int get hashCode =>
      Object.hash(id, content, date, link, friendName, userId, pp, likes, views, liked);

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
          pp == other.pp &&
          likes == other.likes &&
          views == other.views &&
          liked == other.liked;

  /// PHP sayilari string olarak donebiliyor; cast yerine coerce et.
  static String? _asString(dynamic value) => value?.toString();

  static int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

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
