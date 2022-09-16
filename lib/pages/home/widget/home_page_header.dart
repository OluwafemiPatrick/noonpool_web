import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/pages/home/widget/home_header_item.dart';

class HomeHeaderLarge extends StatefulWidget {
  const HomeHeaderLarge({Key? key}) : super(key: key);

  @override
  State<HomeHeaderLarge> createState() => _HomeHeaderLargeState();
}

class _HomeHeaderLargeState extends State<HomeHeaderLarge> {
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
  @override
  Widget build(BuildContext context) {
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultMargin / 2),
        image: const DecorationImage(
          image: AssetImage('assets/images/header_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Noonpool, Mining Safe',
            style: bodyText1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: kDefaultMargin / 4,
          ),
          Text(
            'Pool the World Together by Providing the Best Minning Service',
            style: bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: kDefaultMargin / 2,
          ),
          SizedBox(
            width: double.infinity,
            height: 130,
            child: Row(
              children: viewPagerData
                  .map(
                    (data) => Expanded(
                      child: HomeHeaderItem(
                          title: data['title'] ?? '',
                          imageLocation: data['image'] ?? ''),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeHeaderSmall extends StatefulWidget {
  const HomeHeaderSmall({Key? key}) : super(key: key);

  @override
  State<HomeHeaderSmall> createState() => _HomeHeaderSmallState();
}

class _HomeHeaderSmallState extends State<HomeHeaderSmall> {
  Timer? _timer;
  final PageController _pageController = PageController();
  final duration = const Duration(seconds: 4);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      updateCurrentPage();
    });
  }

  void updateCurrentPage() {
    var length = 3;
    var page = _pageController.page;
    if (page == null) {
      return;
    }

    if (page == length - 1) {
      _pageController.animateToPage(0,
          duration: duration, curve: Curves.bounceInOut);
    } else {
      _pageController.animateToPage(page.toInt() + 1,
          duration: duration, curve: Curves.bounceInOut);
    }
  }

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

  @override
  Widget build(BuildContext context) {
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultMargin / 2),
        image: const DecorationImage(
          image: AssetImage('assets/images/header_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Noonpool, Mining Safe',
            style: bodyText1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: kDefaultMargin / 4,
          ),
          Text(
            'Pool the World Together by Providing the Best Minning Service',
            style: bodyText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: kDefaultMargin / 2,
          ),
          SizedBox(
            width: width,
            height: 130,
            child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: viewPagerData.length,
                itemBuilder: (context, index) {
                  final String title = (viewPagerData[index])['title'] ?? '';
                  final String imageLocation =
                      (viewPagerData[index])['image'] ?? '';
                  return HomeHeaderItem(
                      title: title, imageLocation: imageLocation);
                }),
          ),
        ],
      ),
    );
  }
}
