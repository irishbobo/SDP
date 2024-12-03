import 'package:flutter/material.dart';

// Recipe Detail Page
class RecipeDetailPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // Extract values from the passed food map
    final String recipeName = recipe['name'];
    final String recipeCalories = recipe['calories']?.toString() ?? 'N/A';
    final String recipeServings = recipe['servings']?.toString() ?? 'N/A';
    final String recipeDirections = recipe['directions'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // recipe Name
            Text(
              'Recipe Name: $recipeName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Calories: $recipeCalories',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Serving Size: $recipeServings',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Directions: $recipeDirections',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
