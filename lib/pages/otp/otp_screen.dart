import 'dart:async';
import 'dart:math';
import 'package:base32/base32.dart';
import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/widgets/elevated_button.dart';
import 'package:otp/otp.dart';
import 'package:pinput/pinput.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String secretKey = '';
  bool _isLoading = false;
  final otpFieldController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  StreamSubscription? _twoFASubscription;

  dynamic _currentOtp;
  Stream<dynamic>? otpStream;
  @override
  void initState() {
    secretKey = SecretGenerator.getSecret(10);
    otpStream = Stream<dynamic>.periodic(
      const Duration(seconds: 0),
      (val) => OTP.generateTOTPCodeString(
        secretKey,
        DateTime.now().millisecondsSinceEpoch,
        length: 6,
        interval: 30,
        algorithm: Algorithm.SHA1,
        isGoogle: true,
      ),
    ).asBroadcastStream();

    if (otpStream != null) {
      _twoFASubscription = otpStream!.listen((event) {
        _currentOtp = event;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _twoFASubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2;
    final bodyText1 = textTheme.bodyText1;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              AppLocalizations.of(context)!.enableAuthentication,
              style: bodyText1?.copyWith(fontWeight: FontWeight.bold),
            ),
            leading: null,
            automaticallyImplyLeading: false,
          ),
          Text(
            AppLocalizations.of(context)!
                .pleaseDownloadTheApplicationGoogleAuthenticatorOnYourMobileDeviceAndScanTheCode,
            textAlign: TextAlign.center,
            style: bodyText2,
          ),
          const SizedBox(
            height: 10,
          ),
          buildQrCode(bodyText2),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!
                .pleaseEnterTheGeneratedCodeBelowANewCodeWillBeGeneratedAutomaticallyEvery30Seconds,
            textAlign: TextAlign.center,
            style: bodyText2,
          ),
          const SizedBox(
            height: 20,
          ),
          buildOTPField(bodyText2!),
          const SizedBox(
            height: 20,
          ),
          CustomElevatedButton(
            widget: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.enable2fa,
                    style: bodyText2.copyWith(
                      color: Colors.white,
                    ),
                  ),
            onPressed: () async {
              final isValid = _formKey.currentState?.validate();
              if ((isValid ?? false) == false || _isLoading) {
                return;
              }

              final otp = otpFieldController.text.trim();

              if (otp == _currentOtp) {
                setState(() {
                  _isLoading = true;
                });
                try {
                  await set2FAStatus(
                    status: true,
                    secret: secretKey,
                  );
                  AppPreferences.set2faSecurityStatus(isEnabled: true);
                  () {
                    MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text(
                            AppLocalizations.of(context)!.enabledSuccessfully),
                      ),
                    );
                    Navigator.pop(context);
                  }();
                } catch (exception) {
                  MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(
                      content: Text(exception.toString()),
                    ),
                  );
                }
                setState(() {
                  _isLoading = false;
                });
              } else {
                MyApp.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!
                        .theCodeEnteredDoesNotMatch)));
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  buildProgressBar() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: kLightBackgroud,
        ),
      ),
    );
  }

  Card buildQrCode(TextStyle? bodyText2) {
    //         'otpauth://totp/com.noonpool.app?Algorithm=SHA1&digits=6&secret=JBSWY3DPEHPK3PXP&issuer=Noonpool&period=30',
    final otpUrl =
        'otpauth://totp/${AppPreferences.userName}?Algorithm=SHA1&digits=6&secret=$secretKey&issuer=Noonpool&period=30';
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: QrImage(
          data: otpUrl,
          version: QrVersions.auto,
          size: 250,
        ),
      ),
    );
  }

  Widget buildOTPField(TextStyle bodyText2) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Colors.red),
      ),
    );

    return Form(
      key: _formKey,
      child: Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        errorPinTheme: errorPinTheme,
        errorTextStyle: bodyText2.copyWith(
          color: Colors.red,
        ),
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        controller: otpFieldController,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        validator: (s) {
          if (s == null || s.isEmpty) {
            return AppLocalizations.of(context)!.pleaseEnterThePinYouRecieved;
          } else if (s.trim().length < 4) {
            return AppLocalizations.of(context)!.pleaseEnterTheCompletePin;
          }
          return null;
        },
      ),
    );
  }
}

class SecretGenerator {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  static String getSecret(int length) {
    final Random rnd = Random.secure();

    final rawString = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));

    return base32.encodeString(rawString);
  }
}
