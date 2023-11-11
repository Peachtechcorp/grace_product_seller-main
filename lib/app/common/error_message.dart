import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/styles/styles.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: media.width * 1,
      padding: EdgeInsets.all(media.width * 0.02),
      margin: EdgeInsets.only(bottom: media.width * 0.05),
      decoration: BoxDecoration(
        color: const Color.fromARGB(124, 195, 44, 44),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Wrap(
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: media.width * twelve,
            ),
          ),
        ],
      ),
    );
  }
}
