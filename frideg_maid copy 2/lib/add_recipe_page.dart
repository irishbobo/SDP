import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _directionsController = TextEditingController();

  // Add recipe item when user clicks "Add Recipe"
  void _addRecipe() {
    final String recipeName = _recipeNameController.text;
    final String servings = _servingsController.text;
    final String calories = _caloriesController.text;
    final String directions = _directionsController.text;

    // Check if recipe name is not empty (other fields are optional)
    if (recipeName.isNotEmpty) {
      // Send data back to the previous page
      Navigator.pop(context, {
        'name': recipeName,
        'servings': servings.isNotEmpty ? int.parse(servings) : null,
        'calories': calories.isNotEmpty ? int.parse(calories) : null,
        'directions': directions.isNotEmpty ? directions : null,
      });
    } else {
      // Show an error if recipe name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe name is required')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Ensures form is scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recipe Name', style: TextStyle(fontSize: 18)),
              TextField(
                controller: _recipeNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Recipe Name',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Servings (in integer)',
                  style: TextStyle(fontSize: 18)),
              TextField(
                controller: _servingsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Serving Size',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Calories (in integer)',
                  style: TextStyle(fontSize: 18)),
              TextField(
                controller: _caloriesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Calories',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Directions',
                  style: TextStyle(fontSize: 18)),
              TextField(
                controller: _directionsController,
                decoration: const InputDecoration(
                  hintText: 'Enter Directions',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addRecipe, // Add recipe
                child: const Text('Add Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}