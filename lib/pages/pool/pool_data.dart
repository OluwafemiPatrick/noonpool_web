// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/models/worker_data/worker_data.dart';
import 'package:noonpool_web/pages/pool/widget/pool_statistics_title.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/error_widget.dart';
import '../../widgets/svg_image.dart';

class PoolPage extends StatefulWidget {
  const PoolPage({Key? key}) : super(key: key);

  @override
  State<PoolPage> createState() => _PoolPageState();
}

class _PoolPageState extends State<PoolPage> {
  bool _isLoading = true;
  bool _hasError = false;

  final StreamController<int> _poolStatisticsStream = StreamController();

  List<String> _poolStatisticsTitles(BuildContext context) => [
        AppLocalizations.of(context)!.general,
        AppLocalizations.of(context)!.midEast
      ];

  WorkerData workerData = WorkerData();
  String coin = 'LTC-DOGE';
  String port1 = '3050';
  String port2 = '3060';
  String miningAdd = 'litecoin.noonpool.com:3050';
  String stratumUrl = 'stratum+tcp://litecoin.noonpool.com:3050';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    final bodyText2 = textTheme.bodyText2!;

    return FocusDetector(
      onFocusGained: () {
        getUserData();
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            buildAppBar(bodyText1, bodyText2),
            Expanded(
              child: buildBody(bodyText2, bodyText1),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody(TextStyle bodyText2, TextStyle bodyText1) {
    const spacer = SizedBox(
      height: kDefaultMargin,
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStatisticsItem(),
          spacer,
          ...buildMiningAddress(bodyText2),
          spacer,
          ...buildSmartMiningUrl(bodyText2),
          spacer,
          buildExtraNote(bodyText2),
          spacer,
          Padding(
            padding: const EdgeInsets.only(
                left: kDefaultMargin, right: kDefaultMargin),
            child: Text(
              '${AppLocalizations.of(context)!.miningProfit} -> ',
              style: bodyText1,
            ),
          ),
          const SizedBox(height: 10.0),
          buildMiningProfitData(bodyText2, spacer),
          spacer,
          Padding(
            padding: const EdgeInsets.only(
                left: kDefaultMargin, right: kDefaultMargin),
            child: Text(
              '${AppLocalizations.of(context)!.hashrateTrend} -> ',
              style: bodyText1,
            ),
          ),
          const SizedBox(height: 10.0),
          buildHashrateTrend(bodyText2, spacer),
          spacer,
          buildStatistics(bodyText1),
          const SizedBox(height: 10.0),
          buildPoolData(bodyText2, spacer),
        ],
      ),
    );
  }

  Container buildMiningProfitData(TextStyle bodyText2, SizedBox spacer) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding, horizontal: kDefaultPadding / 2),
      margin: const EdgeInsets.only(
        left: kDefaultMargin / 2,
        right: kDefaultMargin / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultMargin / 2),
        color: kLightBackgroud,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.estEarning, style: bodyText2),
          const SizedBox(
            height: kDefaultMargin / 4,
          ),
          Text(
            ' ${workerData.data?.estEarnings ?? ''} $coin',
            style:
                bodyText2.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          spacer,
          Text(
            AppLocalizations.of(context)!.cummulativeEarnings,
            style: bodyText2,
          ),
          const SizedBox(
            height: kDefaultMargin / 4,
          ),
          Text(
            ' ${workerData.data?.cumEarnings ?? ''} $coin',
            style:
                bodyText2.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Container buildHashrateTrend(TextStyle bodyText2, SizedBox spacer) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding, horizontal: kDefaultPadding),
      margin: const EdgeInsets.only(
        left: kDefaultMargin / 2,
        right: kDefaultMargin / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultMargin / 2),
        color: kLightBackgroud,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Text(AppLocalizations.of(context)!.h10Min, style: bodyText2),
              const SizedBox(
                height: kDefaultMargin / 4,
              ),
              Text(
                '${workerData.data?.hash10min ?? ''} H/s',
                style: bodyText2.copyWith(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            children: [
              Text(AppLocalizations.of(context)!.h1Hour, style: bodyText2),
              const SizedBox(
                height: kDefaultMargin / 4,
              ),
              Text(
                '${workerData.data?.hash1hr ?? ''} H/s',
                style: bodyText2.copyWith(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                AppLocalizations.of(context)!.h1Day,
                style: bodyText2,
              ),
              const SizedBox(
                height: kDefaultMargin / 4,
              ),
              Text(
                '${workerData.data?.hash1day ?? ''} H/s',
                style: bodyText2.copyWith(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(TextStyle? bodyText1, TextStyle bodyText2) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: null,
      actions: [
        Container(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(kDefaultMargin / 4),
            decoration: BoxDecoration(
              color: kLightBackgroud,
              borderRadius: BorderRadius.circular(kDefaultMargin / 2),
            ),
            child: Row(children: [
              const SizedBox(width: kDefaultMargin),
              Text(coin, style: bodyText2),
              dropDown(bodyText2),
            ]),
          ),
        ),
        const SizedBox(
          width: kDefaultMargin / 2,
        )
      ],
    );
  }

  Widget dropDown(TextStyle bodyText2) {
    List<String> coinList = ['LTC-DOGE', 'BCH', 'BTC'];
    String? selected;
    return SizedBox(
      height: 30,
      child: DropdownButton<String>(
        underline: Container(),
        itemHeight: null,
        value: selected,
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
          color: kPrimaryColor,
        ),
        items: coinList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: bodyText2,
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          selected = newValue.toString();
          if (selected == 'LTC-DOGE') {
            setState(() {
              workerData = WorkerData();
              coin = selected!;
              port1 = '3050';
              port2 = '3060';
              miningAdd = 'litecoin.noonpool.com:3050';
              stratumUrl = 'stratum+tcp://litecoin.noonpool.com:3050';
            });
            getUserData();
          }
          if (selected == 'BTC') {
            setState(() {
              workerData = WorkerData();
              coin = selected!;
              port1 = '3055';
              port2 = '0';
              //miningAdd = AppLocalizations.of(context)!.coinNotAvailable;
              //stratumUrl = AppLocalizations.of(context)!.coinNotAvailable;
              miningAdd = 'litecoin.noonpool.com:3055';
              stratumUrl = 'stratum+tcp://litecoin.noonpool.com:3055';
            });
            getUserData();
          }
          if (selected == 'BCH') {
            setState(() {
              workerData = WorkerData();
              coin = selected!;
              port1 = '3030';
              port2 = '3040';
              miningAdd = 'bitcoincash.noonpool.com:3030';
              stratumUrl = 'stratum+tcp://bitcoincash.noonpool.com:3030';
            });
            getUserData();
          }
        },
      ),
    );
  }

  void onPoolStatisticsTitleClicked(int position) {
    _poolStatisticsStream.add(position);
    //todo work on changing data
  }

  Padding buildStatisticsItem() {
    return Padding(
      padding:
          const EdgeInsets.only(left: kDefaultMargin, right: kDefaultMargin),
      child: PoolStatisticsTitle(
          titles: _poolStatisticsTitles(context),
          onTitleClicked: onPoolStatisticsTitleClicked,
          positionStream: _poolStatisticsStream.stream),
    );
  }

  List<Widget> buildMiningAddress(TextStyle bodyText2) {
    return [
      Padding(
        padding:
            const EdgeInsets.only(left: kDefaultMargin, right: kDefaultMargin),
        child: Text(
          '$coin ${AppLocalizations.of(context)!.miningAddress}',
          style: bodyText2.copyWith(color: kLightText),
        ),
      ),
      const SizedBox(height: kDefaultMargin / 4),
      Padding(
        padding:
            const EdgeInsets.only(left: kDefaultMargin, right: kDefaultMargin),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  miningAdd,
                  style: bodyText2.copyWith(fontSize: 14),
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.copy_rounded,
                  color: kPrimaryColor,
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: miningAdd)).then((_) {
                    MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
                        SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .addressCopiedToClipboard)));
                  });
                },
              ),
            ]),
      ),
    ];
  }

  List<Widget> buildSmartMiningUrl(TextStyle bodyText2) {
    return [
      Padding(
        padding:
            const EdgeInsets.only(left: kDefaultMargin, right: kDefaultMargin),
        child: Text(
          AppLocalizations.of(context)!.smartMintingUrl,
          style: bodyText2.copyWith(color: kLightText),
        ),
      ),
      const SizedBox(
        height: kDefaultMargin / 4,
      ),
      Padding(
        padding:
            const EdgeInsets.only(left: kDefaultMargin, right: kDefaultMargin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                stratumUrl,
                style: bodyText2.copyWith(fontSize: 14),
              ),
            ),
            GestureDetector(
              child: const Icon(
                Icons.copy_rounded,
                color: kPrimaryColor,
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: stratumUrl)).then((_) {
                  MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .addressCopiedToClipboard)));
                });
              },
            ),
          ],
        ),
      ),
    ];
  }

  Padding buildExtraNote(TextStyle bodyText2) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kDefaultMargin, right: kDefaultMargin),
      child: Text(
        'Note. Port $port2 is also available.',
        style: bodyText2.copyWith(color: kLightText),
      ),
    );
  }

  Padding buildStatistics(
    TextStyle bodyText1,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kDefaultMargin, right: kDefaultMargin),
      child: Text(
        '${AppLocalizations.of(context)!.statistics} -> ${AppPreferences.userName}',
        style: bodyText1,
      ),
    );
  }

  Container buildPoolData(TextStyle bodyText2, SizedBox spacer) {
    final style1 =
        bodyText2.copyWith(fontSize: 15, fontWeight: FontWeight.w500);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      margin: const EdgeInsets.only(
          left: kDefaultMargin / 2, right: kDefaultMargin / 2, bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultMargin / 2),
        color: kLightBackgroud,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Text(AppLocalizations.of(context)!.allMiners,
                        style: bodyText2),
                    const SizedBox(
                      height: kDefaultMargin / 4,
                    ),
                    Text(
                      workerData.data?.minersAll?.toString() ?? '0',
                      style: style1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.activeMiners,
                      style: bodyText2,
                    ),
                    const SizedBox(
                      height: kDefaultMargin / 4,
                    ),
                    Text(
                      workerData.data?.minersActive?.toString() ?? '0',
                      style: style1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(AppLocalizations.of(context)!.paidEarnings,
                        style: bodyText2),
                    const SizedBox(
                      height: kDefaultMargin / 4,
                    ),
                    Text(
                      workerData.data?.earningsPaid?.toString() ?? '0',
                      style: style1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacer,
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultMargin / 2, horizontal: kDefaultMargin / 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.workerid,
                    style: bodyText2,
                  ),
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.hashrate,
                    style: bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.estEarning,
                    style: bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.stat,
                    style: bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          if (_isLoading)
            buildLoadingBody()
          else if (_hasError)
            buildErrorWidget()
          else if (workerData.data?.subWorkers?.isNotEmpty == true)
            buildSubWorkersData()
          else
            noWorkerData(bodyText2)
        ],
      ),
    );
  }

  Widget buildErrorWidget() {
    return Container(
      alignment: Alignment.center,
      height: 500.0,
      child: CustomErrorWidget(
          error: AppLocalizations.of(context)!
              .anErrorOccurredWithTheDataFetchPleaseTryAgain,
          onRefresh: () {
            getUserData();
          }),
    );
  }

  ListView buildSubWorkersData() {
    return ListView.builder(
      itemCount: workerData.data?.subWorkers?.length ?? 0,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final item = workerData.data?.subWorkers?[index];
        debugPrint(item.toString());
        return _PoolDataWidget(
          workerId: item?.workerId ?? '',
          hashrate: item?.hashrate ?? 0,
          estEarnings: item?.estEarning ?? 0,
          stat: item?.stat ?? '',
        );
      },
    );
  }

  ListView buildLoadingBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return const _PoolDataWidget(
          workerId: '',
          hashrate: 0,
          estEarnings: 0,
          stat: '',
          shimmerEnabled: true,
        );
      },
    );
  }

  Widget noWorkerData(TextStyle bodyText2) {
    return Container(
      alignment: Alignment.center,
      height: 250.0,
      child: Column(
        children: [
          const Spacer(),
          const SvgImage(
            iconLocation: 'assets/icons/no_worker_data.svg',
            name: 'no worker data',
            color: kPrimaryColor,
            size: 100,
          ),
          const SizedBox(
            height: kDefaultMargin / 2,
          ),
          Text(
            AppLocalizations.of(context)!.noWorkerData,
            style: bodyText2,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  getUserData() async {
    _isLoading = true;

    try {
      workerData = await fetchWorkerData(coin);
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
    _isLoading = false;
    setState(() {});
  }
}

class _PoolDataWidget extends StatelessWidget {
  final int hashrate;
  final String workerId;
  final double estEarnings;
  final String stat;
  final bool shimmerEnabled;
  const _PoolDataWidget({
    Key? key,
    this.shimmerEnabled = false,
    required this.workerId,
    required this.hashrate,
    required this.estEarnings,
    required this.stat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shimmerEnabled
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            child: shimmerBody(),
          )
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2!;
    String _workerId;

    // format worker_id into proper name
    final split = workerId.split('.');
    if (split.length == 2) {
      var s1 = split[1];
      _workerId = s1;
    } else if (split.length == 3) {
      var s1 = split[1];
      var s2 = split[2];
      _workerId = "$s1.$s2";
    } else {
      _workerId = workerId;
    }

    // remove decimal figures from hashrate

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(kDefaultMargin / 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _workerId,
              style: bodyText2,
            ),
          ),
          Expanded(
            child: Text(
              getHashrate(),
              style: bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              estEarnings.toStringAsFixed(6).toString(),
              style: bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              stat,
              style: bodyText2.copyWith(
                color: stat.toLowerCase().trim() == 'active'
                    ? Colors.green
                    : stat.toLowerCase().trim() == 'inactive'
                        ? Colors.red
                        : bodyText2.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerBody() {
    return Container(
      padding: const EdgeInsets.all(kDefaultMargin / 2),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 20,
              color: kPrimaryColor,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 20,
              color: kPrimaryColor,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 20,
              color: kPrimaryColor,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 20,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String getHashrate() {
    debugPrint(hashrate.toString());
    String hashrateAsString = '';
    var diffLength = hashrate.toStringAsFixed(0).length;
    int mod = diffLength % 3;

    String digit_1 = hashrate.toString()[0];
    String digit_2 =
        hashrate.toString().length < 2 ? '0' : hashrate.toString()[1];
    String digit_3 =
        hashrate.toString().length < 3 ? '0' : hashrate.toString()[2];

    if (diffLength <= 3) {
      if (mod == 0) {
        hashrateAsString = "$digit_1$digit_2$digit_3 H/s";
      } else if (mod == 1) {
        hashrateAsString = "$digit_1.$digit_2$digit_3 H/s";
      } else {
        hashrateAsString = "$digit_1$digit_2.$digit_3 H/s";
      }
    }
    if (diffLength > 3 && diffLength <= 6) {
      if (mod == 0) {
        hashrateAsString = "$digit_1$digit_2$digit_3 KH/s";
      } else if (mod == 1) {
        hashrateAsString = "$digit_1.$digit_2$digit_3 KH/s";
      } else {
        hashrateAsString = "$digit_1$digit_2.$digit_3 KH/s";
      }
    }
    if (diffLength > 6 && diffLength <= 9) {
      if (mod == 0) {
        hashrateAsString = "$digit_1$digit_2$digit_3 MH/s";
      } else if (mod == 1) {
        hashrateAsString = "$digit_1.$digit_2$digit_3 MH/s";
      } else {
        hashrateAsString = "$digit_1$digit_2.$digit_3 MH/s";
      }
    }
    if (diffLength > 9 && diffLength <= 12) {
      if (mod == 0) {
        hashrateAsString = "$digit_1$digit_2$digit_3 GH/s";
      } else if (mod == 1) {
        hashrateAsString = "$digit_1.$digit_2$digit_3 GH/s";
      } else {
        hashrateAsString = "$digit_1$digit_2.$digit_3 GH/s";
      }
    }
    if (diffLength > 12 && diffLength <= 15) {
      if (mod == 0) {
        hashrateAsString = "$digit_1$digit_2$digit_3 TH/s";
      } else if (mod == 1) {
        hashrateAsString = "$digit_1.$digit_2$digit_3 TH/s";
      } else {
        hashrateAsString = "$digit_1$digit_2.$digit_3 TH/s";
      }
    }
    if (diffLength > 15 && diffLength <= 18) {
      if (mod == 0) {
        hashrateAsString = "$digit_1$digit_2$digit_3 PH/s";
      } else if (mod == 1) {
        hashrateAsString = "$digit_1.$digit_2$digit_3 PH/s";
      } else {
        hashrateAsString = "$digit_1$digit_2.$digit_3 PH/s";
      }
    }
    if (diffLength > 18 && diffLength <= 21) {
      if (mod == 0) {
        hashrateAsString = "$digit_1$digit_2$digit_3 EH/s";
      } else if (mod == 1) {
        hashrateAsString = "$digit_1.$digit_2$digit_3 EH/s";
      } else {
        hashrateAsString = "$digit_1$digit_2.$digit_3 EH/s";
      }
    }
    return hashrateAsString;
  }
}
