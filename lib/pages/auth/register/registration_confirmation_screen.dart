import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/elevated_button.dart';
import 'package:noonpool_web/widgets/text_button.dart';

class RegistrationConfirmationScreen extends StatefulWidget {
  final String email;
  const RegistrationConfirmationScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<RegistrationConfirmationScreen> createState() =>
      _RegistrationConfirmationScreenState();
}

class _RegistrationConfirmationScreenState
    extends State<RegistrationConfirmationScreen> {
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
            'assets/icons/Mail.svg',
            semanticsLabel: 'authorize new device',
            height: 280,
            width: 280,
          ),
          const SizedBox(
            height: kDefaultMargin,
          ),
          Text(
            AppLocalizations.of(context)!.verifyYourMail,
            style: bodyText1!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!
                .weHaveSentAOtpToYourMailKindlyClickOnProceedWhenYouRecieveIt,
            style: bodyText2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          CustomElevatedButton(
            onPressed: () {
              context.router.push(VerifyUserAccount(email: widget.email));
            },
            widget: Text(
              AppLocalizations.of(context)!.verifyOtp,
              style: bodyText2!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: kDefaultMargin / 2,
          ),
          CustomTextButton(
            onPressed: showResendDialog,
            widget: Text(
              AppLocalizations.of(context)!.resendOtp,
            ),
          ),
        ],
      ),
    );
  }

  void showResendDialog() async {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2;
    Dialog dialog = Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.resendingVerificationPleaseWait,
              style: bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    showGeneralDialog(
      context: context,
      barrierLabel: "Resend Verification",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    try {
      await sendUserOTP(
        email: widget.email,
      );
      () {
        Navigator.of(context).pop();
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.aNewOtpHasBeenSentToYourAccount,
            ),
          ),
        );
      }();
    } catch (exception) {
      Navigator.of(context).pop();
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(
          content: Text(
            exception.toString(),
          ),
        ),
      );
      //
    }
  }
}
