import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/customer_controller.dart';
import '../widgets/customer_card.dart';
import '../models/customer.dart';
import 'customer_detail_screen.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customerController = context.watch<CustomerController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search customers...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          customerController.search('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) => customerController.search(value),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildFilterChip(context, customerController, 'All', null),
                const SizedBox(width: 8),
                _buildFilterChip(context, customerController, 'Active', CustomerStatus.active),
                const SizedBox(width: 8),
                _buildFilterChip(context, customerController, 'Inactive', CustomerStatus.inactive),
                const SizedBox(width: 8),
                _buildFilterChip(context, customerController, 'Prospects', CustomerStatus.prospect),
              ],
            ),
          ),
          const SizedBox(height: 8),
              Expanded(
                child: _buildContent(customerController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(CustomerController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Something went wrong'),
            const SizedBox(height: 8),
            Text(controller.error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.loadCustomers(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (controller.customers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No customers found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Try another search term.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: controller.customers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final customer = controller.customers[index];
        return CustomerCard(
          customer: customer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerDetailScreen(customer: customer),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterChip(BuildContext context, CustomerController controller, String label, CustomerStatus? status) {
    final isSelected = controller.currentStatusFilter == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        controller.setStatusFilter(status);
      },
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
    );
  }
}
