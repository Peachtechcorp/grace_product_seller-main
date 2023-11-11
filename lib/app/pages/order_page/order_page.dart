import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/pages/order_page/widgets/order_widget.dart';
import 'package:grace_product_seller/app/provider/order_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var order = Provider.of<OrderProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(media.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: media.height * 0.1,
          ),
          TextField(
            decoration: defaultDecoration(
              media: media,
              hintText: 'Search Order here',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.filter_list),
            ),
          ),
          SizedBox(height: media.width * 0.05),
          Column(
            children: order.orders.map((e) => OrderWidget(order: e)).toList(),
          )
        ],
      ),
    );
  }
}
