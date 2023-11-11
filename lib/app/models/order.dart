import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:intl/intl.dart';

getOrdersFromJson(List<dynamic> orders) =>
    List.generate(orders.length, (index) => Order.fromJson(orders[index]));

class Order {
  int id;
  String referenceNumber;
  double totalPrice;
  DateTime date;
  List<OrderItem> products;
  String status;

  Order({
    required this.id,
    required this.referenceNumber,
    required this.totalPrice,
    required this.date,
    required this.products,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<OrderItem> orderItems = [];

    if (json.containsKey('items')) {
      orderItems = List.generate(json['items'].length,
          (index) => OrderItem.fromJson(json['items'][index])).toList();
    }

    return Order(
      id: json['id'],
      referenceNumber: DateTime.now().millisecondsSinceEpoch.toString(),
      totalPrice: double.parse(json['total_amount']),
      date: DateTime.parse(json['date']),
      status: json['status'],
      products: orderItems,
    );
  }

  Map<String, String> toDataRow() {
    return {
      'id': '#$referenceNumber',
      'price': formatMoney(totalPrice),
      'date': DateFormat('d MMM y').format(date),
    };
  }
}

class OrderItem {
  int id;
  String? name;
  String? description;
  int skuId;
  int productId;
  int quantity;

  OrderItem({
    required this.id,
    this.name,
    this.description,
    required this.skuId,
    required this.productId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      skuId: json['sku_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
    );
  }
}
