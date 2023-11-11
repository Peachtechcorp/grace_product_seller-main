import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/models/product.dart';
import 'package:grace_product_seller/app/styles/styles.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: media.width * 1,
      padding: EdgeInsets.all(media.width * 0.03),
      margin: EdgeInsets.only(bottom: media.width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(media.width * 0.05),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: media.width * 0.2,
            height: media.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(media.width * 0.05),
              color: hintColor,
            ),
          ),
          SizedBox(width: media.width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  fontSize: media.width * twelve,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              Text(
                product.category.name,
                style: TextStyle(
                  fontSize: media.width * twelve,
                  color: hintColor,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              Text(
                'Tsh ${product.price}',
                style: TextStyle(
                  fontSize: media.width * twelve,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${product.stockCount}',
                style: TextStyle(
                  fontSize: media.width * twenty,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              Text(
                'In Stock',
                style: TextStyle(
                  fontSize: media.width * twelve,
                  color: hintColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
