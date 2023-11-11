import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grace_product_seller/app/common/page_header.dart';
import 'package:grace_product_seller/app/pages/dashboard/dashboard.dart';
import 'package:grace_product_seller/app/pages/order_page/order_page.dart';
import 'package:grace_product_seller/app/pages/sale_page/sale_page.dart';
import 'package:grace_product_seller/app/pages/stock_page/stock_page.dart';
import 'package:grace_product_seller/app/styles/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    Dashboard(),
    OrderPage(),
    SalePage(),
    StockPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: media.width * 1,
                height: media.height * 1,
                color: page,
                child: Column(
                  children: [Expanded(child: pages[currentIndex])],
                ),
              ),
              const Positioned(
                top: 0,
                child: PageHeader(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: media.width * 0.04,
              height: media.width * 0.04,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/tasks.svg',
              width: media.width * 0.04,
              height: media.width * 0.04,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/shopping.svg',
              width: media.width * 0.04,
              height: media.width * 0.04,
            ),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/stock.svg',
              width: media.width * 0.04,
              height: media.width * 0.04,
            ),
            label: 'Stock',
          ),
        ],
      ),
    );
  }
}
