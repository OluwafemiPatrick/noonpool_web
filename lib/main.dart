import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/constants/strings.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();

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

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: lightTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const HomeTab(),
    );
  }
}
