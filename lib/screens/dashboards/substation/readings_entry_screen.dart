// lib/screens/readings_entry_screen.dart
import 'package:flutter/material.dart';

class ReadingsEntryScreen extends StatefulWidget {
  const ReadingsEntryScreen({super.key, String? substationId});

  @override
  State<ReadingsEntryScreen> createState() => _ReadingsEntryScreenState();
}

class _ReadingsEntryScreenState extends State<ReadingsEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _voltageController = TextEditingController();
  final _currentController = TextEditingController();
  final _temperatureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Equipment Reading'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _voltageController,
                decoration: const InputDecoration(
                  labelText: 'Voltage (V)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flash_on),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter voltage reading';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _currentController,
                decoration: const InputDecoration(
                  labelText: 'Current (A)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.electrical_services),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter current reading';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _temperatureController,
                decoration: const InputDecoration(
                  labelText: 'Temperature (°C)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.thermostat),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter temperature reading';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveReading,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Save Reading',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveReading() {
    if (_formKey.currentState?.validate() ?? false) {
      // Save the reading to database
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reading saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
}
