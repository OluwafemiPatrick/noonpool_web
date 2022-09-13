import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/models/user_secret.dart';
import 'package:noonpool_web/widgets/elevated_button.dart';
import 'package:noonpool_web/widgets/error_widget.dart';
import 'package:otp/otp.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyOtpPage extends StatefulWidget {
  final Function(String) onNext;
  final String id;
  final bool backEnaled;

  const VerifyOtpPage({
    Key? key,
    required this.onNext,
    this.backEnaled = true,
    required this.id,
  }) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  bool _isLoading = true;
  bool _hasError = false;
  UserSecret _userSecret = UserSecret();

  final otpFieldController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  late StreamSubscription _twoFASubscription;
  dynamic _currentOtp;
  Stream<dynamic>? otpStream;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }

  getData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      _userSecret = await get2FAStatus(id: widget.id);
      _hasError = false;
      setUpListeners();
    } catch (exception) {
      MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            exception.toString(),
          ),
        ),
      );
      _hasError = true;
    }
    setState(() {
      _isLoading = false;
    });
  }

  setUpListeners() {
    otpStream = Stream<dynamic>.periodic(
      const Duration(seconds: 0),
      (val) => OTP.generateTOTPCodeString(
        _userSecret.secret ?? '',
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
  }

  @override
  void dispose() {
    _twoFASubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2;
    final bodyText1 = textTheme.bodyText1;
    return _isLoading
        ? buildLoadingBody()
        : _hasError
            ? CustomErrorWidget(
                error: AppLocalizations.of(context)!
                    .anErrorOccurredWithTheDataFetchPleaseTryAgain,
                onRefresh: () {
                  getData();
                })
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    title: Text(
                      AppLocalizations.of(context)!.verifyCode,
                      style: bodyText1?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    'assets/icons/security.svg',
                    height: 250,
                    width: 250,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .toProceedPleaseEnterTheCodeFromTheGoogleAuthenticatorApplication,
                    textAlign: TextAlign.center,
                    style: bodyText1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildOTPField(bodyText2!),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    widget: Text(
                      AppLocalizations.of(context)!.verify,
                      style: bodyText2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      final isValid = _formKey.currentState?.validate();
                      if ((isValid ?? false) == false) {
                        return;
                      }

                      final otp = otpFieldController.text.trim();

                      if (otp == _currentOtp) {
                        Navigator.pop(context);
                        widget.onNext(_userSecret.secret ?? '');
                      } else {
                        MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
                            SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .theCodeEnteredDoesNotMatch)));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
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

  Widget buildLoadingBody() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
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
