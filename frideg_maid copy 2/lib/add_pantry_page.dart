import 'package:flutter/material.dart';

class AddPantryPage extends StatefulWidget {
  const AddPantryPage({super.key});

  @override
  _AddPantryPageState createState() => _AddPantryPageState();
}

class _AddPantryPageState extends State<AddPantryPage> {
  final TextEditingController _pantryNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _dateCreated;

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
        _dateCreated = selectedDate;
      });
    }
  }

  // Add Pantry when user clicks "Add Pantry"
  void _addPantry() {
    final String pantryName = _pantryNameController.text;
    final String location = _locationController.text;

    // Check if food name is not empty (other fields are optional)
    if (pantryName.isNotEmpty) {
      // Send data back to the previous page
      Navigator.pop(context, {
        'name': pantryName,
        'calories': location.isNotEmpty ? int.parse(location) : null,
        'expirationDate': _dateCreated?.toIso8601String(),
      });
    } else {
      // Show an error if food name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pantry name is required')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pantry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Ensures form is scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pantry Name', style: TextStyle(fontSize: 18)),
              TextField(
                controller: _pantryNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter pantry name',
                ),
              ),
              
              
              const SizedBox(height: 16),
              const Text('Location',
                  style: TextStyle(fontSize: 18)),
              TextField(
                controller: _locationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter location',
                ),
              ),
              
              const SizedBox(height: 16),
              const Text('Creation Date', style: TextStyle(fontSize: 18)),
              ElevatedButton(
                onPressed: () => _selectExpirationDate(context),
                child: Text(_dateCreated == null
                    ? 'Select Creation Date'
                    : 'Creation Date: ${_dateCreated!.toLocal()}'
                        .split(' ')[0]),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addPantry, // Add food item
                child: const Text('Add Pantry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
