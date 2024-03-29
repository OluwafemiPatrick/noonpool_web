import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/elevated_button.dart';

class ForgotPasswordConfirmationPage extends StatefulWidget {
  const ForgotPasswordConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordConfirmationPage> createState() =>
      _ForgotPasswordConfirmationPageState();
}

class _ForgotPasswordConfirmationPageState
    extends State<ForgotPasswordConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2;
    final bodyText1 = textTheme.bodyText1;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          SvgPicture.asset(
            'assets/icons/forgot_password_3.svg',
            height: 250,
            width: 250,
          ),
          const SizedBox(
            height: kDefaultMargin * 1.5,
          ),
          Text(
            AppLocalizations.of(context)!
                .yourPasswordHasBeenSuccessfullyResetPleaseLoginNow,
            style: bodyText1,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          CustomElevatedButton(
            onPressed: () {
              context.router.pushAndPopUntil(
                const LoginRoute(),
                predicate: (route) => route.isFirst,
              );
            },
            widget: Text(
              AppLocalizations.of(context)!.loginToAccount,
              style: bodyText2!.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
