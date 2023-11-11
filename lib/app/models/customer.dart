class Customer {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? profileImage;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.profileImage,
  });
}
