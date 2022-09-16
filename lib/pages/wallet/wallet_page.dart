import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/models/wallet_data/datum.dart';
import 'package:noonpool_web/models/wallet_data/wallet_data.dart';
import 'package:noonpool_web/routing/app_router.gr.dart';
import 'package:noonpool_web/widgets/error_widget.dart';
import 'package:noonpool_web/widgets/login_needed_widget.dart';
import 'package:noonpool_web/widgets/outlined_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginNeededWidget(
      child: _WalletPage(),
    );
  }
}

class _WalletPage extends StatefulWidget {
  const _WalletPage({Key? key}) : super(key: key);

  @override
  State<_WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<_WalletPage> {
  bool _isLoading = true;
  bool _hasError = false;
  WalletData walletData = WalletData();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }

  getData() async {
    debugPrint(AppPreferences.userId);
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      walletData = await getWalletData();
      _hasError = false;
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    final bodyText2 = textTheme.bodyText2!;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.estAmount} (USD)',
                        style: bodyText2.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            getBalance().toString(),
                            style: bodyText1.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 200,
                  child: Column(children: [
                    CustomOutlinedButton(
                      padding: const EdgeInsets.only(
                        left: kDefaultMargin / 4,
                        right: kDefaultMargin / 4,
                        top: 0,
                        bottom: 0,
                      ),
                      onPressed: () {
                        context.router.push(const RecieveAssetList());
                      },
                      widget: Text(
                        AppLocalizations.of(context)!.receive,
                        style: bodyText2.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomOutlinedButton(
                      padding: const EdgeInsets.only(
                        left: kDefaultMargin / 4,
                        right: kDefaultMargin / 4,
                        top: 0,
                        bottom: 0,
                      ),
                      onPressed: () {
                        context.router.push(const SendAssetList());
                      },
                      widget: Text(
                        AppLocalizations.of(context)!.send,
                        style: bodyText2.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: _isLoading
                  ? buildLoadingBody()
                  : _hasError
                      ? CustomErrorWidget(
                          error: AppLocalizations.of(context)!
                              .anErrorOccurredWithTheDataFetchPleaseTryAgain,
                          onRefresh: () {
                            getData();
                          })
                      : buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  double getBalance() {
    final walletDatum = walletData.data ?? [];
    double amount = 0;

    for (final e in walletDatum) {
      amount += (e.balance ?? 0);
    }
    return amount;
  }

  ListView buildBody() {
    final walletDatum = walletData.data ?? [];
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(0),
      itemCount: walletDatum.length,
      itemBuilder: (ctx, index) {
        return CoinShow(
          data: walletDatum[index],
          onPressed: () {
            final acceptedCoins = ['btc', 'ltc', 'doge', 'bch'];
            if (acceptedCoins
                .contains(walletDatum[index].coinSymbol?.toLowerCase())) {
              context.router.push(
                  WalletTransactionsRoute(walletDatum: walletDatum[index]));
            } else {
              MyApp.scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                  content: Text(
                      "${walletDatum[index].coinName} ${AppLocalizations.of(context)!.isCurrentlyUnavailaleWeWouldNotifyYouOnceItIsAvailiable}")));
            }
          },
        );
      },
    );
  }

  ListView buildLoadingBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return CoinShow(
          data: WalletDatum(),
          shimmerEnabled: true,
          onPressed: () {},
        );
      },
    );
  }
}

class CoinShow extends StatelessWidget {
  final WalletDatum data;
  final VoidCallback onPressed;
  final bool shimmerEnabled;
  const CoinShow({
    Key? key,
    required this.data,
    required this.onPressed,
    this.shimmerEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shimmerEnabled
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            child: shimmerBody(),
          )
        : InkWell(
            splashColor: Colors.transparent,
            onTap: onPressed,
            child: buildBody(context),
          );
  }

  Container shimmerBody() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 20,
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 20,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final titleStyle = textTheme.bodyText1;
    final subTitleStyle = textTheme.bodyText2;
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0, top: 12.0),
      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                data.imageUrl ?? '',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            data.coinName?.trim() ?? '',
                            style: titleStyle,
                          ),
                          Text(
                            (data.balance ?? 0).toString(),
                            style: subTitleStyle,
                          ),
                        ]),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.frozen}: ${data.frozen}",
                            style: subTitleStyle,
                          ),
                          const Spacer(),
                          Text(
                            "\$ ${data.usdPrice ?? 0}",
                            style: subTitleStyle,
                          ),
                        ]),
                  ]),
            ),
          ]),
    );
  }
}
