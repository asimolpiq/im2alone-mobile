import 'package:get/get.dart';
import 'package:im2alone/product/localization/turkish.dart';

import 'english.dart';

class ProductTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': englishTranslate,
        'tr_TR': turkishTranslate,
      };
}
