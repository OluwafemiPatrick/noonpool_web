// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i24;
import 'package:flutter/material.dart' as _i25;

import '../models/wallet_data/datum.dart' as _i27;
import '../pages/auth/change_password/change_password.dart' as _i22;
import '../pages/auth/change_password/change_password_confirmation_screen.dart'
    as _i23;
import '../pages/auth/forgot_password/forgot_password.dart' as _i16;
import '../pages/auth/forgot_password/forgot_password_confirmation_screen.dart'
    as _i17;
import '../pages/auth/login/login_sceen.dart' as _i14;
import '../pages/auth/register/register_sceen.dart' as _i15;
import '../pages/auth/register/registration_confirmation_screen.dart' as _i19;
import '../pages/auth/register/verify_user_account.dart' as _i18;
import '../pages/calculator/calculator_page.dart' as _i4;
import '../pages/home/home_page.dart' as _i1;
import '../pages/home/home_page_body.dart' as _i3;
import '../pages/otp/otp_screen.dart' as _i20;
import '../pages/otp/update_2fa.dart' as _i2;
import '../pages/otp/verify_otp.dart' as _i21;
import '../pages/pool/pool_data.dart' as _i8;
import '../pages/recieve_assets/receive_asset.dart' as _i9;
import '../pages/recieve_assets/recieve_asset_list.dart' as _i10;
import '../pages/send_assets/send_asset.dart' as _i12;
import '../pages/send_assets/send_asset_list.dart' as _i11;
import '../pages/send_assets/send_input.dart' as _i13;
import '../pages/settings/language_changer.dart' as _i5;
import '../pages/transactions/wallet_transaction_screen.dart' as _i7;
import '../pages/wallet/wallet_page.dart' as _i6;
import 'app_router.dart' as _i26;

