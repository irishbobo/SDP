import 'package:flutter/material.dart';
import 'sign_in_page.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({Key? key}) : super(key: key);

  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  String selectedCalorieView = 'Daily View';
  String selectedMealPreference = 'Breakfast';
  String selectedFitnessGoal = 'Lose Weight';
  String selectedDietaryPreference = 'N/A';
  String selectedAllergen = 'N/A';
  final TextEditingController maxCaloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/3.0x/flutter_logo.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'johndoe@example.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: maxCaloriesController,
              decoration: const InputDecoration(
                labelText: 'Max Daily Calories',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCalorieView,
              decoration: const InputDecoration(
                labelText: 'Home Page Calorie View',
                border: OutlineInputBorder(),
              ),
              items: ['Daily View', 'Weekly View']
                  .map((view) => DropdownMenuItem(value: view, child: Text(view)))
                  .toList(),
              onChanged: (value) => setState(() => selectedCalorieView = value!),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedMealPreference,
              decoration: const InputDecoration(
                labelText: 'Recommended Meals Preference',
                border: OutlineInputBorder(),
              ),
              items: ['Breakfast', 'Lunch', 'Dinner', 'Snack', 'Randomize']
                  .map((meal) => DropdownMenuItem(value: meal, child: Text(meal)))
                  .toList(),
              onChanged: (value) => setState(() => selectedMealPreference = value!),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedFitnessGoal,
              decoration: const InputDecoration(
                labelText: 'Fitness Goal',
                border: OutlineInputBorder(),
              ),
              items: ['Lose Weight', 'Bulk', 'Healthy Eating', 'Maintenance']
                  .map((goal) => DropdownMenuItem(value: goal, child: Text(goal)))
                  .toList(),
              onChanged: (value) => setState(() => selectedFitnessGoal = value!),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedDietaryPreference,
              decoration: const InputDecoration(
                labelText: 'Dietary Preferences',
                border: OutlineInputBorder(),
              ),
              items: ['N/A', 'Keto', 'Vegan', 'Low-Carb', 'Paleo', 'Pescatarian']
                  .map((preference) => DropdownMenuItem(value: preference, child: Text(preference)))
                  .toList(),
              onChanged: (value) => setState(() => selectedDietaryPreference = value!),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedAllergen,
              decoration: const InputDecoration(
                labelText: 'Allergens',
                border: OutlineInputBorder(),
              ),
              items: ['N/A', 'Peanuts', 'Dairy', 'Gluten', 'Other']
                  .map((allergen) => DropdownMenuItem(value: allergen, child: Text(allergen)))
                  .toList(),
              onChanged: (value) => setState(() => selectedAllergen = value!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings saved')),
                );
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
