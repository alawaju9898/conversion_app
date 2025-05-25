// Import the Flutter material library to use Flutter widgets and components
import 'package:flutter/material.dart';

// Main function that starts the Flutter app
void main() {
  runApp(const ConverterApp()); // Initializes and runs the ConverterApp widget
}

// Root widget of the app, which is a StatelessWidget because it has no mutable state
class ConverterApp extends StatelessWidget {
  const ConverterApp({super.key}); // Constructor with a constant key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter', // Title of the app
      theme: ThemeData(primarySwatch: Colors.blue), // Sets the primary theme color
      home: const MeasureConverter(), // Sets the home screen to MeasureConverter widget
    );
  }
}

// Stateful widget for the main functionality of the converter
class MeasureConverter extends StatefulWidget {
  const MeasureConverter({super.key}); // Constructor with a constant key

  @override
  _MeasureConverterState createState() => _MeasureConverterState(); // Creates the mutable state for this widget
}

// State class for MeasureConverter, holding all data and logic for the converter
class _MeasureConverterState extends State<MeasureConverter> {
  final TextEditingController _valueController = TextEditingController(); // Controller for the input field
  String _fromUnit = 'kilometers'; // Default unit to convert from
  String _toUnit = 'miles'; // Default unit to convert to
  String _result = ''; // Stores the conversion result

  // Conversion factors for each type of measurement
  final Map<String, double> _conversionFactors = {
    'kilometersToMiles': 0.621371,
    'milesToKilometers': 1.60934,
    'kilogramsToPounds': 2.20462,
    'poundsToKilograms': 0.453592,
    'metersToFeet': 3.28084,
    'feetToMeters': 0.3048,
  };

  // Method to perform the conversion based on selected units
  void _convert() {
    double value = double.tryParse(_valueController.text) ?? 0; // Parses input or defaults to 0 if invalid
    double conversionFactor = 1; // Default conversion factor

    // Determines the appropriate conversion factor based on selected units
    if (_fromUnit == 'kilometers' && _toUnit == 'miles') {
      conversionFactor = _conversionFactors['kilometersToMiles']!;
    } else if (_fromUnit == 'miles' && _toUnit == 'kilometers') {
      conversionFactor = _conversionFactors['milesToKilometers']!;
    } else if (_fromUnit == 'kilograms' && _toUnit == 'pounds') {
      conversionFactor = _conversionFactors['kilogramsToPounds']!;
    } else if (_fromUnit == 'pounds' && _toUnit == 'kilograms') {
      conversionFactor = _conversionFactors['poundsToKilograms']!;
    } else if (_fromUnit == 'meters' && _toUnit == 'feet') {
      conversionFactor = _conversionFactors['metersToFeet']!;
    } else if (_fromUnit == 'feet' && _toUnit == 'meters') {
      conversionFactor = _conversionFactors['feetToMeters']!;
    }

    // Calculates the result based on the conversion factor
    double resultValue = value * conversionFactor;
    setState(() {
      _result = '${value.toStringAsFixed(1)} $_fromUnit is ${resultValue.toStringAsFixed(3)} $_toUnit';
    });
  }

  // Builds the UI for the converter app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Measures Converter', // AppBar title
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding around the entire body content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10), // Spacer
              const Text('Value', style: TextStyle(fontSize: 18)), // Label for input
              TextField(
                controller: _valueController, // Controls the input value
                keyboardType: TextInputType.number, // Only allows numeric input
                decoration: const InputDecoration(hintText: 'Enter value'), // Placeholder text
              ),
              const SizedBox(height: 10), // Spacer
              const Text('From', style: TextStyle(fontSize: 18)), // Label for "From" dropdown
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  value: _fromUnit, // Currently selected "From" unit
                  items: const [
                    DropdownMenuItem(value: 'kilometers', child: Text('Kilometers')),
                    DropdownMenuItem(value: 'miles', child: Text('Miles')),
                    DropdownMenuItem(value: 'kilograms', child: Text('Kilograms')),
                    DropdownMenuItem(value: 'pounds', child: Text('Pounds')),
                    DropdownMenuItem(value: 'meters', child: Text('Meters')),
                    DropdownMenuItem(value: 'feet', child: Text('Feet')),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _fromUnit = value!; // Updates the selected "From" unit
                    });
                  },
                ),
              ),
              Container(height: 1.0, color: Colors.grey), // Divider line
              const SizedBox(height: 10),
              const Text('To', style: TextStyle(fontSize: 18)), // Label for "To" dropdown
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  value: _toUnit, // Currently selected "To" unit
                  items: const [
                    DropdownMenuItem(value: 'kilometers', child: Text('Kilometers')),
                    DropdownMenuItem(value: 'miles', child: Text('Miles')),
                    DropdownMenuItem(value: 'kilograms', child: Text('Kilograms')),
                    DropdownMenuItem(value: 'pounds', child: Text('Pounds')),
                    DropdownMenuItem(value: 'meters', child: Text('Meters')),
                    DropdownMenuItem(value: 'feet', child: Text('Feet')),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _toUnit = value!; // Updates the selected "To" unit
                    });
                  },
                ),
              ),
              Container(height: 1.0, color: Colors.grey), // Divider line
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _convert, // Calls the _convert method when pressed
                child: const Text('Convert'), // Button label
              ),
              const SizedBox(height: 10),
              Text(
                _result, // Displays the conversion result
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
