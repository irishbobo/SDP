import 'package:flutter/material.dart';
import 'add_food_page.dart'; // Import the AddFoodPage
import 'food_detail_page.dart'; // Import the food detail page

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  // List to hold food items
  final List<Map<String, dynamic>> _foodItems = [];

  // Add Food button logic to navigate to AddFoodPage
  void _addFood() async {
    final Map<String, dynamic>? newFood = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddFoodPage()),
    );

    // If data is not null, add it to the food items list
    if (newFood != null) {
      setState(() {
        _foodItems.add(newFood);
      });
    }
  }

  // Navigate to the Food Detail Page when a food box is clicked
  void _viewFoodDetail(Map<String, dynamic> food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailPage(food: food),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Pantry'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns in the grid
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
        ),
        itemCount: _foodItems.length,
        itemBuilder: (context, index) {
          final food = _foodItems[index];
          return GestureDetector(
            onTap: () => _viewFoodDetail(food),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      food['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Quantity: ${food['quantity']?.toString() ?? 'N/A'}'),
                    Text('Calories: ${food['calories']?.toString() ?? 'N/A'}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFood,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Page 2
class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// Page 3
class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Schedule Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// Page 4
class PageFour extends StatelessWidget {
  const PageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings', style: TextStyle(fontSize: 24)),
    );
  }
}
