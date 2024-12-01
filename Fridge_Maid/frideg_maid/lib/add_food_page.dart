import 'package:flutter/material.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  DateTime? _expirationDate;

  // Method to pick the expiration date
  Future<void> _selectExpirationDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _expirationDate = selectedDate;
      });
    }
  }

  // Add food item when user clicks "Add Food"
  void _addFood() {
    final String foodName = _foodNameController.text;
    final String quantity = _quantityController.text;
    final String calories = _caloriesController.text;

    // Check if food name is not empty (other fields are optional)
    if (foodName.isNotEmpty) {
      // Send data back to the previous page
      Navigator.pop(context, {
        'name': foodName,
        'quantity': quantity.isNotEmpty ? int.parse(quantity) : null,
        'calories': calories.isNotEmpty ? int.parse(calories) : null,
        'expirationDate': _expirationDate?.toIso8601String(),
      });
    } else {
      // Show an error if food name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Food name is required')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Ensures form is scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Food Name', style: TextStyle(fontSize: 18)),
              TextField(
                controller: _foodNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter food name',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Quantity (in integer)',
                  style: TextStyle(fontSize: 18)),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter quantity',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Calories (in integer)',
                  style: TextStyle(fontSize: 18)),
              TextField(
                controller: _caloriesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter calories',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Expiration Date', style: TextStyle(fontSize: 18)),
              ElevatedButton(
                onPressed: () => _selectExpirationDate(context),
                child: Text(_expirationDate == null
                    ? 'Select Expiration Date'
                    : 'Expiration Date: ${_expirationDate!.toLocal()}'
                        .split(' ')[0]),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addFood, // Add food item
                child: const Text('Add Food'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
