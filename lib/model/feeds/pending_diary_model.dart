class PendingDiaryModel {
  String? localId;
  String? content;
  String? link;
  String? privacy;
  String? createdAt;

  PendingDiaryModel({
    this.localId,
    this.content,
    this.link,
    this.privacy,
    this.createdAt,
  });

  PendingDiaryModel copyWith({
    String? localId,
    String? content,
    String? link,
    String? privacy,
    String? createdAt,
  }) {
    return PendingDiaryModel(
      localId: localId ?? this.localId,
      content: content ?? this.content,
      link: link ?? this.link,
      privacy: privacy ?? this.privacy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localId': localId,
      'content': content,
      'link': link,
      'privacy': privacy,
      'createdAt': createdAt,
    };
  }

  factory PendingDiaryModel.fromJson(Map<String, dynamic> json) {
    return PendingDiaryModel(
      localId: json['localId'] as String?,
      content: json['content'] as String?,
      link: json['link'] as String?,
      privacy: json['privacy'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() =>
      "PendingDiaryModel(localId: $localId,content: $content,link: $link,privacy: $privacy,createdAt: $createdAt)";

  @override
  int get hashCode => Object.hash(localId, content, link, privacy, createdAt);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingDiaryModel &&
          runtimeType == other.runtimeType &&
          localId == other.localId &&
          content == other.content &&
          link == other.link &&
          privacy == other.privacy &&
          createdAt == other.createdAt;
}
