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
import 'package:intl/intl.dart';

// Page One Fridge
class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final List<Map<String, dynamic>> _foodItems = [];
  final List<Map<String, dynamic>> _pantryItems = [];
  final double cardHeight = 30.0;

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  void _addFood() async {
    final Map<String, dynamic>? newFood = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddFoodPage()),
    );

    if (newFood != null) {
      setState(() {
        _foodItems.add(newFood);
      });
    }
  }

  void _addPantry() async {
    final Map<String, dynamic>? newPantry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPantryPage()),
    );

    if (newPantry != null) {
      setState(() {
        _pantryItems.add(newPantry);
      });
    }
  }

  void _viewFoodDetail(Map<String, dynamic> food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailPage(food: food),
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredItems {
    if (_searchQuery.isEmpty) return _foodItems;
    return _foodItems.where((item) {
      final name = item['name']?.toString().toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Fridge'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for food...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 100,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final food = _filteredItems[index];
          return GestureDetector(
            onTap: () => _viewFoodDetail(food),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                height: cardHeight,
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

class PageThree extends StatefulWidget 
{
  const PageThree({super.key});

@override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  String? _selectedMeal;
  bool _isUserDefined = false;
  String? _selectedMealOption;
  String? _selectedSubMealOption;
  String? _mealImageUrl;
  XFile? _userImage;

  final List<String> meals = ["Breakfast", "Lunch", "Dinner", "Snack"];
  final List<String> mealOptions = [
    "Saved Recipes",
    "Recipes Based on Pantry",
    "Recipes Based on Diet"
  ];

  final List<Map<String, String>> dummyMeals = [
    {"title": "BREAKFAST: Oatmeal & Berries", "calories": "250 kcal"},
    {"title": "LUNCH: Chicken Salad", "calories": "400 kcal"},
    {"title": "DINNER: Grilled Fish & Rice", "calories": "550 kcal"},
    {"title": "SNACK: Yogurt & Nuts", "calories": "200 kcal"},
  ];

  Map<String, bool> mealCompletionStatus = {
    "Breakfast": false,
    "Lunch": false,
    "Dinner": false,
    "Snack": false,
  };

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  bool isPast(DateTime date) {
    final today = DateTime.now();
    return date.isBefore(DateTime(today.year, today.month, today.day));
  }

  List<String> getSubMealOptions(String mealOption) {
    switch (mealOption) {
      case 'Saved Recipes':
        return ["Recipe 1", "Recipe 2", "Recipe 3"];
      case 'Recipes Based on Pantry':
        return ["Pantry Recipe 1", "Pantry Recipe 2"];
      case 'Recipes Based on Diet':
        return ["Diet Recipe 1", "Diet Recipe 2"];
      default:
        return [];
    }
  }

  String? getMealImage(String meal) {
    switch (meal) {
      case 'Breakfast':
        return 'https://friendlysrestaurants.com/assets/live/img/production/detail/menu/breakfast_breakfast-classics_big-two-do-breakfast.jpg';
      case 'Lunch':
        return 'https://www.zupans.com/app/uploads/2016/10/lunchbox-sandwich-web.jpg';
      case 'Dinner':
        return 'https://myplate-prod.azureedge.us/sites/default/files/styles/large/public/2020-11/SkilletPastaDinner_527x323.jpg?itok=SxmNNwfM';
      case 'Snack':
        return 'https://www.eatthis.com/wp-content/uploads/sites/4/2017/07/fruit-nut-almond-strawberry-orange-snack-bowl.jpg';
      default:
        return null;
    }
  }

  void _reloadSystemRecommendedMeal() {
    setState(() {
      _mealImageUrl = getMealImage(_selectedMeal!);
    });
  }

  void _reloadMealOptions() {
    setState(() {
      _selectedMealOption = null;
      _selectedSubMealOption = null;
    });
  }

  Widget _buildDummyMealList() {
    return Column(
      children: [
        const Text(
          "Meal History for Selected Date",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...dummyMeals.map((meal) => Card(
              child: ListTile(
                title: Text(meal["title"]!),
                subtitle: Text("Calories: ${meal["calories"]}"),
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showDummyMeals = isPast(_selectedDate!);
    final bool isCurrentDay = isToday(_selectedDate!);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Scheduler")),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(thickness: 2.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (showDummyMeals)
              _buildDummyMealList()
            else ...[
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _selectedTime = pickedTime;
                    });
                  }
                },
                child: Text(_selectedTime == null
                    ? "Select Time"
                    : "Selected Time: ${_selectedTime!.format(context)}"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: DropdownButton<String>(
                      value: _selectedMeal,
                      hint: const Text("Select Meal"),
                      items: meals.map((String meal) {
                        return DropdownMenuItem<String>(
                          value: meal,
                          child: Text(meal),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedMeal = newValue;
                          if (newValue != null) {
                            _mealImageUrl = getMealImage(newValue);
                          }
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _selectedMeal != null
                        ? _reloadSystemRecommendedMeal
                        : null,
                  ),
                ],
              ),
              if (_selectedMeal != null && isCurrentDay)
                CheckboxListTile(
                  title: Text("Mark ${_selectedMeal!} as Completed"),
                  value: mealCompletionStatus[_selectedMeal!] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      mealCompletionStatus[_selectedMeal!] = value ?? false;
                    });
                  },
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("System Recommended"),
                  Switch(
                    value: _isUserDefined,
                    onChanged: (bool value) {
                      setState(() {
                        _isUserDefined = value;
                        _selectedMealOption = null;
                        _userImage = null;
                      });
                    },
                  ),
                  const Text("User Defined Meals"),
                ],
              ),
              const SizedBox(height: 20),
              if (_isUserDefined)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: DropdownButton<String>(
                        value: _selectedMealOption,
                        hint: const Text("Select Meal Option"),
                        items: mealOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedMealOption = newValue;
                            _selectedSubMealOption = null;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _reloadMealOptions,
                    ),
                  ],
                ),
              if (_selectedMealOption != null)
                DropdownButton<String>(
                  value: _selectedSubMealOption,
                  hint: const Text("Select a Sub Meal Option"),
                  items: getSubMealOptions(_selectedMealOption!)
                      .map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSubMealOption = newValue;
                    });
                  },
                ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _isUserDefined && _userImage == null
                      ? const Center(child: Text("Image Loading..."))
                      : _isUserDefined
                          ? Image.file(File(_userImage!.path),
                              fit: BoxFit.cover)
                          : _mealImageUrl != null
                              ? Image.network(_mealImageUrl!,
                                  fit: BoxFit.cover)
                              : const Center(child: Text("No Image")),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text("Meal Name",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Nutrient Information",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Calories: 500 kcal"),
                      Text("Protein: 20g"),
                      Text("Carbs: 50g"),
                      Text("Fats: 15g"),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Schedule committed!")),
                      );
                    },
                    child: const Text("Commit to Schedule"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedTime = null;
                        _selectedMeal = null;
                        _isUserDefined = false;
                        _selectedMealOption = null;
                        _selectedSubMealOption = null;
                        _mealImageUrl = null;
                        _userImage = null;
                      });
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}


// Page 4 Recipes
class PageFour extends StatefulWidget {
  const PageFour({super.key});

  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  final List<Map<String, dynamic>> _recipeItems = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  void _addRecipe() async {
    final Map<String, dynamic>? newRecipe = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRecipePage()),
    );

    if (newRecipe != null) {
      setState(() {
        _recipeItems.add(newRecipe);
      });
    }
  }

  void _viewRecipeDetail(Map<String, dynamic> recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailPage(recipe: recipe),
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredItems {
    if (_searchQuery.isEmpty) return _recipeItems;
    return _recipeItems.where((item) {
      final name = item['name']?.toString().toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for recipes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 1,
          mainAxisSpacing: 10.0,
        ),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final recipe = _filteredItems[index];
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


// Page 5 Calorie Tracker Home

class PageFive extends StatefulWidget {
  const PageFive({super.key});

  @override
  _PageFiveState createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
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
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
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
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
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
