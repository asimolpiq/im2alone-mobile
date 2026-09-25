import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../model/auth/user_model.dart';
import '../../product/enums/project_enums.dart';

mixin CachingManager {
  Future<Box> initBox() async {
    final box = await Hive.openBox('im2alone');
    return box;
  }

  //[LOGİN TOKEN]
  Future<void> saveToken(String? token) async {
    final box = await initBox();
    box.put(CacheManagerKey.token.name, token);
  }

  Future<String?> getToken() async {
    final box = await initBox();
    return await box.get(CacheManagerKey.token.name);
  }

  Future<void> removeToken() async {
    final box = await initBox();
    box.delete(CacheManagerKey.token.name);
  }

  //[LOCALIZATION LANGUAGE]
  Future<void> saveLocale(String? language) async {
    final box = await initBox();
    box.put(CacheManagerKey.language.name, language);
  }

  Future<String?> getLocale() async {
    final box = await initBox();
    return box.get(CacheManagerKey.language.name);
  }

  Future<void> removeLocale() async {
    final box = await initBox();
    box.delete(CacheManagerKey.language.name);
  }

  Future<void> saveUser(User user) async {
    final box = await initBox();
    box.put(CacheManagerKey.cachedUser.name, jsonEncode(user.toJson()));
  }

  Future<User?> getCachedUser() async {
    final box = await initBox();
    final raw = box.get(CacheManagerKey.cachedUser.name);
    if (raw == null) {
      return null;
    }
    return User.fromJson(Map<String, dynamic>.from(jsonDecode(raw)));
  }

  Future<void> removeCachedUser() async {
    final box = await initBox();
    box.delete(CacheManagerKey.cachedUser.name);
  }

  //[SEEN NOTIFICATIONS]
  Future<List<String>> getSeenNotificationIds() async {
    final box = await initBox();
    final raw = box.get(CacheManagerKey.seenNotificationIds.name);
    if (raw == null) {
      return [];
    }
    return List<String>.from(raw);
  }

  Future<void> markNotificationsSeen(List<String> ids) async {
    final box = await initBox();
    final current = await getSeenNotificationIds();
    final merged = {...current, ...ids}.toList();
    box.put(CacheManagerKey.seenNotificationIds.name, merged);
  }
}
