class UserStatsModel {
  int? diaryCount;
  int? followerCount;
  int? followingCount;

  UserStatsModel({
    this.diaryCount,
    this.followerCount,
    this.followingCount,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      diaryCount: json['diary_count'] as int?,
      followerCount: json['follower_count'] as int?,
      followingCount: json['following_count'] as int?,
    );
  }

  @override
  String toString() =>
      "UserStats(diaryCount: $diaryCount,followerCount: $followerCount,followingCount: $followingCount)";

  @override
  int get hashCode => Object.hash(diaryCount, followerCount, followingCount);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatsModel &&
          runtimeType == other.runtimeType &&
          diaryCount == other.diaryCount &&
          followerCount == other.followerCount &&
          followingCount == other.followingCount;
}
