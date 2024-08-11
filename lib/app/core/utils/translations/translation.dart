import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/utils/translations/translations_assets_reader.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': TranslationsAssetsReader.en!,
        'ar': TranslationsAssetsReader.ar!,
        'fr': TranslationsAssetsReader.fr!,
      };
}
