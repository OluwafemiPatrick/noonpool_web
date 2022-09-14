import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/outlined_button.dart';

class LoginNeededWidget extends StatelessWidget {
  final Widget child;
  const LoginNeededWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    final bodyText2 = textTheme.bodyText2!;
    final id = AppPreferences.userId;
    return id.isNotEmpty
        ? child
        : Container(
            height: 500,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  const Spacer(flex: 1),
                  Lottie.asset(
                    'assets/lottie/login.json',
                    width: 200,
                    animate: true,
                    reverse: true,
                    repeat: true,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Kindly Sign In to access this page',
                    style: bodyText1,
                  ),
                  const SizedBox(height: 20),
                  CustomOutlinedButton(
                    onPressed: () {
                      context.router.push(const LoginRoute());
                    },
                    widget: Text(
                      'Sign In',
                      style: bodyText2.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                ]),
          );
  }
}
