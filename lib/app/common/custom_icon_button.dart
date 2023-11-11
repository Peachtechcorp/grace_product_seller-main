import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/styles/styles.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
  });

  final dynamic onTap;
  final String text;
  final Widget icon;

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
          // color: buttonColor,
          borderRadius: BorderRadius.circular(media.width * borderRadius),
          border: Border.all(
            width: 1,
            color: hintColor,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                text,
                style: TextStyle(
                  color: hintColor,
                  fontSize: media.width * fourteen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
