import 'package:flutter/material.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/pages/home/widget/home_header_item.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
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
            width: double.infinity,
            height: 130,
            child: Row(
              children: viewPagerData
                  .map(
                    (data) => HomeHeaderItem(
                        title: data['title'] ?? '',
                        imageLocation: data['image'] ?? ''),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
