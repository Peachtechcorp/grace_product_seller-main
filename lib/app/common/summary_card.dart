import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grace_product_seller/app/styles/styles.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    Key? key,
    this.asset,
    required this.name,
    required this.value,
    required this.color,
  }) : super(key: key);

  final String? asset;
  final String name;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: media.width * 0.04,
        vertical: media.width * 0.05,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(media.width * 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (asset == null)
              ? const SizedBox()
              : CircleAvatar(
                  radius: media.width * 0.04,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    asset!,
                    height: media.width * 0.045,
                    width: media.width * 0.045,
                  ),
                ),
          SizedBox(height: media.width * 0.03),
          Text(
            name,
            style: TextStyle(
              fontSize: media.width * twelve,
              color: Colors.white,
            ),
          ),
          // const Spacer(),
          SizedBox(height: media.width * 0.03),
          Text(
            value,
            style: TextStyle(
              fontSize: media.width * eighteen,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
