// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/constants/strings.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/controller/app_bar_controller.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/drop_down_button.dart';
import 'package:noonpool_web/widgets/outlined_button.dart';
import 'package:noonpool_web/widgets/svg_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarLarge extends StatefulWidget {
  const AppBarLarge({Key? key}) : super(key: key);

  @override
  State<AppBarLarge> createState() => _AppBarLargeState();
}

class _AppBarLargeState extends State<AppBarLarge> with AppBarHelper {
  @override
  void updateScreen() {
    super.updateScreen();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.router.root.addListener(listener);
    });
  }

  listener() => updateListener(context);

  @override
  void dispose() {
    context.router.root.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText2!;
    return GetX<AppBarController>(builder: (controller) {
      return Row(
        children: [
          const SizedBox(width: kDefaultMargin / 2),
          Image.asset(
            'assets/images/logo2.png',
            width: 80,
          ),
          const SizedBox(width: kDefaultMargin / 2),
          if (!controller.isRefreshing)
            _appBarButton('Home', bodyText1, () => onNavigateHome(context),
                isSelected: controller.isItemSelected(0),
                icon: 'assets/icons/home.svg'),
          //
          if (!controller.isRefreshing)
            _appBarButton('Pool', bodyText1, () => onNavigatePool(context),
                isSelected: controller.isItemSelected(1),
                icon: 'assets/icons/pool.svg'),
          //
          if (!controller.isRefreshing)
            _appBarButton(
                'Calculator', bodyText1, () => onNavigateCalculator(context),
                isSelected: controller.isItemSelected(2),
                icon: 'assets/icons/calculator.svg'),

          if (!controller.isRefreshing)
            _appBarButton('Wallet', bodyText1, () => onNavigateWallet(context),
                isSelected: controller.isItemSelected(3),
                icon: 'assets/icons/wallet.svg'),
          const Spacer(),
          _appBarButton(
            'APP',
            bodyText1,
            onAppPressed,
          ),
          if (!controller.isUserLoggedIn && !controller.isRefreshing)
            _appBarButton(
              'Sign In',
              bodyText1,
              () => onSIgnInPressed(context),
            ),
          if (!controller.isUserLoggedIn && !controller.isRefreshing)
            _appBarButton(
              'Sign Up',
              bodyText1,
              () => onSIgnUpPressed(context),
            ),
          const SizedBox(width: kDefaultMargin / 2),
          if (controller.isUserLoggedIn && !controller.isRefreshing)
            profileButton(bodyText1, context),
          const SizedBox(width: kDefaultMargin / 2),
          settingsButton(bodyText1, context),
          const SizedBox(width: kDefaultMargin / 2),
        ],
      );
    });
  }

  Widget _appBarButton(
    String text,
    TextStyle? bodyText2,
    VoidCallback onPressed, {
    bool isSelected = false,
    String? icon,
  }) =>
      TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            if (icon != null)
              SvgImage(
                iconLocation: icon,
                name: text,
                color: isSelected ? Colors.red : bodyText2!.color!,
                size: 14,
              ),
            if (icon != null)
              const SizedBox(
                width: 3,
              ),
            Text(
              text,
              style: bodyText2?.copyWith(
                color: isSelected ? Colors.red : bodyText2.color,
              ),
            ),
          ],
        ),
      );
}

class AppBarSmall extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const AppBarSmall({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<AppBarSmall> createState() => _AppBarSmallState();
}

class _AppBarSmallState extends State<AppBarSmall> with AppBarHelper {
  @override
  void updateScreen() {
    super.updateScreen();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.router.root.addListener(listener);
    });
  }

  listener() => updateListener(context);

  @override
  void dispose() {
    context.router.root.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText2!;
    return GetX<AppBarController>(builder: (controller) {
      return Row(
        children: [
          if (!controller.isRefreshing)
            const SizedBox(width: kDefaultMargin / 2),
          if (!controller.isRefreshing)
            IconButton(
              onPressed: () {
                widget.scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu_rounded),
            ),
          const SizedBox(width: kDefaultMargin / 2),
          Image.asset(
            'assets/images/logo2.png',
            width: 80,
          ),
          const Spacer(),
          if (!controller.isUserLoggedIn && !controller.isRefreshing)
            _appBarButton(
              'Sign In',
              bodyText1,
              () => onSIgnInPressed(context),
            ),
          if (!controller.isUserLoggedIn && !controller.isRefreshing)
            _appBarButton(
              'Sign Up',
              bodyText1,
              () => onSIgnUpPressed(context),
            ),
          const SizedBox(width: kDefaultMargin / 2),
          if (controller.isUserLoggedIn && !controller.isRefreshing)
            profileButton(bodyText1, context),
          const SizedBox(width: kDefaultMargin / 2),
          settingsButton(bodyText1, context),
          const SizedBox(width: kDefaultMargin / 2),
        ],
      );
    });
  }

  Widget _appBarButton(
    String text,
    TextStyle? bodyText2,
    VoidCallback onPressed, {
    bool isSelected = false,
    String? icon,
  }) =>
      TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            if (icon != null)
              SvgImage(
                iconLocation: icon,
                name: text,
                color: isSelected ? Colors.red : bodyText2!.color!,
                size: 14,
              ),
            if (icon != null)
              const SizedBox(
                width: 3,
              ),
            Text(
              text,
              style: bodyText2?.copyWith(
                color: isSelected ? Colors.red : bodyText2.color,
              ),
            ),
          ],
        ),
      );
}

