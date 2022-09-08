import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/constants/strings.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/controller/locale_controller.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noonpool_web/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  Get.put(LocaleController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: kPrimaryColor,
      ),
      canvasColor: kBackgroundColor,
      fontFamily: manrope,
      iconTheme: ThemeData.light().iconTheme.copyWith(color: kTextColor),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
                fontSize: 15, color: kTextColor, fontWeight: FontWeight.w500),
            bodyText2: const TextStyle(fontSize: 13, color: kTextColor),
          ),
    );

    return GetX<LocaleController>(builder: (controller) {
      final locale = controller.locale.value;
      return GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }
          // default language
          return const Locale('en');
        },
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: const HomeTab(),
      );
    });
  }
}
