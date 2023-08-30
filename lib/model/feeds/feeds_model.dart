class FeedsModel {
  String? id;
  String? content;
  String? date;
  String? link;

  FeedsModel({
    this.id,
    this.content,
    this.date,
    this.link,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'date': date,
      'link': link,
    };
  }

  factory FeedsModel.fromJson(Map<String, dynamic> json) {
    return FeedsModel(
      id: json['id'] as String?,
      content: json['content'] as String?,
      date: json['date'] as String?,
      link: json['link'] as String?,
    );
  }

  @override
  String toString() => "FeedsModel(id: $id,content: $content,date: $date,link: $link)";

  @override
  int get hashCode => Object.hash(id, content, date, link);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedsModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          date == other.date &&
          link == other.link;
}