class AppRouter extends _i24.RootStackRouter {
  AppRouter([_i25.GlobalKey<_i25.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i24.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomePage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    Update2FA.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.Update2FA(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    HomeBody.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.HomeBody(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    CalculatorRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.CalculatorPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    LanguageChanger.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.LanguageChanger(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    WalletRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.WalletPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    WalletTransactionsRoute.name: (routeData) {
      final args = routeData.argsAs<WalletTransactionsRouteArgs>();
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: _i7.WalletTransactionsPage(
              key: args.key, walletDatum: args.walletDatum),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    PoolRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i8.PoolPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    ReceiveAssets.name: (routeData) {
      final args = routeData.argsAs<ReceiveAssetsArgs>();
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i9.ReceiveAssets(key: args.key, walletDatum: args.walletDatum),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    RecieveAssetList.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i10.RecieveAssetList(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    SendAssetList.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i11.SendAssetList(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    SendAsset.name: (routeData) {
      final args = routeData.argsAs<SendAssetArgs>();
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: _i12.SendAsset(
              key: args.key,
              assetDatum: args.assetDatum,
              recipientAddress: args.recipientAddress,
              amount: args.amount),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    SendInputScreen.name: (routeData) {
      final args = routeData.argsAs<SendInputScreenArgs>();
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: _i13.SendInputScreen(
              key: args.key, walletDatum: args.walletDatum),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    LoginRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i14.LoginPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    RegisterRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i15.RegisterPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i16.ForgotPasswordPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    ForgotPasswordConfirmationRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i17.ForgotPasswordConfirmationPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    VerifyUserAccount.name: (routeData) {
      final args = routeData.argsAs<VerifyUserAccountArgs>();
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: _i18.VerifyUserAccount(key: args.key, email: args.email),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    RegistrationConfirmationScreen.name: (routeData) {
      final args = routeData.argsAs<RegistrationConfirmationScreenArgs>();
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: _i19.RegistrationConfirmationScreen(
              key: args.key, email: args.email),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    OtpRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i20.OtpPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: _i21.VerifyOtpPage(
              key: args.key,
              onNext: args.onNext,
              backEnaled: args.backEnaled,
              id: args.id),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    ChangePasswordRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i22.ChangePasswordPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    ChangePasswordConfirmationRoute.name: (routeData) {
      return _i24.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i23.ChangePasswordConfirmationPage(),
          customRouteBuilder: _i26.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i24.RouteConfig> get routes => [
        _i24.RouteConfig(HomeRoute.name, path: '/', children: [
          _i24.RouteConfig(Update2FA.name, path: '', parent: HomeRoute.name),
          _i24.RouteConfig(HomeBody.name, path: 'home', parent: HomeRoute.name),
          _i24.RouteConfig(CalculatorRoute.name,
              path: 'calculator', parent: HomeRoute.name),
          _i24.RouteConfig(LanguageChanger.name,
              path: 'language', parent: HomeRoute.name),
          _i24.RouteConfig(WalletRoute.name,
              path: 'wallet', parent: HomeRoute.name),
          _i24.RouteConfig(WalletTransactionsRoute.name,
              path: 'transactions', parent: HomeRoute.name),
          _i24.RouteConfig(PoolRoute.name,
              path: 'pool', parent: HomeRoute.name),
          _i24.RouteConfig(ReceiveAssets.name,
              path: 'recieve', parent: HomeRoute.name),
          _i24.RouteConfig(RecieveAssetList.name,
              path: 'recieve-list', parent: HomeRoute.name),
          _i24.RouteConfig(SendAssetList.name,
              path: 'send-list', parent: HomeRoute.name),
          _i24.RouteConfig(SendAsset.name,
              path: 'send', parent: HomeRoute.name),
          _i24.RouteConfig(SendInputScreen.name,
              path: 'send-input', parent: HomeRoute.name),
          _i24.RouteConfig(LoginRoute.name,
              path: 'login', parent: HomeRoute.name),
          _i24.RouteConfig(RegisterRoute.name,
              path: 'register', parent: HomeRoute.name),
          _i24.RouteConfig(ForgotPasswordRoute.name,
              path: 'forgot-password', parent: HomeRoute.name),
          _i24.RouteConfig(ForgotPasswordConfirmationRoute.name,
              path: 'forgot-password-confirmation', parent: HomeRoute.name),
          _i24.RouteConfig(VerifyUserAccount.name,
              path: 'verify-user', parent: HomeRoute.name),
          _i24.RouteConfig(RegistrationConfirmationScreen.name,
              path: 'confirmation', parent: HomeRoute.name),
          _i24.RouteConfig(OtpRoute.name, path: 'otp', parent: HomeRoute.name),
          _i24.RouteConfig(VerifyOtpRoute.name,
              path: 'verify-otp', parent: HomeRoute.name),
          _i24.RouteConfig(ChangePasswordRoute.name,
              path: 'change-password', parent: HomeRoute.name),
          _i24.RouteConfig(ChangePasswordConfirmationRoute.name,
              path: 'change-password-confirmation', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i24.PageRouteInfo<void> {
  const HomeRoute({List<_i24.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.Update2FA]
class Update2FA extends _i24.PageRouteInfo<void> {
  const Update2FA() : super(Update2FA.name, path: '');

  static const String name = 'Update2FA';
}

/// generated route for
/// [_i3.HomeBody]
class HomeBody extends _i24.PageRouteInfo<void> {
  const HomeBody() : super(HomeBody.name, path: 'home');

  static const String name = 'HomeBody';
}

/// generated route for
/// [_i4.CalculatorPage]
class CalculatorRoute extends _i24.PageRouteInfo<void> {
  const CalculatorRoute() : super(CalculatorRoute.name, path: 'calculator');

  static const String name = 'CalculatorRoute';
}

/// generated route for
/// [_i5.LanguageChanger]
class LanguageChanger extends _i24.PageRouteInfo<void> {
  const LanguageChanger() : super(LanguageChanger.name, path: 'language');

  static const String name = 'LanguageChanger';
}

/// generated route for
/// [_i6.WalletPage]
class WalletRoute extends _i24.PageRouteInfo<void> {
  const WalletRoute() : super(WalletRoute.name, path: 'wallet');

  static const String name = 'WalletRoute';
}

/// generated route for
/// [_i7.WalletTransactionsPage]
class WalletTransactionsRoute
    extends _i24.PageRouteInfo<WalletTransactionsRouteArgs> {
  WalletTransactionsRoute(
      {_i25.Key? key, required _i27.WalletDatum walletDatum})
      : super(WalletTransactionsRoute.name,
            path: 'transactions',
            args: WalletTransactionsRouteArgs(
                key: key, walletDatum: walletDatum));

  static const String name = 'WalletTransactionsRoute';
}

class WalletTransactionsRouteArgs {
  const WalletTransactionsRouteArgs({this.key, required this.walletDatum});

  final _i25.Key? key;

  final _i27.WalletDatum walletDatum;

  @override
  String toString() {
    return 'WalletTransactionsRouteArgs{key: $key, walletDatum: $walletDatum}';
  }
}

/// generated route for
/// [_i8.PoolPage]
class PoolRoute extends _i24.PageRouteInfo<void> {
  const PoolRoute() : super(PoolRoute.name, path: 'pool');

  static const String name = 'PoolRoute';
}

/// generated route for
/// [_i9.ReceiveAssets]
class ReceiveAssets extends _i24.PageRouteInfo<ReceiveAssetsArgs> {
  ReceiveAssets({_i25.Key? key, required _i27.WalletDatum walletDatum})
      : super(ReceiveAssets.name,
            path: 'recieve',
            args: ReceiveAssetsArgs(key: key, walletDatum: walletDatum));

  static const String name = 'ReceiveAssets';
}

class ReceiveAssetsArgs {
  const ReceiveAssetsArgs({this.key, required this.walletDatum});

  final _i25.Key? key;

  final _i27.WalletDatum walletDatum;

  @override
  String toString() {
    return 'ReceiveAssetsArgs{key: $key, walletDatum: $walletDatum}';
  }
}

/// generated route for
/// [_i10.RecieveAssetList]
class RecieveAssetList extends _i24.PageRouteInfo<void> {
  const RecieveAssetList() : super(RecieveAssetList.name, path: 'recieve-list');

  static const String name = 'RecieveAssetList';
}

/// generated route for
/// [_i11.SendAssetList]
class SendAssetList extends _i24.PageRouteInfo<void> {
  const SendAssetList() : super(SendAssetList.name, path: 'send-list');

  static const String name = 'SendAssetList';
}

/// generated route for
/// [_i12.SendAsset]
class SendAsset extends _i24.PageRouteInfo<SendAssetArgs> {
  SendAsset(
      {_i25.Key? key,
      required _i27.WalletDatum assetDatum,
      required String recipientAddress,
      required double amount})
      : super(SendAsset.name,
            path: 'send',
            args: SendAssetArgs(
                key: key,
                assetDatum: assetDatum,
                recipientAddress: recipientAddress,
                amount: amount));

  static const String name = 'SendAsset';
}

class SendAssetArgs {
  const SendAssetArgs(
      {this.key,
      required this.assetDatum,
      required this.recipientAddress,
      required this.amount});

  final _i25.Key? key;

  final _i27.WalletDatum assetDatum;

  final String recipientAddress;

  final double amount;

  @override
  String toString() {
    return 'SendAssetArgs{key: $key, assetDatum: $assetDatum, recipientAddress: $recipientAddress, amount: $amount}';
  }
}

/// generated route for
/// [_i13.SendInputScreen]
class SendInputScreen extends _i24.PageRouteInfo<SendInputScreenArgs> {
  SendInputScreen({_i25.Key? key, required _i27.WalletDatum walletDatum})
      : super(SendInputScreen.name,
            path: 'send-input',
            args: SendInputScreenArgs(key: key, walletDatum: walletDatum));

  static const String name = 'SendInputScreen';
}

class SendInputScreenArgs {
  const SendInputScreenArgs({this.key, required this.walletDatum});

  final _i25.Key? key;

  final _i27.WalletDatum walletDatum;

  @override
  String toString() {
    return 'SendInputScreenArgs{key: $key, walletDatum: $walletDatum}';
  }
}

/// generated route for
/// [_i14.LoginPage]
class LoginRoute extends _i24.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i15.RegisterPage]
class RegisterRoute extends _i24.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: 'register');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i16.ForgotPasswordPage]
class ForgotPasswordRoute extends _i24.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: 'forgot-password');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i17.ForgotPasswordConfirmationPage]
class ForgotPasswordConfirmationRoute extends _i24.PageRouteInfo<void> {
  const ForgotPasswordConfirmationRoute()
      : super(ForgotPasswordConfirmationRoute.name,
            path: 'forgot-password-confirmation');

  static const String name = 'ForgotPasswordConfirmationRoute';
}

/// generated route for
/// [_i18.VerifyUserAccount]
class VerifyUserAccount extends _i24.PageRouteInfo<VerifyUserAccountArgs> {
  VerifyUserAccount({_i25.Key? key, required String email})
      : super(VerifyUserAccount.name,
            path: 'verify-user',
            args: VerifyUserAccountArgs(key: key, email: email));

  static const String name = 'VerifyUserAccount';
}

class VerifyUserAccountArgs {
  const VerifyUserAccountArgs({this.key, required this.email});

  final _i25.Key? key;

  final String email;

  @override
  String toString() {
    return 'VerifyUserAccountArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i19.RegistrationConfirmationScreen]
class RegistrationConfirmationScreen
    extends _i24.PageRouteInfo<RegistrationConfirmationScreenArgs> {
  RegistrationConfirmationScreen({_i25.Key? key, required String email})
      : super(RegistrationConfirmationScreen.name,
            path: 'confirmation',
            args: RegistrationConfirmationScreenArgs(key: key, email: email));

  static const String name = 'RegistrationConfirmationScreen';
}

class RegistrationConfirmationScreenArgs {
  const RegistrationConfirmationScreenArgs({this.key, required this.email});

  final _i25.Key? key;

  final String email;

  @override
  String toString() {
    return 'RegistrationConfirmationScreenArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i20.OtpPage]
class OtpRoute extends _i24.PageRouteInfo<void> {
  const OtpRoute() : super(OtpRoute.name, path: 'otp');

  static const String name = 'OtpRoute';
}

/// generated route for
/// [_i21.VerifyOtpPage]
class VerifyOtpRoute extends _i24.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute(
      {_i25.Key? key,
      required dynamic Function(String) onNext,
      bool backEnaled = true,
      required String id})
      : super(VerifyOtpRoute.name,
            path: 'verify-otp',
            args: VerifyOtpRouteArgs(
                key: key, onNext: onNext, backEnaled: backEnaled, id: id));

  static const String name = 'VerifyOtpRoute';
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs(
      {this.key,
      required this.onNext,
      this.backEnaled = true,
      required this.id});

  final _i25.Key? key;

  final dynamic Function(String) onNext;

  final bool backEnaled;

  final String id;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, onNext: $onNext, backEnaled: $backEnaled, id: $id}';
  }
}

/// generated route for
/// [_i22.ChangePasswordPage]
class ChangePasswordRoute extends _i24.PageRouteInfo<void> {
  const ChangePasswordRoute()
      : super(ChangePasswordRoute.name, path: 'change-password');

  static const String name = 'ChangePasswordRoute';
}

/// generated route for
/// [_i23.ChangePasswordConfirmationPage]
class ChangePasswordConfirmationRoute extends _i24.PageRouteInfo<void> {
  const ChangePasswordConfirmationRoute()
      : super(ChangePasswordConfirmationRoute.name,
            path: 'change-password-confirmation');

  static const String name = 'ChangePasswordConfirmationRoute';
}
