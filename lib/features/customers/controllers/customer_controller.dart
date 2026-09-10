import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../repositories/customer_repository.dart';

class CustomerController extends ChangeNotifier {
  final CustomerRepository _repository = CustomerRepository();

  List<Customer> _allCustomers = [];
  List<Customer> _filteredCustomers = [];
  bool _isLoading = true;
  String? _error;

  List<Customer> get customers => _filteredCustomers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCustomers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allCustomers = await _repository.getCustomers();
      _filteredCustomers = List.from(_allCustomers);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredCustomers = List.from(_allCustomers);
    } else {
      final lowerQuery = query.toLowerCase();
      _filteredCustomers = _allCustomers.where((customer) {
        return customer.name.toLowerCase().contains(lowerQuery) ||
            customer.company.toLowerCase().contains(lowerQuery) ||
            customer.city.toLowerCase().contains(lowerQuery) ||
            customer.email.toLowerCase().contains(lowerQuery) ||
            customer.phone.toLowerCase().contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }
}
