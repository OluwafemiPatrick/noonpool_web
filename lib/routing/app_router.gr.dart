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
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../models/wallet_data/datum.dart' as _i15;
import '../pages/calculator/calculator_page.dart' as _i10;
import '../pages/home/home_page.dart' as _i1;
import '../pages/home/home_page_body.dart' as _i9;
import '../pages/otp/otp_screen.dart' as _i2;
import '../pages/otp/verify_otp.dart' as _i3;
import '../pages/recieve_assets/receive_asset.dart' as _i4;
import '../pages/recieve_assets/recieve_asset_list.dart' as _i5;
import '../pages/send_assets/send_asset.dart' as _i7;
import '../pages/send_assets/send_asset_list.dart' as _i6;
import '../pages/send_assets/send_input.dart' as _i8;
import '../pages/transactions/wallet_transaction_screen.dart' as _i12;
import '../pages/wallet/wallet_page.dart' as _i11;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    OtpRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.OtpPage());
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.VerifyOtpPage(
              key: args.key,
              onNext: args.onNext,
              backEnaled: args.backEnaled,
              id: args.id));
    },
    ReceiveAssets.name: (routeData) {
      final args = routeData.argsAs<ReceiveAssetsArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i4.ReceiveAssets(key: args.key, walletDatum: args.walletDatum));
    },
    RecieveAssetList.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.RecieveAssetList());
    },
    SendAssetList.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.SendAssetList());
    },
    SendAsset.name: (routeData) {
      final args = routeData.argsAs<SendAssetArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.SendAsset(
              key: args.key,
              assetDatum: args.assetDatum,
              recipientAddress: args.recipientAddress,
              amount: args.amount));
    },
    SendInputScreen.name: (routeData) {
      final args = routeData.argsAs<SendInputScreenArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.SendInputScreen(
              key: args.key, walletDatum: args.walletDatum));
    },
    HomeBody.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.HomeBody());
    },
    CalculatorRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.CalculatorPage());
    },
    WalletRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.WalletPage());
    },
    WalletTransactionsTab.name: (routeData) {
      final args = routeData.argsAs<WalletTransactionsTabArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.WalletTransactionsTab(
              key: args.key, walletDatum: args.walletDatum));
    }
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(HomeRoute.name, path: '/', children: [
          _i13.RouteConfig(HomeBody.name, path: '', parent: HomeRoute.name),
          _i13.RouteConfig(CalculatorRoute.name,
              path: 'calculator', parent: HomeRoute.name),
          _i13.RouteConfig(WalletRoute.name,
              path: 'wallet', parent: HomeRoute.name),
          _i13.RouteConfig(WalletTransactionsTab.name,
              path: 'transactions', parent: HomeRoute.name)
        ]),
        _i13.RouteConfig(OtpRoute.name, path: 'otp'),
        _i13.RouteConfig(VerifyOtpRoute.name, path: 'verify-otp'),
        _i13.RouteConfig(ReceiveAssets.name, path: 'recieve'),
        _i13.RouteConfig(RecieveAssetList.name, path: 'recieve-list'),
        _i13.RouteConfig(SendAssetList.name, path: 'send-list'),
        _i13.RouteConfig(SendAsset.name, path: 'send'),
        _i13.RouteConfig(SendInputScreen.name, path: 'send-input')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.OtpPage]
class OtpRoute extends _i13.PageRouteInfo<void> {
  const OtpRoute() : super(OtpRoute.name, path: 'otp');

  static const String name = 'OtpRoute';
}

/// generated route for
/// [_i3.VerifyOtpPage]
class VerifyOtpRoute extends _i13.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute(
      {_i14.Key? key,
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

  final _i14.Key? key;

  final dynamic Function(String) onNext;

  final bool backEnaled;

  final String id;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, onNext: $onNext, backEnaled: $backEnaled, id: $id}';
  }
}

