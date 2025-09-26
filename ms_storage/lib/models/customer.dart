class Customer {
  final int? id;
  final String name;
  final String email;
  final String phone;

  Customer({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone};
  }
}
