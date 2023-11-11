import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/models/order.dart';
import 'package:grace_product_seller/app/provider/auth_provider.dart';
import 'package:grace_product_seller/app/utils/api.dart';
import 'package:http/http.dart' as http;

class DashboardProvider extends ChangeNotifier {
  late AuthProvider _authProvider;

  dynamic dashboardData = {
    'total_sales': 0,
    'pending_orders': 0,
    'today_orders': 0,
    'stock_sold': 0,
  };

  List<Map<String, String>> _latestOrders = [];

  bool isLoading = false;
  String errMsg = '';

  DashboardProvider(AuthProvider authProvider) {
    _authProvider = authProvider;
    getDashboardData();
  }

  List<Map<String, String>> get latestOrders => _latestOrders;

  Future<void> getDashboardData() async {
    isLoading = true;
    notifyListeners();

    try {
      var endpoint = Api.dashboard
          .replaceFirst('{agent}', '${_authProvider.currentAgent}');

      http.Response response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authProvider.token}',
        },
      );

      isLoading = false;

      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body)['data'];

        List<Order> latestOrders =
            getOrdersFromJson(apiResponse['latest_orders']);

        _latestOrders = List.generate(
            latestOrders.length, (index) => latestOrders[index].toDataRow());

        apiResponse.remove('latest_orders');

        dashboardData = apiResponse;
      } else {
        errMsg = 'Failed to fetch dashboard data!';
      }
    } catch (e) {
      errMsg = 'Something went wrong, try again later!';
      print(e);
    }

    notifyListeners();
  }
}
