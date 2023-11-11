import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grace_product_seller/app/models/order.dart';
import 'package:grace_product_seller/app/provider/auth_provider.dart';
import 'package:grace_product_seller/app/utils/api.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  late AuthProvider _authProvider;

  List<Order> _orders = [];
  bool _isloading = false;
  String _errMsg = '';

  OrderProvider(AuthProvider authProvider) {
    _authProvider = authProvider;

    init();
  }

  init() async {
    await getOrders();
  }

  List<Order> get orders => _orders;
  bool get isLoading => _isloading;
  String get errMsg => _errMsg;

  Future<void> getOrders() async {
    _isloading = true;
    notifyListeners();

    try {
      var endpoint =
          Api.orders.replaceFirst('{agent}', '${_authProvider.currentAgent}');

      http.Response response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authProvider.token}'
        },
      );

      _isloading = false;
      Map<String, dynamic> apiResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Order> orders = getOrdersFromJson(apiResponse['data']);
        _orders = orders;
      }
    } catch (e) {
      print(e);
      _errMsg = 'Something went wrong, Try again later!';
    }

    notifyListeners();
  }

  Future<Map> updateDeliveryStatus(int id, String status) async {
    Map result = {'success': false, 'message': 'Unknown error, Try again!'};

    try {
      List<Order> orders = _orders;
      Order order = orders.where((order) => order.id == id).first;
      int orderIndex = orders.indexOf(order);
      order.status = 'DELIVERED';
      orders[orderIndex] = order;

      _orders = orders;

      notifyListeners();

      var endpoint = Api.showOrder.replaceFirst('{id}', '$id');

      http.Response response = await http.put(
        Uri.parse(endpoint),
        body: {
          'status': status,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authProvider.token}'
        },
      );

      if (response.statusCode == 200) {
        result['success'] = true;
        return result;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }
}
