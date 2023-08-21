///
/// Written & Developed by Oluwafemi Patrick
/// Copyright @ Jan 2022
/// oopatrickk@gmail.com
///

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/constants/strings.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/controller/app_bar_controller.dart';
import 'package:noonpool_web/controller/locale_controller.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  Get.put(LocaleController(), permanent: true);
  Get.put(AppBarController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: kPrimaryColor,),
      canvasColor: kBackgroundColor,
      fontFamily: manrope,
      iconTheme: ThemeData.light().iconTheme.copyWith(color: kTextColor),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(fontSize: 15, color: kTextColor, fontWeight: FontWeight.w500),
            bodyMedium: const TextStyle(fontSize: 13, color: kTextColor),
          ),
    );

    return GetMaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
