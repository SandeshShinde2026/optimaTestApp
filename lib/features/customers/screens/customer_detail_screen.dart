import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../widgets/status_badge.dart';
import '../widgets/customer_avatar.dart';

class CustomerDetailScreen extends StatelessWidget {
  final Customer customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CustomerAvatar(name: customer.name, size: 80),
                  const SizedBox(height: 16),
                  Text(
                    customer.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    customer.company,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                  ),
                  const SizedBox(height: 12),
                  StatusBadge(status: customer.status),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              'CONTACT',
              [
                _buildInfoRow(context, 'Email', customer.email, Icons.email_outlined),
                _buildInfoRow(context, 'Phone', customer.phone, Icons.phone_outlined),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              'ADDRESS',
              [
                _buildInfoRow(context, 'Location', '${customer.address}\n${customer.city}, ${customer.state}', Icons.location_on_outlined),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              'ADDITIONAL INFO',
              [
                _buildInfoRow(context, 'Customer Type', customer.customerType, Icons.business_center_outlined),
                _buildInfoRow(context, 'Last Contact', customer.lastContactDate, Icons.calendar_today_outlined),
                _buildInfoRow(context, 'Customer ID', customer.id, Icons.badge_outlined),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                letterSpacing: 1.2,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
        ),
        const SizedBox(height: 8),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
