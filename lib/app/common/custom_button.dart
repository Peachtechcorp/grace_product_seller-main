import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/styles/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final dynamic onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: media.width * 0.02),
        // height: media.height * 0.08,
        padding: EdgeInsets.all(media.width * 0.04),
        width: media.width * 1,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(media.width * borderRadius),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