class AppDrawer extends StatelessWidget with AppBarHelper {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText2!;
    return GetX<AppBarController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(kDefaultMargin / 2),
        child: Column(children: [
          Image.asset(
            'assets/images/logo2.png',
            width: 150,
          ),
          const SizedBox(width: kDefaultMargin / 4),
          const Divider(),
          const SizedBox(width: kDefaultMargin / 4),
          if (!controller.isRefreshing)
            _appBarButton('Home', bodyText1, () {
              onNavigateHome(context);
              Navigator.of(context).pop();
            },
                isSelected: controller.isItemSelected(0),
                icon: 'assets/icons/home.svg'),
          //
          if (!controller.isRefreshing)
            _appBarButton('Pool', bodyText1, () {
              onNavigatePool(context);

              Navigator.of(context).pop();
            },
                isSelected: controller.isItemSelected(1),
                icon: 'assets/icons/pool.svg'),
          //
          if (!controller.isRefreshing)
            _appBarButton('Calculator', bodyText1, () {
              onNavigateCalculator(context);
              Navigator.of(context).pop();
            },
                isSelected: controller.isItemSelected(2),
                icon: 'assets/icons/calculator.svg'),

          if (!controller.isRefreshing)
            _appBarButton('Wallet', bodyText1, () {
              onNavigateWallet(context);
              Navigator.of(context).pop();
            },
                isSelected: controller.isItemSelected(3),
                icon: 'assets/icons/wallet.svg'),
          const Spacer(),
          CustomOutlinedButton(
              onPressed: onAppPressed,
              widget: const Text('Download Application')),
        ]),
      );
    });
  }

  Widget _appBarButton(
    String text,
    TextStyle? bodyText2,
    VoidCallback onPressed, {
    bool isSelected = false,
    String? icon,
  }) =>
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.only(bottom: kDefaultMargin / 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: isSelected ? Colors.red.withOpacity(.1) : Colors.transparent,
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Row(
              children: [
                if (icon != null)
                  SvgImage(
                    iconLocation: icon,
                    name: text,
                    color: isSelected ? Colors.red : bodyText2!.color!,
                    size: 14,
                  ),
                if (icon != null)
                  const SizedBox(
                    width: 3,
                  ),
                Text(
                  text,
                  style: bodyText2?.copyWith(
                    color: isSelected ? Colors.red : bodyText2.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class AppBarHelper {
  void updateScreen() {}

  updateListener(BuildContext context) {
    final controller = Get.find<AppBarController>();
    final name = context.router.topPage?.name?.trim();
    switch (name) {
      case HomeBody.name:
        controller.updateCurrentItem(0);
        break;
      case PoolRoute.name:
        controller.updateCurrentItem(1);
        break;
      case CalculatorRoute.name:
        controller.updateCurrentItem(2);
        break;
      case WalletRoute.name:
        controller.updateCurrentItem(3);

        break;
      default:
        controller.updateCurrentItem(-1);
        break;
    }
  }

  onNavigateHome(BuildContext context) {
    context.router.push(const HomeBody());
  }

  onNavigatePool(BuildContext context) {
    context.router.push(const PoolRoute());
  }

  onNavigateCalculator(BuildContext context) {
    context.router.push(const CalculatorRoute());
  }

  onNavigateWallet(BuildContext context) {
    context.router.push(const WalletRoute());
  }

  onAppPressed() {}

  onSIgnInPressed(BuildContext context) {
    context.router.navigate(const LoginRoute());
  }

  onSIgnUpPressed(BuildContext context) {
    context.router.navigate(const RegisterRoute());
  }

  Widget profileButton(TextStyle? bodyText2, BuildContext context) =>
      DropDownWidget(
          items: [
            AppLocalizations.of(context)!.twoFactorAuthentication,
            AppLocalizations.of(context)!.changePassword,
            AppLocalizations.of(context)!.signOut,
          ],
          selectedPosition: -1,
          onUpdate: (value) {
            if (value == 0) {
              update2faSecurity(context);
            } else if (value == 1) {
              context.router.push(const ChangePasswordRoute());
            } else if (value == 2) {
              showLogoutDialog(context);
            }
          },
          parent: Row(
            children: [
              const Icon(
                Icons.person_rounded,
              ),
              const SizedBox(
                width: kDefaultMargin / 4,
              ),
              Text(
                AppPreferences.userName,
                style: bodyText2,
              ),
              const SizedBox(
                width: kDefaultMargin / 4,
              ),
              const Icon(
                Icons.arrow_drop_down_rounded,
              ),
            ],
          ),
          childBuilder: (value) {
            if (value ==
                AppLocalizations.of(context)!.twoFactorAuthentication) {
              return Row(
                children: [
                  Expanded(
                    child: Text(value, style: bodyText2),
                  ),
                  const SizedBox(width: kDefaultMargin / 4),
                  Switch.adaptive(
                    value: AppPreferences.get2faSecurityEnabled,
                    onChanged: (_) {},
                    activeColor: kPrimaryColor,
                  )
                ],
              );
            } else {
              return Text(
                value,
                style: bodyText2,
              );
            }
          });

  Uri _emailLaunchFunction() {
    Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: supportEmailAddress,
      query: _encodeQueryParameters(
          <String, String>{'subject': 'Customer Support: NoonPool App'}),
    );

    return emailLaunchUri;
  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Widget settingsButton(TextStyle? bodyText2, BuildContext context) =>
      DropDownWidget(
          items: [
            AppLocalizations.of(context)!.helpCenter,
            // AppLocalizations.of(context)!.language,
          ],
          selectedPosition: -1,
          onUpdate: (index) async {
            if (index == 1) {
              // context.router.push(const LanguageChanger());
            } else if (index == 0) {
              final url = _emailLaunchFunction();
              final canLaunch = await canLaunchUrl(url);
              if (canLaunch) {
                await launchUrl(_emailLaunchFunction());
              } else {
                MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Kindly send a mail to  $supportEmailAddress ')));
              }
            }
          },
          parent: const Icon(
            Icons.more_vert_rounded,
          ),
          childBuilder: (value) {
            return Text(
              value,
              style: bodyText2,
            );
          });

  void update2faSecurity(BuildContext context) async {
    final newValue = !AppPreferences.get2faSecurityEnabled;
    if (newValue) {
      await context.router.push(const OtpRoute());

      updateScreen();
    } else {
      await context.router.push(VerifyOtpRoute(
        id: AppPreferences.userId,
        onNext: (secret) async {
          showLoadingData(context);

          try {
            await set2FAStatus(
              status: false,
              secret: secret,
            );
            Navigator.of(context).pop();
            MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.updateSuccessful,
                ),
              ),
            );
          } catch (exception) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(exception.toString()),
              ),
            );
          }
          AppPreferences.set2faSecurityStatus(isEnabled: false);
          updateScreen();

          MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.authTurnedOff),
            ),
          );
        },
      ));

      updateScreen();
    }
  }

  showLoadingData(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    final bodyText2 = textTheme.bodyText2!;
    final size = MediaQuery.of(context).size;

    final width = size.width;

    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Material(
          child: Container(
        width: width * .4,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator.adaptive(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(AppLocalizations.of(context)!.requestProcessing,
                style: bodyText1),
            const SizedBox(
              height: 5,
            ),
            Text(
                AppLocalizations.of(context)!
                    .pleaseBePatientWhileWeProcessYourRequest,
                textAlign: TextAlign.center,
                style: bodyText2),
          ],
        ),
      )),
    );

    showGeneralDialog(
      context: context,
         useRootNavigator: false,
      barrierLabel: "Request Processing",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!.copyWith(fontSize: 20);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 16);
    showDialog(
        context: context,
           useRootNavigator: false,
        builder: (ctx) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            title: Text(
              AppLocalizations.of(context)!.signOut,
              style: bodyText1,
            ),
            content: Text(
              AppLocalizations.of(context)!.doYouWishToSignOutOfThisDevice,
              style: bodyText2,
            ),
            contentPadding: const EdgeInsets.all(kDefaultMargin / 2),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: bodyText2,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AppPreferences.setLoginStatus(status: false);

                  context.router.pushAll([const HomeBody()]);
                  Get.find<AppBarController>()
                      .updateLoginStatus(AppPreferences.loginStatus);
                },
                child: Text(
                  AppLocalizations.of(context)!.signOut,
                  style: bodyText2.copyWith(color: kPrimaryColor),
                ),
              ),
            ],
          );
        });
  }
}
