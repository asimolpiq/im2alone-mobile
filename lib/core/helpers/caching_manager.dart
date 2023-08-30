import 'package:hive_flutter/hive_flutter.dart';

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
}
