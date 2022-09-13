import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noonpool_web/constants/style.dart';
import 'package:noonpool_web/widgets/svg_image.dart';

class HomeFooter1 extends StatelessWidget {
  final List<Map<String, String>> viewPagerData = [
    {
      'image': "assets/icons/ brand_strength.svg",
      'title': "Brand Strength",
      'text':
          "World-leading BTC/BCH/LTC mining pools\nGlobal services in 130+ countries/regions\nCoverage of nearly 1 million users worldwide\nMulti-billion dollar worth of cumulative mining output value",
    },
    {
      'image': "assets/icons/security_and_stability.svg",
      'title': "Security and Stability",
      'text':
          "High-standard, multi-level risk control system\nNodes deployed all over the world with low latency\n24/7 secure and stable mining network available",
    },
    {
      'image': "assets/icons/leading_revenue.svg",
      'title': "Leading Revenue",
      'text':
          "PPS+, PPLNS and SOLO are supported\nLowest orphan rate in the network",
    },
  ];
  HomeFooter1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1;
    final bodyText2 = textTheme.bodyText2;

    return Container(
      padding:
          const EdgeInsets.only(left: kDefaultMargin, right: kDefaultMargin),
      child: Column(
        children: [
          Text(
            'Why Choose NOONPOOL',
            style:
                bodyText1?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(
            height: kDefaultMargin / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: viewPagerData
                .map(
                  (data) => Expanded(
                    child: Container(
                      height: 250,
                      margin: const EdgeInsets.symmetric(
                          horizontal: kDefaultMargin),
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(kDefaultMargin / 2),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              data['image'] ?? '',
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(
                              height: kDefaultMargin / 2,
                            ),
                            Text(
                              data['title'] ?? '',
                              textAlign: TextAlign.center,
                              style: bodyText2?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  data['text'] ?? '',
                                  style: bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
