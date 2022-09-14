import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'forgot_password_stage1.dart';
import 'forgot_password_stage2.dart';
import 'forgot_password_stage3.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = '';

  final pageController = PageController();

  int _pagePosition = 0;

  void onPageChanged(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );

    setState(() {
      _pagePosition = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    return WillPopScope(
      onWillPop: () async {
        if (_pagePosition != 0) {
          onPageChanged(_pagePosition - 1);
          return false;
        } else {
          return true;
        }
      },
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: null,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context)!.forgotPassword,
              style: bodyText1,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ForgotPasswordStage1(
                        navigateNext: (email) {
                          setState(() {
                            this.email = email;
                          });
                          onPageChanged(1);
                        },
                      ),
                      ForgotPasswordStage2(
                        email: email,
                        navigateNext: () {
                          onPageChanged(2);
                        },
                      ),
                      ForgotPasswordStage3(
                        email: email,
                        onDone: () {
                          context.router.replace(
                              const ForgotPasswordConfirmationScreen());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildBottomWidget(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomWidget() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
        child: buildIndicators(_pagePosition),
      ),
    );
  }

  Widget buildIndicators(int currentIndex) {
    List<int> indexes = [0, 1, 2];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indexes
          .map((index) => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: const EdgeInsets.only(right: 5),
                height: 8,
                width: (currentIndex == index) ? 50 : 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: (currentIndex == index)
                      ? kPrimaryColor
                      : Colors.black.withOpacity(0.2),
                ),
              ))
          .toList(),
    );
  }
}
