// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/constants/strings.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/controller/app_bar_controller.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/svg_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.router.root.addListener(updateListener);
    });
  }

  @override
  void dispose() {
    context.router.root.removeListener(updateListener);
    super.dispose();
  }

  updateListener() {
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText2!;
    return GetX<AppBarController>(builder: (controller) {
      return Row(
        children: [
          const SizedBox(width: 10),

          Image.asset(
            'assets/images/logo2.png',
            width: 80,
          ),
          const SizedBox(width: 10),
          if (!controller.isRefreshing)
            _button2('Home', bodyText1, () {
              context.router.push(const HomeBody());
            },
                isSelected: controller.isItemSelected(0),
                icon: 'assets/icons/home.svg'),
          //
          if (!controller.isRefreshing)
            _button2('Pool', bodyText1, () {
              context.router.push(const PoolRoute());
            },
                isSelected: controller.isItemSelected(1),
                icon: 'assets/icons/pool.svg'),
          //
          if (!controller.isRefreshing)
            _button2('Calculator', bodyText1, () {
              context.router.push(const CalculatorRoute());
            },
                isSelected: controller.isItemSelected(2),
                icon: 'assets/icons/calculator.svg'),

          if (!controller.isRefreshing)
            _button2('Wallet', bodyText1, () {
              context.router.push(const WalletRoute());
            },
                isSelected: controller.isItemSelected(3),
                icon: 'assets/icons/wallet.svg'),
          const Spacer(),
          _button2(
            'APP',
            bodyText1,
            () {},
          ),
          if (!controller.isUserLoggedIn && !controller.isRefreshing)
            _button2(
              'Sign In',
              bodyText1,
              () {
                context.router.navigate(const LoginRoute());
              },
            ),
          if (!controller.isUserLoggedIn && !controller.isRefreshing)
            _button2(
              'Sign Up',
              bodyText1,
              () {
                context.router.navigate(const RegisterRoute());
              },
            ),
          const SizedBox(width: 10),
          if (controller.isUserLoggedIn && !controller.isRefreshing)
            profile(bodyText1),
          const SizedBox(width: 10),
          moreSettings(bodyText1, context),
          const SizedBox(width: 10),
        ],
      );
    });
  }

  Widget _button2(
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
          ));

  Widget profile(TextStyle? bodyText2) => DropDownWidget(
          items: [
            AppLocalizations.of(context)!.twoFactorAuthentication,
            AppLocalizations.of(context)!.changePassword,
            AppLocalizations.of(context)!.signOut,
          ],
          selectedPosition: -1,
          onUpdate: (value) {
            if (value == 0) {
              update2faSecurity();
            } else if (value == 1) {
              context.router.push(const ChangePasswordRoute());
            } else if (value == 2) {
              showLogoutDialog();
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

  Widget moreSettings(TextStyle? bodyText2, BuildContext context) =>
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

  void update2faSecurity() async {
    final newValue = !AppPreferences.get2faSecurityEnabled;
    if (newValue) {
      await context.router.push(const OtpRoute());

      setState(() {});
    } else {
      await context.router.push(VerifyOtpRoute(
        id: AppPreferences.userId,
        onNext: (secret) async {
          showLoadingData();

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
          setState(() {
            AppPreferences.set2faSecurityStatus(isEnabled: false);
          });

          MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.authTurnedOff),
            ),
          );
        },
      ));

      setState(() {});
    }
  }

  showLoadingData() async {
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

  void showLogoutDialog() {
    TextTheme textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!.copyWith(fontSize: 20);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 16);
    showDialog(
        context: context,
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

class DropDownWidget extends StatelessWidget {
  final List<String> items;
  final int selectedPosition;
  final Function(int) onUpdate;
  final Widget parent;
  final Widget Function(String) childBuilder;
  const DropDownWidget({
    Key? key,
    required this.items,
    required this.selectedPosition,
    required this.onUpdate,
    required this.parent,
    required this.childBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: parent,
        items: items
            .map((item) => DropdownMenuItem<String>(
                value: item, child: childBuilder(item)))
            .toList(),
        value: selectedPosition < 0 ? null : items[selectedPosition],
        onChanged: (value) {
          if (value != null) {
            onUpdate(items.indexOf(value.toString()));
          }
        },
        itemPadding: const EdgeInsets.only(
            left: kDefaultPadding / 2, right: kDefaultPadding / 2),
        dropdownMaxHeight: 200,
        dropdownWidth: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
      ),
    );
  }
}
