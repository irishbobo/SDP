import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalorieCalculator(),
    );
  }
}

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({super.key});

  @override
  _CalorieCalculatorState createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String _gender = 'Male';
  double _bmr = 0.0;
  double _caloriesMaintain = 0.0;
  double _caloriesMildLoss = 0.0;
  double _caloriesSteadyLoss = 0.0;
  double _caloriesExtremeLoss = 0.0;

  void calculateBMR() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double feet = double.tryParse(feetController.text) ?? 0;
    double inches = double.tryParse(inchesController.text) ?? 0;
    double age = double.tryParse(ageController.text) ?? 0;

    if (weight > 0 && feet >= 0 && inches >= 0 && age > 0) {
      // Convert height to inches: total height in inches = feet * 12 + inches
      double heightInInches = (feet * 12 + inches) as double;

      // Mifflin-St Jeor Equation for BMR
      // For Men: BMR = 10 * weight(kg) + 6.25 * height(cm) - 5 * age + 5
      // For Women: BMR = 10 * weight(kg) + 6.25 * height(cm) - 5 * age - 161

      // Convert weight from lbs to kg: 1 lb = 0.453592 kg
      double weightInKg = weight * 0.453592;

      // Convert height from inches to cm: 1 inch = 2.54 cm
      double heightInCm = heightInInches * 2.54;

      double bmr;

      if (_gender == 'Male') {
        bmr = 10 * weightInKg + 6.25 * heightInCm - 5 * age + 5;
      } else {
        bmr = 10 * weightInKg + 6.25 * heightInCm - 5 * age - 161;
      }

      // Assuming sedentary lifestyle for calorie estimation: BMR * 1.2
      double caloriesMaintain = bmr * 1.2;

      // For weight loss categories, subtract from the maintain calories
      double caloriesMildLoss = caloriesMaintain - 250; // Mild weight loss (0.5 lb/week)
      double caloriesSteadyLoss = caloriesMaintain - 500; // Steady weight loss (1 lb/week)
      double caloriesExtremeLoss = caloriesMaintain - 1000; // Extreme weight loss (2 lb/week)

      setState(() {
        _bmr = bmr;
        _caloriesMaintain = caloriesMaintain;
        _caloriesMildLoss = caloriesMildLoss;
        _caloriesSteadyLoss = caloriesSteadyLoss;
        _caloriesExtremeLoss = caloriesExtremeLoss;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight (lbs)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: feetController,
                      decoration: const InputDecoration(
                        labelText: 'Height (feet)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter feet';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: inchesController,
                      decoration: const InputDecoration(
                        labelText: 'Height (inches)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter inches';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    calculateBMR();
                  }
                },
                child: const Text('Calculate BMR and Calories'),
              ),
              const SizedBox(height: 32.0),
              if (_bmr > 0)
                Column(
                  children: [
                    Text(
                      'Your BMR: ${_bmr.toStringAsFixed(2)} kcal/day',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Calories needed to Maintain weight: ${_caloriesMaintain.toStringAsFixed(2)} kcal/day',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Calories for Mild weight loss (0.5 lb/week): ${_caloriesMildLoss.toStringAsFixed(2)} kcal/day',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Calories for Steady weight loss (1 lb/week): ${_caloriesSteadyLoss.toStringAsFixed(2)} kcal/day',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Calories for Extreme weight loss (2 lb/week): ${_caloriesExtremeLoss.toStringAsFixed(2)} kcal/day',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
