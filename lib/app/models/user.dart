import 'package:grace_product_seller/app/models/organization.dart';

class User {
  int id;
  String name;
  String email;
  String? phone;
  List<Organization> organizations;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.organizations,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<Organization> organizations = [];

    if (json.containsKey('organizations')) {
      organizations = getOrganizationsFromJson(json['organizations']);
    }

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      organizations: organizations,
    );
  }
}
