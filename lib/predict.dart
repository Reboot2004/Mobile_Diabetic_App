// predict.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictPage extends StatefulWidget {
  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final TextEditingController pregnanciesController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController skinThicknessController = TextEditingController();
  final TextEditingController insulinController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController diabetesPedigreeController = TextEditingController();

  String predictionResult = '';

  Future<void> makePrediction() async {
    final url = 'http://localhost:5000/predict'; // Update with your server URL
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'pregnancies': pregnanciesController.text,
        'glucose': glucoseController.text,
        'bloodpressure': bloodPressureController.text,
        'skinthickness': skinThicknessController.text,
        'insulin': insulinController.text,
        'BMI': bmiController.text,
        'age': ageController.text,
        'Diabetespedigreefunction': diabetesPedigreeController.text,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        predictionResult = 'Prediction: ${result['prediction']}';
      });
    } else {
      setState(() {
        predictionResult = 'Error predicting';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input fields for features
            TextField(
              controller: pregnanciesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Pregnancies'),
            ),
            TextField(
              controller: glucoseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Glucose'),
            ),
            TextField(
              controller: bloodPressureController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Blood Pressure'),
            ),
            TextField(
              controller: skinThicknessController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Skin Thickness'),
            ),
            TextField(
              controller: insulinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Insulin'),
            ),
            TextField(
              controller: bmiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'BMI'),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: diabetesPedigreeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Diabetes Pedigree Function'),
            ),

            const SizedBox(height: 20),

            // Button to make prediction
            ElevatedButton(
              onPressed: makePrediction,
              child: const Text('Make Prediction'),
            ),

            const SizedBox(height: 20),

            // Display prediction result
            Text(predictionResult),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PredictPage(),
  ));
}