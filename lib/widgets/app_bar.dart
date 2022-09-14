import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/controller/app_bar_controller.dart';
import 'package:noonpool_web/pages/auth/auth_screen.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/svg_image.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText2!;
    return GetX<AppBarController>(builder: (controller) {
      return Row(
        children: [
          const SizedBox(width: 10),
          /*  Text(
          AppPreferences.userName,
          style: bodyText1!.copyWith(fontWeight: FontWeight.bold),
        ), */
          Image.asset(
            'assets/images/logo2.png',
            width: 80,
          ),
          const SizedBox(width: 10),
          _button2('Home', bodyText1, () {
            controller.updateCurrentItem(0);
            context.router.push(const HomeBody());
          },
              isSelected: controller.isItemSelected(0),
              icon: 'assets/icons/home.svg'),
          //
          _button2('Pool', bodyText1, () {
            controller.updateCurrentItem(1);
            context.router.push(const PoolRoute());
          },
              isSelected: controller.isItemSelected(1),
              icon: 'assets/icons/pool.svg'),
          //
          _button2('Calculator', bodyText1, () {
            controller.updateCurrentItem(2);
            context.router.push(const CalculatorRoute());
          },
              isSelected: controller.isItemSelected(2),
              icon: 'assets/icons/calculator.svg'),
          //
          _button2('Wallet', bodyText1, () {
            controller.updateCurrentItem(3);
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
          _button2(
            'Sign In',
            bodyText1,
            () {
              showAuthDialog(context);
            },
          ),
          _button2(
            'Sign Up',
            bodyText1,
            () {},
          ),
          const SizedBox(width: 10),
        ],
      );
    });
  }

  void showAuthDialog(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    Dialog dialog = Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: height * 0.7,
        width: width * 0.7,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Expanded(
                child: Image.asset(
              'assets/images/header_bg.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
            const Expanded(
              child: AuthPage(
                startPage: 0,
              ),
            ),
          ],
        ),
      ),
    );
    showGeneralDialog(
      context: context,
      barrierLabel: "Authentication",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
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
}
