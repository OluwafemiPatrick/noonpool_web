import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/responsiveness.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/pages/home/widget/home_footer_1.dart';
import 'package:noonpool_web/pages/home/widget/home_page_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;

    const spacer = SizedBox(
      height: kDefaultMargin,
    );

    return Scaffold(
      body: Column(
        children: [
          buildAppBar(bodyText1),
          const Divider(),
          const SizedBox(
            width: double.infinity,
            height: kDefaultMargin / 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.center,
                  width: ResponsiveWidget.isMediumScreen(context) ||
                          ResponsiveWidget.isSmallScreen(context)
                      ? MediaQuery.of(context).size.width
                      : largeScreenSize.toDouble(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeader(),
                      spacer,
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(kDefaultMargin / 2),
                        ),
                        padding: const EdgeInsets.all(kDefaultPadding / 2),
                        child: const IntrinsicHeight(
                          child: AutoRouter(),
                        ),
                      ),
                      spacer,
                      spacer,
                      HomeFooter1(),
                      spacer,
                      spacer,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(TextStyle? bodyText1) {
    return Row(
      children: [
        /*  Text(
          AppPreferences.userName,
          style: bodyText1!.copyWith(fontWeight: FontWeight.bold),
        ), */
        Image.asset(
          'assets/images/logo2.png',
          width: 60,
        ),
        _button2('Home', bodyText1, () {}, isSelected: true),
        _button2(
          'Calculator',
          bodyText1,
          () {},
        ),
        _button2('Wallet', bodyText1, () {}),
        _button(Icons.person_rounded, () {})
      ],
    );
  }

  Widget _button2(
    String text,
    TextStyle? bodyText2,
    VoidCallback onPressed, {
    bool isSelected = false,
  }) =>
      TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                text,
                style: bodyText2?.copyWith(
                  color: isSelected ? Colors.red : bodyText2.color,
                ),
              ),
            ],
          ));

  Widget _button(
    IconData iconData,
    VoidCallback onPressed, {
    bool isSelected = false,
  }) =>
      IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          size: 16,
          color: isSelected ? Colors.red : Colors.black,
        ),
      );
}
