import 'package:flutter/material.dart';
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
        title: const Text('Your Fridge'),
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

  void _addCalories() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController calorieController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Calories'),
          content: TextField(
            controller: calorieController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter calories'),
          ),
          actions: [
            DropdownButtonFormField<String>(
              items: <String>['Daily Calorie View', 'Weekly Calorie View']
                  .map((String value) {
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
            const Text(" "),
            IconButton(
              // Profile icon
              icon: const Row(
                children: [
                  Icon(Icons.list),
                  Text(" Calorie Tracker Homepage"),
                ],
              ),
              onPressed: () {
                // Navigate to the Calorie Tracker Home when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalorieTrackerHome(),
                  ),
                );
              },
            ),
            IconButton(
              // Profile icon
              icon: const Row(
                children: [
                  Icon(Icons.list),
                  Text(" Calorie Calculator"),
                ],
              ),
              onPressed: () {
                // Navigate to the Calorie Calculator when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalorieCalculator(),
                  ),
                );
              },
            ),
            IconButton(
              // Profile icon
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _calories += double.tryParse(calorieController.text) ?? 0.0;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
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
          SizedBox(
            height: 150, // Adjust the height as needed
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
                const Expanded(
                  child: Center(
                    child: Text(
                      'Recommended Meals',
                      style: TextStyle(fontSize: 24),
                    ),
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
  double _calories = 0.0;

  final TextEditingController breakfastCaloriesController =
      TextEditingController();
  final TextEditingController lunchCaloriesController = TextEditingController();
  final TextEditingController dinnerCaloriesController =
      TextEditingController();
  final TextEditingController snackCaloriesController =
      TextEditingController();
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
                              '${(450/ 2000.0 * 100).toStringAsFixed(1)}%',
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
            padding: const EdgeInsets.all(16.0), // Add padding to create space around the boxes
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MealCategoryBox(
                    title: 'Breakfast:',
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
                    title: 'Lunch:',
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
                    title: 'Dinner:',
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
                    title: 'Snack:',
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
      padding: EdgeInsets.all(16.0),
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
          SizedBox(height: 8), // Space between title and input fields

          // Calorie Input Field
          TextField(
            controller: caloriesController,
            decoration: InputDecoration(
              labelText: 'Calories',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 8), // Space between calorie and description input fields

          // Description Input Field
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 2, // Multi-line input for description
          ),
          SizedBox(height: 16), // Space for the button

          // Save Button
          ElevatedButton(
            onPressed: onSave, // Call the provided onSave function when the button is pressed
            child: Text('Save'),
          ),
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