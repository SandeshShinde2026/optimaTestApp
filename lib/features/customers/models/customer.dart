enum CustomerStatus { active, inactive, prospect, other }

class Customer {
  final String id;
  final String name;
  final String company;
  final String email;
  final String phone;
  final String city;
  final String state;
  final String address;
  final CustomerStatus status;
  final String customerType;
  final String lastContactDate;

  const Customer({
    required this.id,
    required this.name,
    required this.company,
    required this.email,
    required this.phone,
    required this.city,
    required this.state,
    required this.address,
    required this.status,
    required this.customerType,
    required this.lastContactDate,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['customer_id'] ?? '',
      name: json['customer_name'] ?? '',
      company: json['company'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      address: json['address'] ?? '',
      status: _parseStatus(json['status']),
      customerType: json['customer_type'] ?? '',
      lastContactDate: json['last_contact_date'] ?? '',
    );
  }

  static CustomerStatus _parseStatus(String? status) {
    if (status == null) return CustomerStatus.other;
    switch (status.toLowerCase()) {
      case 'active':
        return CustomerStatus.active;
      case 'inactive':
        return CustomerStatus.inactive;
      case 'prospect':
        return CustomerStatus.prospect;
      default:
        return CustomerStatus.other;
    }
  }
}
