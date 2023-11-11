import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/common/summary_card.dart';
import 'package:grace_product_seller/app/models/order.dart';
import 'package:grace_product_seller/app/provider/dashboard_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime? dateUtil;

  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toDate = DateTime.now();

  DateFormat formatDate = DateFormat('d MMM');

  var showOrderCalendar = false;
  var showChartCalendar = false;

  void handleChartCalendarTap() {}

  void handleOrderCalendarTap() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: fromDate,
              lastDay: toDate,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var dashboard = Provider.of<DashboardProvider>(context);

    return Stack(
      children: [
        SizedBox(
          height: media.height * 1,
          width: media.width * 1,
          child: SingleChildScrollView(
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
                      child: SummaryCard(
                        name: 'Total Sales',
                        value:
                            'TSH ${formatMoney(dashboard.dashboardData['total_sales'])}',
                        color: purple,
                        asset: 'assets/icons/dollar.svg',
                      ),
                    ),
                    SizedBox(width: media.width * 0.02),
                    Expanded(
                      child: SummaryCard(
                        name: 'Pending Orders',
                        value: '${dashboard.dashboardData['pending_orders']}',
                        color: yellow,
                        asset: 'assets/icons/shopping.svg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: media.width * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        name: 'Stock Sold',
                        value: '${dashboard.dashboardData['stock_sold']}',
                        color: blue,
                        asset: 'assets/icons/project.svg',
                      ),
                    ),
                    SizedBox(width: media.width * 0.02),
                    Expanded(
                      child: SummaryCard(
                        name: 'Today\'s Order',
                        value: '${dashboard.dashboardData['today_orders']}',
                        color: orange,
                        asset: 'assets/icons/shopping.svg',
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: media.width * 0.03),
                // Container(
                //   padding: EdgeInsets.all(media.width * 0.05),
                //   height: media.height * 0.47,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(media.width * 0.05),
                //   ),
                // ),
                // PopupMenuButton(
                //   itemBuilder: (context) {
                //     return [
                //       PopupMenuItem(
                //           child: Container(
                //         width: media.width * 1,
                //         child: TableCalendar(
                //           focusedDay: DateTime.now(),
                //           firstDay: fromDate,
                //           lastDay: toDate,
                //         ),
                //       )),
                //     ];
                //   },
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //         horizontal: media.width * 0.04,
                //         vertical: media.width * 0.02),
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: hintColor,
                //       ),
                //       borderRadius: BorderRadius.circular(
                //         media.width * borderRadius,
                //       ),
                //     ),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.calendar_month,
                //           size: media.width * 0.04,
                //         ),
                //         SizedBox(
                //           width: media.width * 0.02,
                //         ),
                //         Text(
                //           '${formatDate.format(fromDate)} - ${formatDate.format(toDate)}',
                //           style: TextStyle(
                //             fontSize: media.width * ten,
                //             color: hintColor,
                //           ),
                //         ),
                //         SizedBox(
                //           width: media.width * 0.02,
                //         ),
                //         Icon(
                //           Icons.keyboard_arrow_down,
                //           size: media.width * 0.04,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: media.width * 0.06),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    media.width * 0.02,
                    media.width * 0.04,
                    media.width * 0.02,
                    0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(media.width * 0.05),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: media.width * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Orders',
                              style: TextStyle(
                                fontSize: media.width * sixteen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: handleOrderCalendarTap,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: media.width * 0.04,
                                    vertical: media.width * 0.02),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: hintColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    media.width * borderRadius,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: media.width * 0.04,
                                    ),
                                    SizedBox(
                                      width: media.width * 0.02,
                                    ),
                                    Text(
                                      '${formatDate.format(fromDate)} - ${formatDate.format(toDate)}',
                                      style: TextStyle(
                                        fontSize: media.width * ten,
                                        color: hintColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.width * 0.02,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: media.width * 0.04,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: media.width * 0.05),
                      DataTable(
                        dataRowColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFF2F2F2),
                        ),
                        columnSpacing: media.width * 0.09,
                        dataTextStyle: TextStyle(
                          fontSize: media.width * ten,
                          color: Colors.black,
                        ),
                        showBottomBorder: false,
                        // ['id', 'quantity', 'price', 'date']
                        columns: ['id', 'price', 'date']
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
                        rows: dashboard.latestOrders
                            .map(
                              (order) => DataRow(
                                color: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                cells: order.values
                                    .map(
                                      (e) => DataCell(
                                        Text(
                                          e,
                                          softWrap: false,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        dashboard.isLoading
            ? Container(
                height: media.height * 1,
                width: media.width * 1,
                decoration: BoxDecoration(
                  color: page,
                ),
                child: const Center(child: CircularProgressIndicator()),
              )
            : const SizedBox(),
      ],
    );
  }

  List<Map<String, String>> fakeOrders() {
    return [
      {
        'id': '#213351',
        'quantity': '12',
        'price': '23,400',
        'date': '12 Aug 2022'
      },
      {
        'id': '#637884',
        'quantity': '13',
        'price': '42,400',
        'date': '12 Aug 2022'
      },
      {
        'id': '#678912',
        'quantity': '20',
        'price': '98,400',
        'date': '12 Aug 2022'
      },
      {
        'id': '#473819',
        'quantity': '12',
        'price': '23,400',
        'date': '12 Aug 2022'
      }
    ];
  }
}
