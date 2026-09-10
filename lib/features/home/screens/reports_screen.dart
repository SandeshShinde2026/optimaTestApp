import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../customers/controllers/customer_controller.dart';
import '../../customers/screens/customer_detail_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CustomerController>();

    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final byState = controller.customersByState;
    final byCompany = controller.customersByCompany;

    final sortedStates = byState.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topStates = sortedStates.take(5).toList();
    final otherCount = sortedStates.skip(5).fold<int>(0, (sum, item) => sum + item.value);

    final chartColors = [
      Theme.of(context).colorScheme.primary,
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.cyan,
      Colors.grey,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Total Companies',
                    value: controller.totalCompanies.toString(),
                    icon: Icons.business,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Locations',
                    value: byState.length.toString(),
                    icon: Icons.location_on,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Customers by Location',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    _touchedIndex = -1;
                                    return;
                                  }
                                  _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                            sections: List.generate(topStates.length + (otherCount > 0 ? 1 : 0), (i) {
                              final isTouched = i == _touchedIndex;
                              final fontSize = isTouched ? 20.0 : 14.0;
                              final radius = isTouched ? 60.0 : 50.0;
                              
                              if (i == topStates.length) {
                                return PieChartSectionData(
                                  color: chartColors[5],
                                  value: otherCount.toDouble(),
                                  title: '$otherCount',
                                  radius: radius,
                                  titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
                                );
                              }

                              final entry = topStates[i];
                              return PieChartSectionData(
                                color: chartColors[i % chartColors.length],
                                value: entry.value.toDouble(),
                                title: '${entry.value}',
                                radius: radius,
                                titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
                              );
                            }),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(topStates.length + (otherCount > 0 ? 1 : 0), (i) {
                            if (i == topStates.length) {
                              return _buildIndicator(color: chartColors[5], text: 'Other');
                            }
                            return _buildIndicator(color: chartColors[i % chartColors.length], text: topStates[i].key);
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Company Directory',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...byCompany.entries.map((entry) {
              final companyName = entry.key;
              final customers = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: ExpansionTile(
                  title: Text(companyName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${customers.length} Customer(s)'),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Text(companyName.isNotEmpty ? companyName[0].toUpperCase() : '?',
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  ),
                  children: customers.map((c) {
                    return ListTile(
                      title: Text(c.name),
                      subtitle: Text(c.email),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CustomerDetailScreen(customer: c)),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator({required Color color, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(width: 12, height: 12, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
