import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noonpool_web/constants/style.dart';

class HomeHeaderItem extends StatelessWidget {
  final String title;
  final String imageLocation;
  const HomeHeaderItem(
      {Key? key, required this.title, required this.imageLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText1!.copyWith(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 5, right: 5),
      height: double.infinity,
      padding: const EdgeInsets.all(kDefaultMargin / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: kBackgroundColor2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              title,
              style: bodyText2,
            ),
          ),
          const SizedBox(
            width: kDefaultMargin / 4,
          ),
          SvgPicture.asset(
            imageLocation,
            width: 150,
          ),
        ],
      ),
    );
  }
}
