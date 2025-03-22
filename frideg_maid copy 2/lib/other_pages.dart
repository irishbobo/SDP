import 'package:flutter/material.dart';
import 'package:frideg_maid/add_pantry_page.dart';
import 'package:frideg_maid/calorie_calculator_page.dart';
import 'package:frideg_maid/calorie_tracker_home_page.dart';
import 'add_food_page.dart'; // Import the AddFoodPage
import 'food_detail_page.dart'; // Import the food detail page
import 'add_recipe_page.dart';
import 'recipe_detail_page.dart';
import 'bmi_calculator_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Page One Fridge
class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  // List to hold food items
  final List<Map<String, dynamic>> _foodItems = [];
  final List<Map<String, dynamic>> _pantryItems = [];
  final double cardHeight = 30.0;

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

  // Add Pantry button logic to navigate to AddPantryPage
  void _addPantry() async {
    final Map<String, dynamic>? newPantry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPantryPage()),
    );

    // If data is not null, add it to the food items list
    if (newPantry != null) {
      setState(() {
        _pantryItems.add(newPantry);
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
          title: const Text('Your Fridge'),
          centerTitle: true, // Centers the title
          actions: [
            /*IconButton(
              // ignore: prefer_const_constructors
              icon: Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the row doesn't take up all available space
                children: const [
                  Icon(Icons.add_box), // Profile icon
                  SizedBox(
                      width:
                          8), // Adds a little spacing between the icon and the text
                  Text(
                    "Add Pantry", // Your text here
                    style: TextStyle(fontSize: 14), // Small text style
                  ),
                ],
              ),
              onPressed: _addPantry,
        
            ),
            IconButton(
              // ignore: prefer_const_constructors
              icon: Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the row doesn't take up all available space
                children: const [
                  Icon(Icons.kitchen), // Profile icon
                  SizedBox(
                      width:
                          8), // Adds a little spacing between the icon and the text
                  Text(
                    "Add Fridge", // Your text here
                    style: TextStyle(fontSize: 14), // Small text style
                  ),
                ],
              ),
              onPressed: () {
                // Navigate to the ----- page when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BMICalculator(),
                  ),
                );
                const Divider(
                  thickness: 2, // Adjust the thickness as needed
                  color: Colors.grey, // Adjust the color as needed
                );
              },
            ),*/
          ]),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns in the grid
          mainAxisExtent: 100,
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 8.0, // Spacing between rows
        ),
        itemCount: _foodItems.length,
        itemBuilder: (context, index) {
          final food = _foodItems[index];
          return GestureDetector(
            onTap: () => _viewFoodDetail(food),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                height: cardHeight, // Control the height here
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
                    const SizedBox(height: 4),
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

// Page 2 Home
class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  double _calories = 0.0;
  String dropdownvalue = 'Breakfast';
  List<Map<String, String>> meals = [
    {
      "name": "Spaghetti Bolognese",
      "image":
          "https://www.cookingwithnanaling.com/wp-content/uploads/2021/09/spaghetti-bolognese-sq.jpg"
    },
    {
      "name": "Grilled Chicken Salad",
      "image":
          "https://www.eatingbirdfood.com/wp-content/uploads/2023/06/grilled-chicken-salad-hero.jpg"
    },
    {
      "name": "Beef Tacos",
      "image":
          "https://kaynutrition.com/wp-content/uploads/2023/08/shredded-beef-tacos.jpg"
    },
    {
      "name": "Vegetable Stir Fry",
      "image":
          "https://www.cookingclassy.com/wp-content/uploads/2019/12/chicken-stir-fry-1.jpg"
    },
    {
      "name": "Pizza Margherita",
      "image":
          "https://kitchenswagger.com/wp-content/uploads/2023/05/margherita-pizza-close.jpg"
    },
    {
      "name": "Sushi Platter",
      "image":
          "https://properfoodie.com/wp-content/uploads/2020/07/sushi-1-1.jpg"
    },
  ];
  double cardHeight =
      170; // Example fixed height for each card, you can adjust this

  void _addCalories() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController calorieController = TextEditingController();

        return Dialog(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Adjust width based on screen width
              double dialogWidth =
                  constraints.maxWidth * 0.4; // % of screen width
              double dialogHeight =
                  constraints.maxHeight * 0.45; // % of screen height

              return Container(
                width: dialogWidth,
                height: dialogHeight,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Add Calories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Calorie input field
                    TextField(
                      controller: calorieController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter calories',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Dropdown for calorie preferences (Daily or Weekly)
                    DropdownButtonFormField<String>(
                      items: <String>[
                        'Daily Calorie View',
                        'Weekly Calorie View'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text('View Preference'),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Dropdown for meal selection
                    DropdownButtonFormField<String>(
                      items: <String>['Breakfast', 'Lunch', 'Dinner', 'Snack']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text('Enter Meal'),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    // Buttons for navigation (to different pages)
                    Column(
                      children: [
                        IconButton(
                          icon: const Row(
                            children: [
                              Icon(Icons.list),
                              Text(" Calorie Tracker Homepage"),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the current dialog or screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CalorieTrackerHome(),
                              ),
                            );
                          },
                        ),
                        /*IconButton(
                          icon: const Row(
                            children: [
                              Icon(Icons.list),
                              Text(" Calorie Calculator"),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalorieCalculator(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Row(
                            children: [
                              Icon(Icons.list),
                              Text(" BMI Calculator"),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BMICalculator(),
                              ),
                            );
                          },
                        ),*/
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Cancel and Add buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _calories +=
                                  double.tryParse(calorieController.text) ??
                                      0.0;
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 2, // Adjust the thickness as needed
            color: Colors.grey, // Adjust the color as needed
          ),
          SizedBox(
            height: 132, // Adjust the height as needed
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.week: 'Week'
              }, // Only week view
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.green, // Color the selected day green
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false, // Hide the format button
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 2, // Adjust the thickness as needed
            color: Colors.grey, // Adjust the color as needed
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // Number of columns in the grid
                      crossAxisSpacing: 8.0, // Horizontal spacing between items
                      mainAxisSpacing: 8.0, // Vertical spacing between items
                      childAspectRatio:
                          0.80, // Aspect ratio of each card (height/width)
                    ),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height:
                              cardHeight, // Control the overall height of the card
                          child: Column(
                            children: [
                              // Image section (Network Image)
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: Image.network(
                                  meals[index]["image"]!,
                                  height: cardHeight *
                                      0.9, // Image takes up 70% of card height
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Meal name section
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  meals[index]["name"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Text('Recommended For You',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalDivider(
                  thickness: 2, // Adjust the thickness as needed
                  color: Colors.grey, // Adjust the color as needed
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _addCalories,
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 90.0,
                        lineWidth: 10.0,
                        percent: _calories / 2000.0,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_calories.toStringAsFixed(0)} cal',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              '${(_calories / 2000.0 * 100).toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text(
                              'of 2000 cal',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Text(
                              'Total',
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Page 3 Schedule
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
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedCalorieView = 'Daily View';
  String selectedMealPreference = 'Breakfast';
  String selectedFitnessGoal = 'Lose Weight';
  String selectedDietaryPreference = 'Keto';
  String selectedAllergen = 'Peanuts';
  final TextEditingController maxCaloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // User Account Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/3.0x/flutter_logo.png'), // Replace with your asset image
              ),
              SizedBox(height: 20),

              // Username Information
              Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Email Information
              Text(
                'johndoe@example.com',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Max Daily Calories Input
              TextFormField(
                controller: maxCaloriesController,
                decoration: InputDecoration(
                  labelText: 'Max Daily Calories',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),

              // Home Page Calorie View Dropdown
              DropdownButtonFormField<String>(
                value: selectedCalorieView,
                decoration: InputDecoration(
                  labelText: 'Home Page Calorie View',
                  border: OutlineInputBorder(),
                ),
                items: ['Daily View', 'Weekly View']
                    .map((view) => DropdownMenuItem<String>(
                          value: view,
                          child: Text(view),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCalorieView = value!;
                  });
                },
              ),
              SizedBox(height: 20),

              // Recommended Meals Preference Dropdown
              DropdownButtonFormField<String>(
                value: selectedMealPreference,
                decoration: InputDecoration(
                  labelText: 'Recommended Meals Preference',
                  border: OutlineInputBorder(),
                ),
                items: ['Breakfast', 'Lunch', 'Dinner', 'Snack', 'Randomize']
                    .map((meal) => DropdownMenuItem<String>(
                          value: meal,
                          child: Text(meal),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMealPreference = value!;
                  });
                },
              ),
              SizedBox(height: 20),

              // Fitness Goal Dropdown
              DropdownButtonFormField<String>(
                value: selectedFitnessGoal,
                decoration: InputDecoration(
                  labelText: 'Fitness Goal',
                  border: OutlineInputBorder(),
                ),
                items: ['Lose Weight', 'Bulk', 'Healthy Eating', 'Maintenance']
                    .map((goal) => DropdownMenuItem<String>(
                          value: goal,
                          child: Text(goal),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFitnessGoal = value!;
                  });
                },
              ),
              SizedBox(height: 20),

              // Dietary Preferences Dropdown
              DropdownButtonFormField<String>(
                value: selectedDietaryPreference,
                decoration: InputDecoration(
                  labelText: 'Dietary Preferences',
                  border: OutlineInputBorder(),
                ),
                items: ['Keto', 'Vegan', 'Low-Carb', 'Paleo', 'Pescatarian']
                    .map((preference) => DropdownMenuItem<String>(
                          value: preference,
                          child: Text(preference),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDietaryPreference = value!;
                  });
                },
              ),
              SizedBox(height: 20),

              // Allergens Dropdown
              DropdownButtonFormField<String>(
                value: selectedAllergen,
                decoration: InputDecoration(
                  labelText: 'Allergens',
                  border: OutlineInputBorder(),
                ),
                items: ['Peanuts', 'Dairy', 'Gluten', 'Other']
                    .map((allergen) => DropdownMenuItem<String>(
                          value: allergen,
                          child: Text(allergen),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAllergen = value!;
                  });
                },
              ),
              SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // Handle save functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Settings saved')),
                  );
                },
                child: Text('Save'),
              ),
              SizedBox(height: 20),

              // Logout Button
              ElevatedButton(
                onPressed: () {
                  // Handle logout functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged out')),
                  );
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Page 5 Recipes
class PageFive extends StatefulWidget {
  const PageFive({super.key});

  @override
  _PageFiveState createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  // List to hold food items
  final List<Map<String, dynamic>> _recipeItems = [];

  // Add Food button logic to navigate to AddFoodPage
  void _addRecipe() async {
    final Map<String, dynamic>? newRecipe = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRecipePage()),
    );

    // If data is not null, add it to the food items list
    if (newRecipe != null) {
      setState(() {
        _recipeItems.add(newRecipe);
      });
    }
  }

  // Navigate to the Food Detail Page when a food box is clicked
  void _viewRecipeDetail(Map<String, dynamic> recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailPage(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // 1 column in the grid
          crossAxisSpacing: 1,
          mainAxisSpacing: 10.0, // Spacing between rows
        ),
        itemCount: _recipeItems.length,
        itemBuilder: (context, index) {
          final recipe = _recipeItems[index];
          return GestureDetector(
            onTap: () => _viewRecipeDetail(recipe),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      recipe['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecipe,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Page 6 Calorie Tracker Home

class PageSix extends StatefulWidget {
  const PageSix({super.key});

  @override
  _PageSixState createState() => _PageSixState();
}

class _PageSixState extends State<PageSix> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Text editing controllers for calories and descriptions
  final TextEditingController breakfastCaloriesController =
      TextEditingController();
  final TextEditingController lunchCaloriesController = TextEditingController();
  final TextEditingController dinnerCaloriesController =
      TextEditingController();
  final TextEditingController snackCaloriesController = TextEditingController();
  final TextEditingController breakfastDescriptionController =
      TextEditingController();
  final TextEditingController lunchDescriptionController =
      TextEditingController();
  final TextEditingController dinnerDescriptionController =
      TextEditingController();
  final TextEditingController snackDescriptionController =
      TextEditingController();

  // Variables to track calories for each meal
  double _breakfastCalories = 0.0;
  double _lunchCalories = 0.0;
  double _dinnerCalories = 0.0;
  double _snackCalories = 0.0;

  // Calculate total calories for the day
  double get _totalCalories =>
      _breakfastCalories + _lunchCalories + _dinnerCalories + _snackCalories;

  // Method to update meal calories and recalculate total
  void _updateMealCalories(double calories, String mealType) {
    setState(() {
      if (mealType == 'Breakfast') {
        _breakfastCalories = calories;
      } else if (mealType == 'Lunch') {
        _lunchCalories = calories;
      } else if (mealType == 'Dinner') {
        _dinnerCalories = calories;
      } else if (mealType == 'Snack') {
        _snackCalories = calories;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalDailyCalories = 2000.0; // Daily calorie goal
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Tracker Home'),
        centerTitle: true, // Centers the title
          actions: [
            IconButton(
              // ignore: prefer_const_constructors
              icon: Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the row doesn't take up all available space
                children: const [
                  Icon(Icons.calculate), // Profile icon
                  SizedBox(
                      width:
                          8), // Adds a little spacing between the icon and the text
                  Text(
                    "Cal", // Your text here
                    style: TextStyle(fontSize: 14), // Small text style
                  ),
                ],
              ),
              onPressed: () {
                // Navigate to the CalorieCalculator page when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalorieCalculator(),
                  ),
                );
              },
            ),
            IconButton(
              // ignore: prefer_const_constructors
              icon: Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the row doesn't take up all available space
                children: const [
                  Icon(Icons.calculate), // Profile icon
                  SizedBox(
                      width:
                          8), // Adds a little spacing between the icon and the text
                  Text(
                    "BMI", // Your text here
                    style: TextStyle(fontSize: 14), // Small text style
                  ),
                ],
              ),
              onPressed: () {
                // Navigate to the CalorieCalculator page when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BMICalculator(),
                  ),
                );
              },
            ),
          ]),
      body: Column(
        children: [
          const Divider(thickness: 2, color: Colors.grey),
          // Calendar widget
          SizedBox(
            height: 132,
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {CalendarFormat.week: 'Week'},
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(thickness: 2, color: Colors.grey),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return MealCategoryBox(
                        title:
                            'Breakfast: ($_breakfastCalories Calories today...)',
                        caloriesController: breakfastCaloriesController,
                        descriptionController: breakfastDescriptionController,
                        onSave: () {
                          print('Breakfast saved');
                        },
                        totalCalories: _totalCalories,
                        onCaloriesUpdated: (calories) {
                          _updateMealCalories(calories, 'Breakfast');
                        },
                      );
                    case 1:
                      return MealCategoryBox(
                        title: 'Lunch: ($_lunchCalories Calories today...)',
                        caloriesController: lunchCaloriesController,
                        descriptionController: lunchDescriptionController,
                        onSave: () {
                          print('Lunch saved');
                        },
                        totalCalories: _totalCalories,
                        onCaloriesUpdated: (calories) {
                          _updateMealCalories(calories, 'Lunch');
                        },
                      );
                    case 2:
                      return MealCategoryBox(
                        title: 'Dinner: ($_dinnerCalories Calories today...)',
                        caloriesController: dinnerCaloriesController,
                        descriptionController: dinnerDescriptionController,
                        onSave: () {
                          print('Dinner saved');
                        },
                        totalCalories: _totalCalories,
                        onCaloriesUpdated: (calories) {
                          _updateMealCalories(calories, 'Dinner');
                        },
                      );
                    case 3:
                      return MealCategoryBox(
                        title: 'Snack: ($_snackCalories Calories today...)',
                        caloriesController: snackCaloriesController,
                        descriptionController: snackDescriptionController,
                        onSave: () {
                          print('Snack saved');
                        },
                        totalCalories: _totalCalories,
                        onCaloriesUpdated: (calories) {
                          _updateMealCalories(calories, 'Snack');
                        },
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MealCategoryBox extends StatefulWidget {
  final String title;
  final TextEditingController caloriesController;
  final TextEditingController descriptionController;
  final VoidCallback onSave;
  final double totalCalories;
  final Function(double) onCaloriesUpdated;

  const MealCategoryBox({
    super.key,
    required this.title,
    required this.caloriesController,
    required this.descriptionController,
    required this.onSave,
    required this.totalCalories,
    required this.onCaloriesUpdated,
  });

  @override
  _MealCategoryBoxState createState() => _MealCategoryBoxState();
}

class _MealCategoryBoxState extends State<MealCategoryBox> {
  double _calories = 0.0;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _hasImage = false;

  void _addCalories() {
    setState(() {
      _calories = double.tryParse(widget.caloriesController.text) ?? 0.0;
      widget.onCaloriesUpdated(_calories);
    });
  }

  Future<void> _takePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _hasImage = true;
      });
    }
  }

  void _showImagePopup() {
    if (_image == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Meal Picture'),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              _image!,
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Calories Input
            TextField(
              controller: widget.caloriesController,
              decoration: const InputDecoration(
                labelText: 'Add Calories',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _addCalories();
              },
            ),
            const SizedBox(height: 8),

            // Description Input
            TextField(
              controller: widget.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: widget.onSave,
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: _hasImage ? _showImagePopup : _takePicture,
                  child: Text(_hasImage ? 'See Picture' : 'Take Picture'),
                ),
                ElevatedButton(
                  onPressed: _showCaloriesChart,
                  child: const Text('Show Chart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCaloriesChart() {
    double dailyGoalCalories = 2000.0;
    double percentage = (dailyGoalCalories > 0)
        ? (widget.totalCalories / dailyGoalCalories)
        : 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Calories Chart'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 12.0,
                  percent: percentage.clamp(0.0, 1.0),
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.totalCalories.toStringAsFixed(0)} cal',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${(percentage * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'of daily goal',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  progressColor: Colors.green,
                  backgroundColor: Colors.grey[300]!,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Meal Description:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.descriptionController.text.isNotEmpty
                      ? widget.descriptionController.text
                      : "No description added.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}













