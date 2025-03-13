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
      175; // Example fixed height for each card, you can adjust this

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
                  constraints.maxHeight * 0.65; // % of screen height

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
                      hint: const Text(
                          'Enter Max Calories Preferences (Daily or weekly)'),
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
                        IconButton(
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
                        ),
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
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
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
                                      0.7, // Image takes up 70% of card height
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
                              const Text('Recommended For You', style: TextStyle(fontSize: 14)),
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
                        radius: 100.0,
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
                            Text(
                              'of 2000 cal',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Total',
                              style: const TextStyle(fontSize: 22),
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
    return const Center(
      child: Text('Settings', style: TextStyle(fontSize: 24)),
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
  /*double _calories = 0.0;*/

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

  @override
  Widget build(BuildContext context) {
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
                    "Calorie Calculator", // Your text here
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
                    "BMI Calculator", // Your text here
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
            ), // Placeholder for TableCalendar (to be replaced with actual TableCalendar widget)
          ),
          const Divider(
            thickness: 2, // Adjust the thickness as needed
            color: Colors.grey, // Adjust the color as needed
          ),

          // Content above the bottom boxes (if any)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,

                        //Use below to remembr the settings and variables: _calories
                        /*percent: _calories / 2000.0,
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
                            const Text('Total'),
                          ],
                        ),*/

                        percent: 1800 / 2000.0,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${1800.toStringAsFixed(0)} cal',
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              '${(1800 / 2000.0 * 100).toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text('Total'),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
                        percent: 350 / 2000.0,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${350.toStringAsFixed(0)} cal',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${(350 / 2000.0 * 100).toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text('Breakfast'),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
                        percent: 450 / 2000.0,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${450.toStringAsFixed(0)} cal',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${(450 / 2000.0 * 100).toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text('Lunch'),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
                        percent: 850 / 2000.0,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${850.toStringAsFixed(0)} cal',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${(850 / 2000.0 * 100).toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text('Dinner'),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
                        percent: 150 / 2000.0,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${150.toStringAsFixed(0)} cal',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${(150 / 2000.0 * 100).toStringAsFixed(1)}%',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text('Snack'),
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
          ), // Placeholder for other content

          const Divider(
            thickness: 2, // Adjust the thickness as needed
            color: Colors.grey, // Adjust the color as needed
          ),

          // The Row containing the four boxes at the bottom of the screen
          Padding(
            padding: const EdgeInsets.all(
                8.0), // Add padding to create space around the boxes
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MealCategoryBox(
                    title: ' Breakfast:' + '  (350 Calories today...)',
                    caloriesController: breakfastCaloriesController,
                    descriptionController: breakfastDescriptionController,
                    onSave: () {
                      print('Breakfast saved');
                      // Handle save logic here (e.g., save data to a database)
                    },
                  ),
                ),
                SizedBox(width: 16), // Space between the two boxes
                Expanded(
                  child: MealCategoryBox(
                    title: ' Lunch:' + '  (450 Calories today...)',
                    caloriesController: lunchCaloriesController,
                    descriptionController: lunchDescriptionController,
                    onSave: () {
                      print('Lunch saved');
                      // Handle save logic here (e.g., save data to a database)
                    },
                  ),
                ),
                SizedBox(width: 16), // Space between the two boxes
                Expanded(
                  child: MealCategoryBox(
                    title: ' Dinner:' + '  (850 Calories today...)',
                    caloriesController: dinnerCaloriesController,
                    descriptionController: dinnerDescriptionController,
                    onSave: () {
                      print('Dinner saved');
                      // Handle save logic here (e.g., save data to a database)
                    },
                  ),
                ),
                SizedBox(width: 16), // Space between the two boxes
                Expanded(
                  child: MealCategoryBox(
                    title: ' Snack:' + '  (150 Calories today...)',
                    caloriesController: snackCaloriesController,
                    descriptionController: snackDescriptionController,
                    onSave: () {
                      print('Snack saved');
                      // Handle save logic here (e.g., save data to a database)
                    },
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

class MealCategoryBox extends StatelessWidget {
  final String title;
  final TextEditingController caloriesController;
  final TextEditingController descriptionController;
  final VoidCallback onSave;

  MealCategoryBox({
    required this.title,
    required this.caloriesController,
    required this.descriptionController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2), // Blue outline
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5), // Space between title and input fields

          // Calorie Input Field
          TextField(
            controller: caloriesController,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
              labelText: 'Add Calories',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          // ignore: prefer_const_constructors
          SizedBox(
              height: 5), // Space between calorie and description input fields

          // Description Input Field
          TextField(
            controller: descriptionController,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 2, // Multi-line input for description
          ),
          SizedBox(height: 10), // Space for the button

          // Save Button
          ElevatedButton(
            onPressed: onSave,
            child: Padding(
              padding: const EdgeInsets.all(8.0), // You can adjust padding here
              child: Center(
                child: Text('Save'),
              ),
            ),
          )
        ],
      ),
    );
  }
}








/*

Expanded(child: Container()),


StatefulWidget {
  const PageSix({super.key});

  @override
  _PageSixState createState() => _PageSixState();
}

class _PageSixState extends State<PageSix> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  double _calories = 0.0;
  String dropdownvalue = 'Breakfast';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Tracker Home'),
      ),
      body: Column(
        children: [
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
                  _focusedDay = focusedDay; // update _focusedDay here as well
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
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
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
                            const Text('Total'),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
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
                            const Text('Breakfast'),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
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
                            const Text('Lunch'),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
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
                            const Text('Dinner'),
                          ],
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Flexible(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 5.0,
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
                            const Text('Snack'),
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
          const Divider(
            thickness: 2, // Adjust the thickness as needed
            color: Colors.grey, // Adjust the color as needed
          ),  
          
          

           Flexible(
                  child: ListView(
                    children: <Widget>[
                      _buildMealCategory(' Breakfast:', breakfastCaloriesController,
                          breakfastDescriptionController),
                      _buildDivider(),
                      _buildMealCategory(' Lunch:', lunchCaloriesController,
                          lunchDescriptionController),
                      _buildDivider(),
                      _buildMealCategory(' Dinner:', dinnerCaloriesController,
                          dinnerDescriptionController),
                      _buildDivider(),
                      _buildMealCategory(' Snack:', snackCaloriesController,
                          snackDescriptionController),
                    ],
                  ),
                ),

                
        ],
      ),
    );
  }
  
  
  Widget _buildMealCategory(
      String title,
      TextEditingController caloriesController,
      TextEditingController descriptionController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: caloriesController,
          decoration: InputDecoration(
            labelText: 'Calories Used (Placeholder)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }
}*/