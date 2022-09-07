import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/models/coin_model/coin_model.dart';
import 'package:noonpool_web/pages/home/widget/home_coin_item.dart';
import 'package:noonpool_web/pages/home/widget/home_header_item.dart';
import 'package:noonpool_web/widgets/error_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _isLoading = true;
  bool _hasError = false;
  final List<CoinModel> allCoinData = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }

  getData() async {
    allCoinData.clear();
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final data = await getAllCoinDetails();
      allCoinData.addAll(data);
    } catch (exception) {
      MyApp.scaffoldMessengerKey.currentState
          ?.showSnackBar(SnackBar(content: Text(exception.toString())));
      _hasError = false;
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
    final lightText = bodyText2.copyWith(color: kLightText);
    const spacer = SizedBox(
      height: kDefaultMargin / 1,
    );

    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        header: const WaterDropHeader(waterDropColor: kPrimaryColor),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildAppBar(bodyText1),
              const _HomeHeader(),
              spacer,
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      margin: const EdgeInsets.only(bottom: kDefaultMargin),
                      child: buildRow2(bodyText1, lightText),
                    ),
                    _isLoading
                        ? buildLoadingBody()
                        : _hasError
                            ? SizedBox(
                                height: 500,
                                child: CustomErrorWidget(
                                    error:
                                        "An error occurred with the data fetch, please try again",
                                    onRefresh: () {
                                      getData();
                                    }),
                              )
                            : buildBody(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView buildBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: allCoinData.length,
      itemBuilder: (ctx, index) {
        return HomeCoinItem(
          coinModel: allCoinData[index],
        );
      },
    );
  }

  ListView buildLoadingBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return HomeCoinItem(
          shimmerEnabled: true,
          coinModel: CoinModel(),
        );
      },
    );
  }

  Row buildRow2(TextStyle bodyText1, TextStyle lightText) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Coin",
                  style: bodyText1,
                ),
                Text(
                  "Algorithm",
                  style: lightText,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Price",
                  style: bodyText1,
                ),
                Text(
                  "Mining Profit",
                  style: lightText,
                ),
              ],
            ),
          ),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                "Difficulty",
                style: bodyText1,
              ),
              Text(
                "Network Hashrate",
                style: lightText,
              ),
            ]),
          ),
        ]);
  }

  AppBar buildAppBar(TextStyle? bodyText1) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        AppPreferences.userName,
        style: bodyText1!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration.zero, getData).then((value) {
      _refreshController.refreshCompleted();
    });
  }
}

class _HomeHeader extends StatefulWidget {
  const _HomeHeader({Key? key}) : super(key: key);

  @override
  State<_HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<_HomeHeader> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> viewPagerData = [
      {
        'image': 'assets/onboarding/onboarding_1.svg',
        'title': "View mining profits at a glance",
      },
      {
        'title': "Built in cryptocurrency wallet for managing assets",
        'image': 'assets/onboarding/onboarding_2.svg'
      },
      {
        'title': "24/7 stable and secure mining network",
        'image': 'assets/onboarding/onboarding_3.svg'
      },
    ];
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!.copyWith(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    final bodyText2 = textTheme.bodyText2!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
    return Container(
      padding: const EdgeInsets.only(
          left: kDefaultMargin / 2,
          right: kDefaultMargin / 2,
          top: kDefaultMargin * 2,
          bottom: kDefaultMargin * 2),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/header_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Pool the World Together by Providing the Best Minning Service',
            style: bodyText1,
          ),
          const SizedBox(
            height: kDefaultMargin / 4,
          ),
          Text(
            'Noonpool, Mining Safe',
            style: bodyText2,
          ),
          const SizedBox(
            height: kDefaultMargin / 2,
          ),
          SizedBox(
            width: width,
            height: 130,
            child: Row(
              children: viewPagerData
                  .map((data) => HomeHeaderItem(
                      title: data['title'] ?? '',
                      imageLocation: data['image'] ?? ''))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
