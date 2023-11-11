import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/provider/order_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:provider/provider.dart';

class SalePage extends StatefulWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sales',
                style: TextStyle(
                  fontSize: media.width * sixteen,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: media.width * 0.05),
          Container(
            width: media.width * 1,
            padding: EdgeInsets.all(media.width * 0.02),
            // height: media.height * 0.47,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(media.width * 0.05),
            ),
            child: DataTable(
              dataRowColor: MaterialStateProperty.all<Color>(
                const Color(0xFFF2F2F2),
              ),
              columnSpacing: media.width * 0.08,
              dataTextStyle: TextStyle(
                fontSize: media.width * ten,
                color: Colors.black,
              ),
              showBottomBorder: false,
              columns: ['id', 'qty', 'price', 'date']
                  .map(
                    (e) => DataColumn(
                      label: Text(
                        e.toUpperCase(),
                        style: TextStyle(
                          fontSize: media.width * ten,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              rows: order.orders
                  .map(
                    (e) => DataRow(
                      color:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      cells: [
                        DataCell(
                          Text(
                            e.referenceNumber,
                            softWrap: false,
                            // style: tableTextStyle(media),
                          ),
                        ),
                        const DataCell(
                          Text(
                            '',
                            softWrap: false,
                            // style: tableTextStyle(media),
                          ),
                        ),
                        DataCell(
                          Text(
                            'Tsh ${formatMoney(e.totalPrice)}',
                            softWrap: false,
                            // style: tableTextStyle(media),
                          ),
                        ),
                        DataCell(
                          Text(
                            formatDate(e.date),
                            softWrap: false,
                            // style: tableTextStyle(media),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
