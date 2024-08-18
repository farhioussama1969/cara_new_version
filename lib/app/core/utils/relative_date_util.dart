import 'dart:ui';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lit_relative_date_time/controller/relative_date_format.dart';
import 'package:lit_relative_date_time/model/relative_date_localization.dart';
import 'package:lit_relative_date_time/model/relative_date_time.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';

class RelativeDateUtil {
  static Rx<RelativeDateFormat> relativeDateFormatter = RelativeDateFormat(
      Get.locale?.languageCode == "ar"
          ? const Locale("ar")
          : const Locale("en"),
      localizations: [
        const RelativeDateLocalization(
          languageCode: 'en',
          timeUnitsSingular: [
            'second',
            'minute',
            'hour',
            'day',
            'week',
            'month',
            'year',
          ],
          timeUnitsPlural: [
            'seconds',
            'minutes',
            'hours',
            'days',
            'weeks',
            'months',
            'years',
          ],
          prepositionPast: 'ago',
          prepositionFuture: 'in',
          atTheMoment: 'now',
          formatOrderPast: [
            FormatComponent.value,
            FormatComponent.unit,
            FormatComponent.preposition
          ],
          formatOrderFuture: [
            FormatComponent.preposition,
            FormatComponent.value,
            FormatComponent.unit,
          ],
        ),
        const RelativeDateLocalization(
          languageCode: 'ar',
          timeUnitsSingular: [
            'ثواني',
            'دقائق',
            'ساعات',
            'أيام',
            'أسابيع',
            'أشهر',
            'سنوات',
          ],
          timeUnitsPlural: [
            'ثانية',
            'دقيقة',
            'ساعة',
            'يوم',
            'أسبوع',
            'شهر',
            'سنة',
          ],
          prepositionPast: 'منذ',
          prepositionFuture: 'بعد',
          atTheMoment: 'الآن',
          formatOrderPast: [
            FormatComponent.preposition,
            FormatComponent.value,
            FormatComponent.unit,
          ],
          formatOrderFuture: [
            FormatComponent.preposition,
            FormatComponent.value,
            FormatComponent.unit,
          ],
        )
      ]).obs;

  static void initializeRelativeDateFormat() {
    relativeDateFormatter.value = RelativeDateFormat(
        Get.locale?.languageCode == "ar"
            ? const Locale("ar")
            : const Locale("en"),
        localizations: [
          const RelativeDateLocalization(
            languageCode: 'en',
            timeUnitsSingular: [
              'second',
              'minute',
              'hour',
              'day',
              'week',
              'month',
              'year',
            ],
            timeUnitsPlural: [
              'seconds',
              'minutes',
              'hours',
              'days',
              'weeks',
              'months',
              'years',
            ],
            prepositionPast: 'ago',
            prepositionFuture: 'in',
            atTheMoment: 'now',
            formatOrderPast: [
              FormatComponent.value,
              FormatComponent.unit,
              FormatComponent.preposition
            ],
            formatOrderFuture: [
              FormatComponent.preposition,
              FormatComponent.value,
              FormatComponent.unit,
            ],
          ),
          const RelativeDateLocalization(
            languageCode: 'ar',
            timeUnitsSingular: [
              'ثواني',
              'دقائق',
              'ساعات',
              'أيام',
              'أسابيع',
              'أشهر',
              'سنوات',
            ],
            timeUnitsPlural: [
              'ثانية',
              'دقيقة',
              'ساعة',
              'يوم',
              'أسبوع',
              'شهر',
              'سنة',
            ],
            prepositionPast: 'منذ',
            prepositionFuture: 'بعد',
            atTheMoment: 'الآن',
            formatOrderPast: [
              FormatComponent.preposition,
              FormatComponent.value,
              FormatComponent.unit,
            ],
            formatOrderFuture: [
              FormatComponent.preposition,
              FormatComponent.value,
              FormatComponent.unit,
            ],
          )
        ]);
    relativeDateFormatter.refresh();
  }

  static String getRelativeDateSinceNow({required int relativeDateInUnix}) {
    return relativeDateFormatter().format(
      RelativeDateTime(
          dateTime: DateTime.now(),
          other: DateTime.fromMillisecondsSinceEpoch(relativeDateInUnix)),
    );
  }

  static String? numToDay(int? num) {
    if (num == 1) {
      return StringsAssetsConstants.monday;
    } else if (num == 2) {
      return StringsAssetsConstants.tuesday;
    } else if (num == 3) {
      return StringsAssetsConstants.wednesday;
    } else if (num == 4) {
      return StringsAssetsConstants.thursday;
    } else if (num == 5) {
      return StringsAssetsConstants.friday;
    } else if (num == 6) {
      return StringsAssetsConstants.saturday;
    } else if (num == 7) {
      return StringsAssetsConstants.sunday;
    }
    return null;
  }

  static String? numToMonth(int? num) {
    if (num == 1) {
      return StringsAssetsConstants.january;
    } else if (num == 2) {
      return StringsAssetsConstants.february;
    } else if (num == 3) {
      return StringsAssetsConstants.march;
    } else if (num == 4) {
      return StringsAssetsConstants.april;
    } else if (num == 5) {
      return StringsAssetsConstants.may;
    } else if (num == 6) {
      return StringsAssetsConstants.june;
    } else if (num == 7) {
      return StringsAssetsConstants.july;
    } else if (num == 8) {
      return StringsAssetsConstants.august;
    } else if (num == 9) {
      return StringsAssetsConstants.september;
    } else if (num == 10) {
      return StringsAssetsConstants.october;
    } else if (num == 11) {
      return StringsAssetsConstants.november;
    } else if (num == 12) {
      return StringsAssetsConstants.december;
    }
    return null;
  }

  static DateTime stringToDate(String? dateStr) {
    String dateString =
        '20${dateStr!.substring(6, 8)}-${dateStr.substring(3, 5)}-${dateStr.substring(0, 2)}';
    String dayDateStr = dateString;
    DateTime dayDate = DateTime.parse(dayDateStr);
    return dayDate;
  }

  static String changeHourFormat(String? timeStr) {
    var str = timeStr.toString().substring(0, 5);
    DateTime time = DateFormat('hh:mm').parse(str);
    var format12 = DateFormat.jm().format(time);
    return '${format12}';
  }

// static String? getDurationFromDaysNumber(int? days) {
//   if (days == 1) {
//     return StringsAssetsConstants.day;
//   } else if (days == 7) {
//     return StringsAssetsConstants.week;
//   } else if (days == 15) {
//     return StringsAssetsConstants.twoWeek;
//   } else if (days == 30) {
//     return StringsAssetsConstants.month;
//   } else if (days == 60) {
//     return StringsAssetsConstants.twoMonths;
//   } else if (days == 180) {
//     return '6 ${StringsAssetsConstants.months}';
//   } else if (days == 365) {
//     return StringsAssetsConstants.year;
//   }
// }
}
