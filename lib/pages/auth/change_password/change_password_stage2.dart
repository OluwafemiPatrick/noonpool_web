import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/widgets/elevated_button.dart';

class ChangePasswordStage2 extends StatefulWidget {
  final String email;
  final VoidCallback onDone;

  const ChangePasswordStage2({
    Key? key,
    required this.email,
    required this.onDone,
  }) : super(key: key);

  @override
  State<ChangePasswordStage2> createState() => _ChangePasswordStage2State();
}

class _ChangePasswordStage2State extends State<ChangePasswordStage2> {
  final stage3FormKey = GlobalKey<FormState>();
  bool _isPasswordNotVisible = true;
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  final _retypePasswordFocusNode = FocusNode();
  @override
  void dispose() {
    _passwordController.dispose();
    _retypePasswordController.dispose();
    _retypePasswordFocusNode.dispose();
    super.dispose();
  }

  List<Widget> buildPasswordField(TextStyle bodyText2) {
    return [
      TextFormField(
        controller: _passwordController,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_retypePasswordFocusNode);
        },
        obscureText: _isPasswordNotVisible,
        enableSuggestions: !_isPasswordNotVisible,
        autocorrect: !_isPasswordNotVisible,
        style: bodyText2,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.password,
          hintText: AppLocalizations.of(context)!.enterYourPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordNotVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isPasswordNotVisible = !_isPasswordNotVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.pleaseProvideYourPassword;
          } else if (value.length < 8) {
            return AppLocalizations.of(context)!.passwordMustBeMoreThan8Letters;
          } else if (value != _retypePasswordController.text) {
            return AppLocalizations.of(context)!.passwordsAreNotTheSame;
          }
          return null;
        },
      ),
      const SizedBox(
        height: 10,
      ),
    ];
  }

  List<Widget> buildVerifyPasswordField(TextStyle bodyText2) {
    return [
      TextFormField(
        controller: _retypePasswordController,
        textInputAction: TextInputAction.done,
        focusNode: _retypePasswordFocusNode,
        obscureText: _isPasswordNotVisible,
        enableSuggestions: !_isPasswordNotVisible,
        autocorrect: !_isPasswordNotVisible,
        style: bodyText2,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordNotVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isPasswordNotVisible = !_isPasswordNotVisible;
              });
            },
          ),
          labelText: AppLocalizations.of(context)!.retypePassword,
          hintText: AppLocalizations.of(context)!.retypeYourPassword,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.pleaseConfirmYourPassword;
          } else if (value.length < 8) {
            return AppLocalizations.of(context)!.passwordMustBeMoreThan8Letters;
          } else if (value != _passwordController.text) {
            return AppLocalizations.of(context)!.passwordsAreNotTheSame;
          }
          return null;
        },
      ),
      const SizedBox(
        height: 10,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2!;
    final bodyText1 = textTheme.bodyText1!;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
        key: stage3FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kDefaultMargin * 2,
              width: double.infinity,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/icons/security.svg',
                semanticsLabel: 'authorize new device',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(
              height: kDefaultMargin * 2,
            ),
            Text(AppLocalizations.of(context)!.passwordChange,
                style: bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: (5)),
            Text(
              AppLocalizations.of(context)!.enterANewPasswordForYourAccount,
              style: bodyText2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: kDefaultMargin / 2,
            ),
            ...buildPasswordField(bodyText2),
            ...buildVerifyPasswordField(bodyText2),
            const SizedBox(
              height: kDefaultMargin / 2,
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
                      AppLocalizations.of(context)!.resetPassword,
                      style: bodyText2.copyWith(color: Colors.white),
                    ),
              onPressed: () async {
                final isValid = stage3FormKey.currentState?.validate();
                if ((isValid ?? false) == false || _isLoading) {
                  return;
                }

                sendResetPasswordLink();
              },
            ),
          ],
        ),
      ),
    );
  }

  sendResetPasswordLink() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final String password = _passwordController.text.trim();
      await resetPassword(
        email: widget.email,
        password: password,
      );

      widget.onDone();
    } catch (exception) {
      MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            exception.toString(),
          ),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
}
