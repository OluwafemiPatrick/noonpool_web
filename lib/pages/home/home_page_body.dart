import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/helpers/network_helper.dart';
import 'package:noonpool_web/main.dart';
import 'package:noonpool_web/models/coin_model/coin_model.dart';
import 'package:noonpool_web/pages/home/widget/home_coin_item.dart';
import 'package:noonpool_web/widgets/error_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _isLoading = true;
  bool _hasError = false;
  final List<CoinModel> allCoinData = [];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!;
    final bodyText2 = textTheme.bodyText2!;
    final lightText = bodyText2.copyWith(color: kLightText);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          buildRow2(bodyText1, lightText),
          Expanded(
            child: _isLoading
                ? buildLoadingBody()
                : _hasError
                    ? Center(
                        child: CustomErrorWidget(
                            error:
                                "An error occurred with the data fetch, please try again",
                            onRefresh: () {
                              getData();
                            }),
                      )
                    : buildBody(),
          ),
        ],
      ),
    );
  }

  ListView buildBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
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
      _hasError = true;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }
}
