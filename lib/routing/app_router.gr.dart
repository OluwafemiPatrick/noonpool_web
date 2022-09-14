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
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import '../models/wallet_data/datum.dart' as _i17;
import '../pages/calculator/calculator_page.dart' as _i5;
import '../pages/home/home_page.dart' as _i1;
import '../pages/home/home_page_body.dart' as _i4;
import '../pages/otp/otp_screen.dart' as _i2;
import '../pages/otp/verify_otp.dart' as _i3;
import '../pages/pool/pool_data.dart' as _i9;
import '../pages/recieve_assets/receive_asset.dart' as _i10;
import '../pages/recieve_assets/recieve_asset_list.dart' as _i11;
import '../pages/send_assets/send_asset.dart' as _i13;
import '../pages/send_assets/send_asset_list.dart' as _i12;
import '../pages/send_assets/send_input.dart' as _i6;
import '../pages/transactions/wallet_transaction_screen.dart' as _i8;
import '../pages/wallet/wallet_page.dart' as _i7;
import 'app_router.dart' as _i16;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomePage(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    OtpRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.OtpPage(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.VerifyOtpPage(
              key: args.key,
              onNext: args.onNext,
              backEnaled: args.backEnaled,
              id: args.id),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    HomeBody.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.HomeBody(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    CalculatorRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.CalculatorPage(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    QrScanner.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.QrScanner(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    WalletRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i7.WalletPage(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    WalletTransactionsRoute.name: (routeData) {
      final args = routeData.argsAs<WalletTransactionsRouteArgs>();
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: _i8.WalletTransactionsPage(
              key: args.key, walletDatum: args.walletDatum),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    PoolRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i9.PoolPage(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    ReceiveAssets.name: (routeData) {
      final args = routeData.argsAs<ReceiveAssetsArgs>();
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i10.ReceiveAssets(key: args.key, walletDatum: args.walletDatum),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    RecieveAssetList.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i11.RecieveAssetList(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    SendAssetList.name: (routeData) {
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i12.SendAssetList(),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    SendAsset.name: (routeData) {
      final args = routeData.argsAs<SendAssetArgs>();
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child: _i13.SendAsset(
              key: args.key,
              assetDatum: args.assetDatum,
              recipientAddress: args.recipientAddress,
              amount: args.amount),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    SendInputScreen.name: (routeData) {
      final args = routeData.argsAs<SendInputScreenArgs>();
      return _i14.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i6.SendInputScreen(key: args.key, walletDatum: args.walletDatum),
          customRouteBuilder: _i16.fadePageBuilder,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(HomeRoute.name, path: '/', children: [
          _i14.RouteConfig(HomeBody.name, path: '', parent: HomeRoute.name),
          _i14.RouteConfig(CalculatorRoute.name,
              path: 'calculator', parent: HomeRoute.name),
          _i14.RouteConfig(QrScanner.name,
              path: 'scanner', parent: HomeRoute.name),
          _i14.RouteConfig(WalletRoute.name,
              path: 'wallet', parent: HomeRoute.name),
          _i14.RouteConfig(WalletTransactionsRoute.name,
              path: 'transactions', parent: HomeRoute.name),
          _i14.RouteConfig(PoolRoute.name,
              path: 'pool', parent: HomeRoute.name),
          _i14.RouteConfig(ReceiveAssets.name,
              path: 'recieve', parent: HomeRoute.name),
          _i14.RouteConfig(RecieveAssetList.name,
              path: 'recieve-list', parent: HomeRoute.name),
          _i14.RouteConfig(SendAssetList.name,
              path: 'send-list', parent: HomeRoute.name),
          _i14.RouteConfig(SendAsset.name,
              path: 'send', parent: HomeRoute.name),
          _i14.RouteConfig(SendInputScreen.name,
              path: 'send-input', parent: HomeRoute.name)
        ]),
        _i14.RouteConfig(OtpRoute.name, path: 'otp'),
        _i14.RouteConfig(VerifyOtpRoute.name, path: 'verify-otp')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.OtpPage]
class OtpRoute extends _i14.PageRouteInfo<void> {
  const OtpRoute() : super(OtpRoute.name, path: 'otp');

  static const String name = 'OtpRoute';
}

/// generated route for
/// [_i3.VerifyOtpPage]
class VerifyOtpRoute extends _i14.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute(
      {_i15.Key? key,
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

  final _i15.Key? key;

  final dynamic Function(String) onNext;

  final bool backEnaled;

  final String id;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, onNext: $onNext, backEnaled: $backEnaled, id: $id}';
  }
}

/// generated route for
/// [_i4.HomeBody]
class HomeBody extends _i14.PageRouteInfo<void> {
  const HomeBody() : super(HomeBody.name, path: '');

  static const String name = 'HomeBody';
}

/// generated route for
/// [_i5.CalculatorPage]
class CalculatorRoute extends _i14.PageRouteInfo<void> {
  const CalculatorRoute() : super(CalculatorRoute.name, path: 'calculator');

  static const String name = 'CalculatorRoute';
}

/// generated route for
/// [_i6.QrScanner]
class QrScanner extends _i14.PageRouteInfo<void> {
  const QrScanner() : super(QrScanner.name, path: 'scanner');

  static const String name = 'QrScanner';
}

/// generated route for
/// [_i7.WalletPage]
class WalletRoute extends _i14.PageRouteInfo<void> {
  const WalletRoute() : super(WalletRoute.name, path: 'wallet');

  static const String name = 'WalletRoute';
}

/// generated route for
/// [_i8.WalletTransactionsPage]
class WalletTransactionsRoute
    extends _i14.PageRouteInfo<WalletTransactionsRouteArgs> {
  WalletTransactionsRoute(
      {_i15.Key? key, required _i17.WalletDatum walletDatum})
      : super(WalletTransactionsRoute.name,
            path: 'transactions',
            args: WalletTransactionsRouteArgs(
                key: key, walletDatum: walletDatum));

  static const String name = 'WalletTransactionsRoute';
}

class WalletTransactionsRouteArgs {
  const WalletTransactionsRouteArgs({this.key, required this.walletDatum});

  final _i15.Key? key;

  final _i17.WalletDatum walletDatum;

  @override
  String toString() {
    return 'WalletTransactionsRouteArgs{key: $key, walletDatum: $walletDatum}';
  }
}

/// generated route for
/// [_i9.PoolPage]
class PoolRoute extends _i14.PageRouteInfo<void> {
  const PoolRoute() : super(PoolRoute.name, path: 'pool');

  static const String name = 'PoolRoute';
}

/// generated route for
/// [_i10.ReceiveAssets]
class ReceiveAssets extends _i14.PageRouteInfo<ReceiveAssetsArgs> {
  ReceiveAssets({_i15.Key? key, required _i17.WalletDatum walletDatum})
      : super(ReceiveAssets.name,
            path: 'recieve',
            args: ReceiveAssetsArgs(key: key, walletDatum: walletDatum));

  static const String name = 'ReceiveAssets';
}

class ReceiveAssetsArgs {
  const ReceiveAssetsArgs({this.key, required this.walletDatum});

  final _i15.Key? key;

  final _i17.WalletDatum walletDatum;

  @override
  String toString() {
    return 'ReceiveAssetsArgs{key: $key, walletDatum: $walletDatum}';
  }
}

/// generated route for
/// [_i11.RecieveAssetList]
class RecieveAssetList extends _i14.PageRouteInfo<void> {
  const RecieveAssetList() : super(RecieveAssetList.name, path: 'recieve-list');

  static const String name = 'RecieveAssetList';
}

/// generated route for
/// [_i12.SendAssetList]
class SendAssetList extends _i14.PageRouteInfo<void> {
  const SendAssetList() : super(SendAssetList.name, path: 'send-list');

  static const String name = 'SendAssetList';
}

/// generated route for
/// [_i13.SendAsset]
class SendAsset extends _i14.PageRouteInfo<SendAssetArgs> {
  SendAsset(
      {_i15.Key? key,
      required _i17.WalletDatum assetDatum,
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

  final _i15.Key? key;

  final _i17.WalletDatum assetDatum;

  final String recipientAddress;

  final double amount;

  @override
  String toString() {
    return 'SendAssetArgs{key: $key, assetDatum: $assetDatum, recipientAddress: $recipientAddress, amount: $amount}';
  }
}

/// generated route for
/// [_i6.SendInputScreen]
class SendInputScreen extends _i14.PageRouteInfo<SendInputScreenArgs> {
  SendInputScreen({_i15.Key? key, required _i17.WalletDatum walletDatum})
      : super(SendInputScreen.name,
            path: 'send-input',
            args: SendInputScreenArgs(key: key, walletDatum: walletDatum));

  static const String name = 'SendInputScreen';
}

class SendInputScreenArgs {
  const SendInputScreenArgs({this.key, required this.walletDatum});

  final _i15.Key? key;

  final _i17.WalletDatum walletDatum;

  @override
  String toString() {
    return 'SendInputScreenArgs{key: $key, walletDatum: $walletDatum}';
  }
}
