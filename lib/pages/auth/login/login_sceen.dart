import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/controller/app_bar_controller.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/elevated_button.dart';
import 'package:noonpool_web/widgets/outlined_button.dart';
import '../../../helpers/shared_preference_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _email = "email";
  static const _password = "password";
  bool _isHidden = true;
  bool _isLoading = false;

  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _initValues = {_email: '', _password: ''};

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _formKey.currentState?.validate();
    if ((isValid ?? false) == false || _isLoading) {
      return;
    }
    _formKey.currentState?.save();
    showLoginStatus();
  }

  Future showLoginStatus() async {
    final email = _initValues[_email].trim();
    final password = _initValues[_password].trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final loginDetails = await signInToUserAccount(
        email: email,
        password: password,
      );

      if (loginDetails.userDetails == null ||
          loginDetails.userDetails!.verified == null ||
          loginDetails.userDetails!.id == null) {
        () {
          MyApp.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
              content: Text(
                  AppLocalizations.of(context)!.anErrorOccurredWhileLogginIn)));
        }();
        return;
      }

      if (loginDetails.userDetails!.verified!) {
        proceed() {
          AppPreferences.setUserName(
              username: loginDetails.userDetails?.username ?? '');
          AppPreferences.setIdAndEmail(
              id: loginDetails.userDetails?.id ?? '',
              email: loginDetails.userDetails?.email ?? '');
          AppPreferences.setLoginStatus(status: true);
          AppPreferences.setOnBoardingStatus(status: true);
          AppPreferences.set2faSecurityStatus(
            isEnabled: loginDetails.userDetails!.g2FAEnabled ?? false,
          );
          Get.find<AppBarController>()
              .updateLoginStatus(AppPreferences.loginStatus);
          context.router.pushAll([const HomeBody()]);
        }

        if (loginDetails.userDetails!.g2FAEnabled == true) {
          context.router.push(VerifyOtpRoute(
            backEnaled: false,
            onNext: (_) => proceed(),
            id: loginDetails.userDetails!.id ?? '',
          ));
        } else {
          proceed();
        }
      } else {
        showVerificationDialog();
      }
    } catch (exception) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(exception.toString())));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void showVerificationDialog() {
    final size = MediaQuery.of(context).size;

    final width = size.width;

    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2;
    Dialog dialog = Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      elevation: 5,
      child: Container(
        width: width * .4,
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.all(kDefaultMargin / 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 150,
            ),
            const SizedBox(
              height: kDefaultMargin,
            ),
            Text(
              AppLocalizations.of(context)!.emailNotVerifiedClickToVerify,
              style: bodyText2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: kDefaultMargin,
            ),
            CustomOutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                showResendDialog();
              },
              widget: Text(
                AppLocalizations.of(context)!.resendVerificatoinLink,
                style: bodyText2!.copyWith(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showGeneralDialog(
      context: context,
      barrierLabel: "Verification Dialog",
      barrierDismissible: true,
      useRootNavigator: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
  }

  void showResendDialog() async {
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2;
    Dialog dialog = Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: Container(
        width: width * .4,
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.resendVerificatoinLink,
              style: bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    showGeneralDialog(
      context: context,
      useRootNavigator: false,
      barrierLabel: "Resend Verification",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    final email = _initValues[_email].trim();

    try {
      await sendUserOTP(email: email);
      () {
        Navigator.of(context).pop();
        MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.aNewOtpHasBeenSentToMail),
          ),
        );
        context.router.push(VerifyUserAccount(email: email));
      }();
    } catch (exception) {
      Navigator.of(context).pop();
      MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(exception.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final bodyText1 = themeData.textTheme.bodyText1!;
    final bodyText2 = themeData.textTheme.bodyText2!;

    return Column(
      children: [
        buildAppBar(bodyText1),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...buildEmailTextField(bodyText2),
                const SizedBox(
                  height: kDefaultMargin / 2,
                ),
                ...buildPasswordTextField(bodyText2),
                const SizedBox(
                  height: kDefaultMargin * 2,
                ),
                buildSignInButton(bodyText2),
                const SizedBox(
                  height: kDefaultMargin / 2,
                ),
                buildForgotPassword(bodyText2),
                const SizedBox(
                  height: kDefaultMargin / 2,
                ),
                buildRegisterButton(bodyText2)
              ],
            ),
          )),
        ),
      ],
    );
  }

  AppBar buildAppBar(TextStyle bodyText1) {
    return AppBar(
      leading: null,
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      title: Text(
        AppLocalizations.of(context)!.signIn,
        style: bodyText1,
      ),
    );
  }

  CustomElevatedButton buildSignInButton(TextStyle bodyText2) {
    return CustomElevatedButton(
      onPressed: () {
        _saveForm();
      },
      widget: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            )
          : Text(
              AppLocalizations.of(context)!.signIn,
              style: bodyText2.copyWith(color: Colors.white),
            ),
    );
  }

  List<Widget> buildEmailTextField(TextStyle bodyText2) {
    return [
      TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.email,
          hintText: AppLocalizations.of(context)!.pleaseEnterYourEmailAddress,
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
        style: bodyText2,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        validator: (value) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@+[a-zA-Z0-9]+\.[a-zA-Z]")
              .hasMatch(value ?? "");
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.pleaseProvideYourEmail;
          } else if (!emailValid) {
            return AppLocalizations.of(context)!.pleaseProvideAValidEmail;
          }
          return null;
        },
        onSaved: (value) {
          _initValues[_email] = value ?? "";
        },
      ),
    ];
  }

  List<Widget> buildPasswordTextField(TextStyle bodyText2) {
    return [
      TextFormField(
        textInputAction: TextInputAction.done,
        obscureText: _isHidden,
        focusNode: _passwordFocusNode,
        enableSuggestions: !_isHidden,
        autocorrect: !_isHidden,
        style: bodyText2,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
              });
            },
          ),
          labelText: AppLocalizations.of(context)!.password,
          hintText: AppLocalizations.of(context)!.enterYourPassword,
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
          }
          return null;
        },
        onSaved: (value) {
          _initValues[_password] = value ?? "";
        },
      ),
    ];
  }

  Widget buildForgotPassword(TextStyle bodyText2) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          context.router.push(const ForgotPasswordRoute());
        },
        style: TextButton.styleFrom(
          textStyle: bodyText2,
        ),
        child: Text(
          AppLocalizations.of(context)!.forgotYourPassword,
        ),
      ),
    );
  }

  Widget buildRegisterButton(TextStyle bodyText2) {
    return InkWell(
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              AppLocalizations.of(context)!.dontHaveAnAccount,
              style: bodyText2,
            ),
            const SizedBox(
              width: kDefaultMargin / 4,
            ),
            Text(
              AppLocalizations.of(context)!.signUp,
              style: bodyText2.copyWith(color: kPrimaryColor),
            ),
          ],
        ),
      ),
      onTap: () {
        context.router.push(const RegisterRoute());
      },
    );
  }
}
