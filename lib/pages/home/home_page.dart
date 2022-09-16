import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/responsiveness.dart';
import 'package:noonpool_web/pages/home/widget/home_footer_1.dart';
import 'package:noonpool_web/pages/home/widget/home_page_header.dart';
import 'package:noonpool_web/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(
      height: kDefaultMargin,
    );

    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(child: AppDrawer()),
      body: Column(
        children: [
          ResponsiveWidget(
            largeScreen: const AppBarLarge(),
            smallScreen: AppBarSmall(
              scaffoldKey: scaffoldKey,
            ),
          ),
          const Divider(),
          const SizedBox(
            width: double.infinity,
            height: kDefaultMargin / 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: AnimatedContainer(
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.center,
                  width: ResponsiveWidget.isMediumScreen(context) ||
                          ResponsiveWidget.isSmallScreen(context)
                      ? MediaQuery.of(context).size.width
                      : largeScreenSize.toDouble(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ResponsiveWidget(
                        largeScreen: HomeHeaderLarge(),
                        smallScreen: HomeHeaderSmall(),
                      ),
                      spacer,
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
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
}
