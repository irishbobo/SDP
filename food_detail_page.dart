import 'package:flutter/material.dart';

// Food Detail Page
class FoodDetailPage extends StatelessWidget {
  final Map<String, dynamic> food;

  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    // Extract values from the passed food map
    final String foodName = food['name'];
    final String quantity = food['quantity']?.toString() ?? 'N/A';
    final String calories = food['calories']?.toString() ?? 'N/A';
    final String expirationDate = food['expirationDate'] != null
        ? DateTime.parse(food['expirationDate'])
            .toLocal()
            .toString()
            .split(' ')[0]
        : 'N/A'; // Format the expiration date if available

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name
            Text(
              'Food Name: $foodName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Quantity
            Text(
              'Quantity: $quantity',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),

            // Calories
            Text(
              'Calories: $calories',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),

            // Expiration Date
            Text(
              'Expiration Date: $expirationDate',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