/// generated route for
/// [_i4.ReceiveAssets]
class ReceiveAssets extends _i13.PageRouteInfo<ReceiveAssetsArgs> {
  ReceiveAssets({_i14.Key? key, required _i15.WalletDatum walletDatum})
      : super(ReceiveAssets.name,
            path: 'recieve',
            args: ReceiveAssetsArgs(key: key, walletDatum: walletDatum));

  static const String name = 'ReceiveAssets';
}

class ReceiveAssetsArgs {
  const ReceiveAssetsArgs({this.key, required this.walletDatum});

  final _i14.Key? key;

  final _i15.WalletDatum walletDatum;

  @override
  String toString() {
    return 'ReceiveAssetsArgs{key: $key, walletDatum: $walletDatum}';
  }
}

/// generated route for
/// [_i5.RecieveAssetList]
class RecieveAssetList extends _i13.PageRouteInfo<void> {
  const RecieveAssetList() : super(RecieveAssetList.name, path: 'recieve-list');

  static const String name = 'RecieveAssetList';
}

/// generated route for
/// [_i6.SendAssetList]
class SendAssetList extends _i13.PageRouteInfo<void> {
  const SendAssetList() : super(SendAssetList.name, path: 'send-list');

  static const String name = 'SendAssetList';
}

/// generated route for
/// [_i7.SendAsset]
class SendAsset extends _i13.PageRouteInfo<SendAssetArgs> {
  SendAsset(
      {_i14.Key? key,
      required _i15.WalletDatum assetDatum,
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

  final _i14.Key? key;

  final _i15.WalletDatum assetDatum;

  final String recipientAddress;

  final double amount;

  @override
  String toString() {
    return 'SendAssetArgs{key: $key, assetDatum: $assetDatum, recipientAddress: $recipientAddress, amount: $amount}';
  }
}

/// generated route for
/// [_i8.SendInputScreen]
class SendInputScreen extends _i13.PageRouteInfo<SendInputScreenArgs> {
  SendInputScreen({_i14.Key? key, required _i15.WalletDatum walletDatum})
      : super(SendInputScreen.name,
            path: 'send-input',
            args: SendInputScreenArgs(key: key, walletDatum: walletDatum));

  static const String name = 'SendInputScreen';
}

class SendInputScreenArgs {
  const SendInputScreenArgs({this.key, required this.walletDatum});

  final _i14.Key? key;

  final _i15.WalletDatum walletDatum;

  @override
  String toString() {
    return 'SendInputScreenArgs{key: $key, walletDatum: $walletDatum}';
  }
}

/// generated route for
/// [_i9.HomeBody]
class HomeBody extends _i13.PageRouteInfo<void> {
  const HomeBody() : super(HomeBody.name, path: '');

  static const String name = 'HomeBody';
}

/// generated route for
/// [_i10.CalculatorPage]
class CalculatorRoute extends _i13.PageRouteInfo<void> {
  const CalculatorRoute() : super(CalculatorRoute.name, path: 'calculator');

  static const String name = 'CalculatorRoute';
}

/// generated route for
/// [_i11.WalletPage]
class WalletRoute extends _i13.PageRouteInfo<void> {
  const WalletRoute() : super(WalletRoute.name, path: 'wallet');

  static const String name = 'WalletRoute';
}

/// generated route for
/// [_i12.WalletTransactionsTab]
class WalletTransactionsTab
    extends _i13.PageRouteInfo<WalletTransactionsTabArgs> {
  WalletTransactionsTab({_i14.Key? key, required _i15.WalletDatum walletDatum})
      : super(WalletTransactionsTab.name,
            path: 'transactions',
            args:
                WalletTransactionsTabArgs(key: key, walletDatum: walletDatum));

  static const String name = 'WalletTransactionsTab';
}

class WalletTransactionsTabArgs {
  const WalletTransactionsTabArgs({this.key, required this.walletDatum});

  final _i14.Key? key;

  final _i15.WalletDatum walletDatum;

  @override
  String toString() {
    return 'WalletTransactionsTabArgs{key: $key, walletDatum: $walletDatum}';
  }
}
