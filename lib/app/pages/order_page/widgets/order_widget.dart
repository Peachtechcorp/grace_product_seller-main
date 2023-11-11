import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/models/order.dart';
import 'package:grace_product_seller/app/pages/order_page/widgets/order_show_page.dart';
import 'package:grace_product_seller/app/styles/styles.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(media.width * 0.05),
      child: Container(
        width: media.width * 1,
        // padding: EdgeInsets.all(media.width * 0.03),
        margin: EdgeInsets.only(bottom: media.width * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(media.width * 0.05),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: containerHeaderColor,
              padding: EdgeInsets.all(media.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.referenceNumber,
                    style: TextStyle(
                      fontSize: media.width * twelve,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    formatDate(order.date, showTime: true),
                    style: TextStyle(
                      fontSize: media.width * twelve,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: media.width * 0.04, horizontal: media.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'This order consists of ${order.products.length} products',
                        style: TextStyle(
                          fontSize: media.width * twelve,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: media.width * 0.04,
                            vertical: media.width * 0.01),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(
                            media.width * 0.01,
                          ),
                        ),
                        child: Text(
                          order.status,
                          style: TextStyle(
                            fontSize: media.width * ten,
                            color: textWarningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: media.width * 0.03),
                  Text(
                    'Tsh ${formatMoney(order.totalPrice)}',
                    style: TextStyle(
                      fontSize: media.width * fourteen,
                    ),
                  ),
                  SizedBox(height: media.width * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today at ${formatTime(order.date, is24: false)}',
                        style: TextStyle(
                          fontSize: media.width * ten,
                          color: hintColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OrderShowPage(order: order),
                            ),
                          );
                        },
                        child: Text(
                          'View Order',
                          style: TextStyle(
                            fontSize: media.width * twelve,
                            color: textSuccessColor,
                          ),
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
    );
  }
}
