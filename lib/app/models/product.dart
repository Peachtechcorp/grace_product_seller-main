import 'package:grace_product_seller/app/models/category.dart';

class Product {
  final int id;
  final String name;
  final Category category;
  final double price;
  final String? image;
  final int stockCount;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stockCount,
    this.image,
  });
}

List<Product> products = [
  Product(
    id: 1,
    name: 'Cantu lotion for men',
    category: categories[0],
    price: 20000,
    stockCount: 20,
  ),
  Product(
    id: 2,
    name: 'Cantu lotion for men',
    category: categories[0],
    price: 20000,
    stockCount: 20,
  ),
  Product(
    id: 3,
    name: 'Cantu lotion for men',
    category: categories[0],
    price: 20000,
    stockCount: 20,
  ),
];
