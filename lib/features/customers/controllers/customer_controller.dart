import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../repositories/customer_repository.dart';

class CustomerController extends ChangeNotifier {
  final CustomerRepository _repository = CustomerRepository();

  List<Customer> _allCustomers = [];
  List<Customer> _filteredCustomers = [];
  bool _isLoading = true;
  String? _error;
  CustomerStatus? _currentStatusFilter;
  String _currentQuery = '';

  List<Customer> get customers => _filteredCustomers;
  bool get isLoading => _isLoading;
  String? get error => _error;
  CustomerStatus? get currentStatusFilter => _currentStatusFilter;

  int get totalCustomers => _allCustomers.length;
  int get activeCustomers => _allCustomers.where((c) => c.status == CustomerStatus.active).length;
  int get prospects => _allCustomers.where((c) => c.status == CustomerStatus.prospect).length;
  List<Customer> get recentCustomers => _allCustomers.take(5).toList();

  Map<String, int> get customersByState {
    final Map<String, int> counts = {};
    for (var c in _allCustomers) {
      if (c.state.isNotEmpty) {
        counts[c.state] = (counts[c.state] ?? 0) + 1;
      }
    }
    return counts;
  }

  Map<String, List<Customer>> get customersByCompany {
    final Map<String, List<Customer>> groups = {};
    for (var c in _allCustomers) {
      if (c.company.isNotEmpty) {
        groups.putIfAbsent(c.company, () => []).add(c);
      }
    }
    return groups;
  }

  int get totalCompanies => customersByCompany.keys.length;

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

  void setStatusFilter(CustomerStatus? status) {
    _currentStatusFilter = status;
    _applyFilters();
  }

  void search(String query) {
    _currentQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = _allCustomers;

    if (_currentStatusFilter != null) {
      filtered = filtered.where((c) => c.status == _currentStatusFilter).toList();
    }

    if (_currentQuery.isNotEmpty) {
      final lowerQuery = _currentQuery.toLowerCase();
      filtered = filtered.where((customer) {
        return customer.name.toLowerCase().contains(lowerQuery) ||
            customer.company.toLowerCase().contains(lowerQuery) ||
            customer.city.toLowerCase().contains(lowerQuery) ||
            customer.email.toLowerCase().contains(lowerQuery) ||
            customer.phone.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    _filteredCustomers = filtered;
    notifyListeners();
  }
}
