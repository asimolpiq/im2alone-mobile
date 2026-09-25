import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/feeds/feeds_model.dart';
import '../../model/feeds/pending_diary_model.dart';
import '../../product/enums/project_enums.dart';
import '../../service/feeds/feeds_service.dart';
import 'request_helper.dart';

mixin DiarySyncManager {
  final FeedsService _feedsService = FeedsService(RequestHelper().dio);

  Future<Box> _diaryBox() async {
    return await Hive.openBox('im2alone');
  }

  Future<bool> isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  Future<List<PendingDiaryModel>> getPendingDiaries() async {
    final box = await _diaryBox();
    final raw = box.get(CacheManagerKey.pendingDiaries.name);
    if (raw == null) {
      return [];
    }
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => PendingDiaryModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> addPendingDiary(
      {required String content,
      required String link,
      required String privacy}) async {
    final pending = await getPendingDiaries();
    pending.add(PendingDiaryModel(
      localId: DateTime.now().microsecondsSinceEpoch.toString(),
      content: content,
      link: link,
      privacy: privacy,
      createdAt: DateTime.now().toIso8601String(),
    ));
    await _savePendingDiaries(pending);
  }

  Future<void> removePendingDiary(String localId) async {
    final pending = await getPendingDiaries();
    pending.removeWhere((element) => element.localId == localId);
    await _savePendingDiaries(pending);
  }

  Future<void> _savePendingDiaries(List<PendingDiaryModel> pending) async {
    final box = await _diaryBox();
    await box.put(CacheManagerKey.pendingDiaries.name,
        jsonEncode(pending.map((e) => e.toJson()).toList()));
  }

  Future<int> flushPendingDiaries() async {
    if (!await isOnline()) {
      return 0;
    }
    final pending = await getPendingDiaries();
    int sentCount = 0;
    for (final diary in pending) {
      final success = await _feedsService.writeDiary(
        content: diary.content ?? "",
        link: diary.link ?? "",
        privacy: diary.privacy ?? "0",
      );
      if (!success) {
        break;
      }
      await removePendingDiary(diary.localId ?? "");
      sentCount++;
    }
    return sentCount;
  }

  Future<void> cacheMyDiary(List<FeedsModel> feeds) =>
      _saveCache(CacheManagerKey.myDiaryCache, feeds);

  Future<void> cacheAllFeeds(List<FeedsModel> feeds) =>
      _saveCache(CacheManagerKey.allFeedsCache, feeds);

  Future<List<FeedsModel>> getCachedMyDiary() =>
      _readCache(CacheManagerKey.myDiaryCache);

  Future<List<FeedsModel>> getCachedAllFeeds() =>
      _readCache(CacheManagerKey.allFeedsCache);

  Future<void> cacheAllDiariesForOfflineUse() async {
    final myDiary = await _feedsService.getMyDiary();
    if (myDiary.error == null) {
      await cacheMyDiary(myDiary.feeds ?? []);
    }
    final allFeeds = await _feedsService.getAllDiary();
    if (allFeeds.error == null) {
      await cacheAllFeeds(allFeeds.feeds ?? []);
    }
  }

  Future<void> _saveCache(CacheManagerKey key, List<FeedsModel> feeds) async {
    final box = await _diaryBox();
    await box.put(key.name, jsonEncode(feeds.map((e) => e.toJson()).toList()));
  }

  Future<void> clearDiaryCaches() async {
    final box = await _diaryBox();
    await box.delete(CacheManagerKey.myDiaryCache.name);
    await box.delete(CacheManagerKey.allFeedsCache.name);
  }

  Future<List<FeedsModel>> _readCache(CacheManagerKey key) async {
    final box = await _diaryBox();
    final raw = box.get(key.name);
    if (raw == null) {
      return [];
    }
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => FeedsModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
