import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/customer.dart';

class CustomerRepository {
  Future<List<Customer>> getCustomers() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/sample_customer_data.json');
      final List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((data) => Customer.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to load customer data: $e');
    }
  }

  // search functionality can be added in controller, or repository if it hit API.
  // For local, we fetch all and controller handles search.
}
