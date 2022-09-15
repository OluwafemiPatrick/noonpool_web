import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleController extends GetxController {
  Rx<Locale> locale =
      const Locale(AppPreferences.defaultLocaleLanguageCode).obs;

  updateCurrentLocale(Locale? locale) {
    if (locale != null && locale.languageCode.trim().isNotEmpty) {
      AppPreferences.setLocaleLanguageCode(
        localeLanguageCode: locale.languageCode,
      );
      this.locale.value = locale;
    } else {
      this.locale.value =
          const Locale(AppPreferences.defaultLocaleLanguageCode);
    }
  }
}

class AppLocale {
  final String rawName;
  final int index;
  final String translatedName;
  final Locale locale;

  AppLocale({
    required this.rawName,
    required this.index,
    required this.translatedName,
    required this.locale,
  });
}

List<AppLocale> appLocales(BuildContext context) => [
      AppLocale(
        rawName: "System Default",
        index: 0,
        translatedName: '(${AppLocalizations.of(context)!.systemDefault})',
        locale: const Locale(AppPreferences.defaultLocaleLanguageCode),
      ),
      AppLocale(
        rawName: "English",
        index: 1,
        translatedName: '(${AppLocalizations.of(context)!.english})',
        locale: const Locale('en'),
      ),
      AppLocale(
        rawName: "Persian",
        index: 2,
        translatedName: '(${AppLocalizations.of(context)!.persian})',
        locale: const Locale('fa'),
      ),
      AppLocale(
        rawName: "Chinease",
        index: 3,
        translatedName: '(${AppLocalizations.of(context)!.chinease})',
        locale: const Locale('zh'),
      ),
      AppLocale(
        rawName: "Arabic",
        index: 4,
        translatedName: '(${AppLocalizations.of(context)!.arabic})',
        locale: const Locale('ar'),
      ),
      AppLocale(
        rawName: "Russian",
        index: 5,
        translatedName: '(${AppLocalizations.of(context)!.russia})',
        locale: const Locale('ru'),
      ),
      AppLocale(
        rawName: "Turkish",
        index: 6,
        translatedName: '(${AppLocalizations.of(context)!.turkish})',
        locale: const Locale('tr'),
      ),
    ];
