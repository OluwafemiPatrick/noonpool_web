import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:noonpool_web/pages/calculator/calculator_page.dart';
import 'package:noonpool_web/pages/home/home_page.dart';
import 'package:noonpool_web/pages/home/home_page_body.dart';
import 'package:noonpool_web/pages/otp/otp_screen.dart';
import 'package:noonpool_web/pages/otp/verify_otp.dart';
import 'package:noonpool_web/pages/pool/pool_data.dart';
import 'package:noonpool_web/pages/recieve_assets/receive_asset.dart';
import 'package:noonpool_web/pages/recieve_assets/recieve_asset_list.dart';
import 'package:noonpool_web/pages/send_assets/send_asset.dart';
import 'package:noonpool_web/pages/send_assets/send_asset_list.dart';
import 'package:noonpool_web/pages/send_assets/send_input.dart';
import 'package:noonpool_web/pages/transactions/wallet_transaction_screen.dart';
import 'package:noonpool_web/pages/wallet/wallet_page.dart';

Route<T> fadePageBuilder<T>(
    BuildContext context, Widget child, CustomPage page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 600),
    settings: page,
    pageBuilder: (_, __, ___) => child,
    transitionsBuilder: (_, anim1, __, child) => FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(anim1),
      child: child,
    ),
  );
}

@CustomAutoRouter(
  customRouteBuilder: fadePageBuilder,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      initial: true,
      children: [
        AutoRoute(
          page: HomeBody,
          initial: true,
        ),
        AutoRoute(
          page: CalculatorPage,
          path: 'calculator',
        ),
        AutoRoute(
          page: QrScanner,
          path: 'scanner',
        ),
        AutoRoute(
          page: WalletPage,
          path: 'wallet',
        ),
        AutoRoute(
          page: WalletTransactionsPage,
          path: 'transactions',
        ),
        AutoRoute(
          page: PoolPage,
          path: 'pool',
        ),
        AutoRoute(
          page: ReceiveAssets,
          path: 'recieve',
        ),
        AutoRoute(
          page: RecieveAssetList,
          path: 'recieve-list',
        ),
        AutoRoute(
          page: SendAssetList,
          path: 'send-list',
        ),
        AutoRoute(
          page: SendAsset,
          path: 'send',
        ),
        AutoRoute(
          page: SendInputScreen,
          path: 'send-input',
        ),
      ],
    ),
    AutoRoute(
      page: OtpPage,
      path: 'otp',
    ),
    AutoRoute(
      page: VerifyOtpPage,
      path: 'verify-otp',
    ),
  ],
)
class $AppRouter {}
