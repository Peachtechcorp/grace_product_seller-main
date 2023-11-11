import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/models/order.dart';
import 'package:grace_product_seller/app/pages/order_page/widgets/product_widget.dart';
import 'package:grace_product_seller/app/provider/order_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:provider/provider.dart';

class OrderShowPage extends StatelessWidget {
  const OrderShowPage({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '#${order.referenceNumber}',
          style: TextStyle(
            fontSize: media.width * sixteen,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: media.width * 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(media.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: media.width * 0.05),
                Container(
                  width: media.width * 1,
                  padding: EdgeInsets.symmetric(
                    horizontal: media.width * 0.04,
                    vertical: media.width * 0.08,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(media.width * 0.05),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.file_copy),
                            SizedBox(width: media.width * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID',
                                  style: TextStyle(
                                    fontSize: media.width * twelve,
                                    color: hintColor,
                                  ),
                                ),
                                SizedBox(height: media.width * 0.02),
                                Text(
                                  '#${order.referenceNumber}',
                                  style: TextStyle(
                                    fontSize: media.width * twelve,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            SizedBox(width: media.width * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Picking date',
                                  style: TextStyle(
                                    fontSize: media.width * twelve,
                                    color: hintColor,
                                  ),
                                ),
                                SizedBox(height: media.width * 0.02),
                                Text(
                                  formatDate(order.date, showTime: true),
                                  style: TextStyle(
                                    fontSize: media.width * twelve,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: media.width * 0.05),
                Container(
                  width: media.width * 1,
                  padding: EdgeInsets.symmetric(
                    horizontal: media.width * 0.04,
                    vertical: media.width * 0.08,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(media.width * 0.05),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: media.width * 0.1,
                      ),
                      SizedBox(width: media.width * 0.09),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: backgroundColor,
                                  radius: media.width * 0.035,
                                  child: Icon(
                                    Icons.person,
                                    size: media.width * 0.04,
                                  ),
                                ),
                                SizedBox(width: media.width * 0.02),
                                Text(
                                  'Angel Alex',
                                  style: TextStyle(
                                    fontSize: media.width * twelve,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: media.width * 0.01),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: backgroundColor,
                                  radius: media.width * 0.035,
                                  child: Icon(
                                    Icons.call,
                                    size: media.width * 0.04,
                                  ),
                                ),
                                SizedBox(width: media.width * 0.02),
                                Text(
                                  '+255 711 111 111',
                                  style: TextStyle(
                                    fontSize: media.width * twelve,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: media.width * 0.01),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: backgroundColor,
                                  radius: media.width * 0.035,
                                  child: Icon(
                                    Icons.mail,
                                    size: media.width * 0.04,
                                  ),
                                ),
                                SizedBox(width: media.width * 0.02),
                                Text(
                                  'Angellil12@gmail.com',
                                  style: TextStyle(
                                    fontSize: media.width * twelve,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: media.width * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        fontSize: media.width * sixteen,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: media.width * 0.05),
                // ...order.products
                //     .map((e) => ProductWidget(product: e, order: order))
                //     .toList(),
                SizedBox(height: media.width * 0.05),
                Container(
                  width: media.width * 1,
                  padding: EdgeInsets.symmetric(
                    horizontal: media.width * 0.04,
                    vertical: media.width * 0.08,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(media.width * 0.05),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fulfillment status',
                            style: TextStyle(
                              fontSize: media.width * twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          DropdownButton<String>(
                            items: const [
                              DropdownMenuItem(
                                value: 'PENDING',
                                child: Text('PENDING'),
                              ),
                              DropdownMenuItem(
                                value: 'DELIVERED',
                                child: Text('DELIVERED'),
                              ),
                            ],
                            onChanged: (String? val) async {
                              if (val != null) {
                                await Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .updateDeliveryStatus(order.id, val);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: media.width * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment status',
                            style: TextStyle(
                              fontSize: media.width * twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          DropdownButton<bool>(
                            items: [],
                            onChanged: (val) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
