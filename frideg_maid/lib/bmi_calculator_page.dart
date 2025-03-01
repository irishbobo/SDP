import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();

  double _bmi = 0.0;
  String _bmiCategory = '';

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0;
    int feet = int.tryParse(feetController.text) ?? 0;
    int inches = int.tryParse(inchesController.text) ?? 0;

    if (weight > 0 && feet >= 0 && inches >= 0) {
      // Convert height to inches: total height in inches = feet * 12 + inches
      double heightInInches = (feet * 12 + inches) as double;

      // Calculate BMI using the formula:
      // BMI = (weight in lbs) / (height in inches)^2 * 703
      double bmi = (weight / (heightInInches * heightInInches)) * 703;

      setState(() {
        _bmi = bmi;
        if (bmi < 18.5) {
          _bmiCategory = 'Underweight';
        } else if (bmi >= 18.5 && bmi < 24.9) {
          _bmiCategory = 'Normal weight';
        } else if (bmi >= 25 && bmi < 29.9) {
          _bmiCategory = 'Overweight';
        } else {
          _bmiCategory = 'Obesity';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(
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
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: feetController,
                      decoration: InputDecoration(
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
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: inchesController,
                      decoration: InputDecoration(
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
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    calculateBMI();
                  }
                },
                child: Text('Calculate BMI'),
              ),
              SizedBox(height: 32.0),
              if (_bmi > 0)
                Column(
                  children: [
                    Text(
                      'Your BMI: ${_bmi.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Category: $_bmiCategory',
                      style: TextStyle(fontSize: 20),
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
