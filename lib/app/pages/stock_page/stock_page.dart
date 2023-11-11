import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/common/button_text.dart';
import 'package:grace_product_seller/app/common/custom_button.dart';
import 'package:grace_product_seller/app/common/summary_card.dart';
import 'package:grace_product_seller/app/models/product.dart';
import 'package:grace_product_seller/app/pages/stock_page/widgets/product.dart';
import 'package:grace_product_seller/app/styles/styles.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.all(media.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: media.height * 0.1,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: media.height * 0.2,
                  child: SummaryCard(
                    name: 'Product In',
                    value: '259',
                    color: blue,
                  ),
                ),
              ),
              SizedBox(
                width: media.width * 0.05,
              ),
              Expanded(
                child: SizedBox(
                  height: media.height * 0.2,
                  child: SummaryCard(
                    name: 'Product Out',
                    value: '250',
                    color: orange,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: media.width * 0.05),
          CustomButton(
            onTap: () {},
            child: const ButtonText(text: 'Request Stock'),
          ),
          SizedBox(height: media.width * 0.05),
          Text(
            'Available Stock',
            style: TextStyle(
              fontSize: media.width * sixteen,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: media.width * 0.05),
          TextField(
            decoration: defaultDecoration(
              media: media,
              hintText: 'Search for a Product',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.filter_list),
            ),
          ),
          SizedBox(height: media.width * 0.05),
          ...products.map((e) => ProductWidget(product: e)).toList()
        ],
      ),
    );
  }
}
