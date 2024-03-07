// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class DataViewerWithUsername extends StatefulWidget {
//   final String username;
//
//   const DataViewerWithUsername({Key? key, required this.username}) : super(key: key);
//
//   @override
//   _DataViewerWithUsernameState createState() => _DataViewerWithUsernameState();
// }
//
// class _DataViewerWithUsernameState extends State<DataViewerWithUsername> {
//   final List<Map<String, dynamic>> data = [
//     {'Pregnancies': 6, 'Glucose': 148, 'BloodPressure': 72, 'SkinThickness': 35, 'Insulin': 0, 'BMI': 33.6, 'DiabetesPedigreeFunction': 0.627, 'Age': 50, 'Outcome': 1},
//     {'Pregnancies': 1, 'Glucose': 85, 'BloodPressure': 66, 'SkinThickness': 29, 'Insulin': 0, 'BMI': 26.6, 'DiabetesPedigreeFunction': 0.351, 'Age': 31, 'Outcome': 0},
//     {'Pregnancies': 8, 'Glucose': 183, 'BloodPressure': 64, 'SkinThickness': 0, 'Insulin': 0, 'BMI': 23.3, 'DiabetesPedigreeFunction': 0.672, 'Age': 32, 'Outcome': 1},
//     {'Pregnancies': 1, 'Glucose': 89, 'BloodPressure': 66, 'SkinThickness': 23, 'Insulin': 94, 'BMI': 28.1, 'DiabetesPedigreeFunction': 0.167, 'Age': 21, 'Outcome': 0},
//     {'Pregnancies': 0, 'Glucose': 137, 'BloodPressure': 40, 'SkinThickness': 35, 'Insulin': 168, 'BMI': 43.1, 'DiabetesPedigreeFunction': 2.288, 'Age': 33, 'Outcome': 1},
//     {'Pregnancies': 5, 'Glucose': 116, 'BloodPressure': 74, 'SkinThickness': 0, 'Insulin': 0, 'BMI': 25.6, 'DiabetesPedigreeFunction': 0.201, 'Age': 30, 'Outcome': 0},
//     {'Pregnancies': 3, 'Glucose': 78, 'BloodPressure': 50, 'SkinThickness': 32, 'Insulin': 88, 'BMI': 31, 'DiabetesPedigreeFunction': 0.248, 'Age': 26, 'Outcome': 1},
//     {'Pregnancies': 10, 'Glucose': 115, 'BloodPressure': 0, 'SkinThickness': 0, 'Insulin': 0, 'BMI': 35.3, 'DiabetesPedigreeFunction': 0.134, 'Age': 29, 'Outcome': 0},
//     {'Pregnancies': 2, 'Glucose': 197, 'BloodPressure': 70, 'SkinThickness': 45, 'Insulin': 543, 'BMI': 30.5, 'DiabetesPedigreeFunction': 0.158, 'Age': 53, 'Outcome': 1},
//     {'Pregnancies': 8, 'Glucose': 125, 'BloodPressure': 96, 'SkinThickness': 0, 'Insulin': 0, 'BMI': 0, 'DiabetesPedigreeFunction': 0.232, 'Age': 54, 'Outcome': 1},
//   ];
//
//   int selectedDataIndex = 0;
//   List<String> selectedModels = [];
//   List<String> availableModels = ['Model A', 'Model B', 'Model C']; // Replace with your actual list of models
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Diabetes Data Viewer - ${widget.username}'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text('Menu'),
//             ),
//             ListTile(
//               title: Text('ML Model'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//                 _showMLModelOptions();
//               },
//             ),
//             ListTile(
//               title: Text('Thermography DL'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//                 // Add code to redirect to Thermography DL
//               },
//             ),
//             ListTile(
//               title: Text('Retinopathy DL'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//                 // Add code to redirect to Retinopathy DL
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Username: ${widget.username}'),
//             const SizedBox(height: 20),
//             DropdownButton<int>(
//               value: selectedDataIndex,
//               items: List.generate(
//                 data.length,
//                     (index) => DropdownMenuItem<int>(
//                   value: index,
//                   child: Text('Data Point $index'),
//                 ),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   selectedDataIndex = value ?? 0;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _showDataPoint(data[selectedDataIndex]);
//               },
//               child: Text('Show Data Point'),
//             ),
//             const SizedBox(height: 20),
//             Text('Selected Data Point: ${selectedDataIndex + 1}'),
//             const SizedBox(height: 20),
//             DropdownButton<String>(
//               value: selectedModels.isNotEmpty ? selectedModels[0] : null,
//               items: availableModels
//                   .map(
//                     (model) => DropdownMenuItem<String>(
//                   value: model,
//                   child: Text(model),
//                 ),
//               )
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   if (value != null) {
//                     selectedModels = [value];
//                   }
//                 });
//               },
//               isExpanded: true,
//               hint: const Text('Select ML Model'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _showSelectedModels();
//               },
//               child: Text('Show Selected Models'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 makePrediction();
//               },
//               child: Text('Make Prediction'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showDataPoint(Map<String, dynamic> dataPoint) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Selected Data Point'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: dataPoint.entries
//                 .map(
//                   (entry) => Text('${entry.key}: ${entry.value}'),
//             )
//                 .toList(),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showSelectedModels() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Selected ML Models'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: selectedModels.map((model) => Text(model)).toList(),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> makePrediction() async {
//     final url = 'http://localhost:5000/predict'; // Update with the correct URL
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'pregnancies': 6,
//         'glucose': 148,
//         'bloodpressure': 72,
//         'skinthickness': 35,
//         'insulin': 0,
//         'BMI': 33.6,
//         'age': 50,
//         'Diabetespedigreefunction': 0.627,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final result = jsonDecode(response.body);
//       // Handle the prediction result
//       print('Prediction: ${result['prediction']}');
//     } else {
//       // Handle error
//       print('Error predicting');
//     }
//   }
//
//   // Function to show ML model options
//   void _showMLModelOptions() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('ML Model Options'),
//           content: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _showDataEntryDialog();
//                 },
//                 child: Text('Select Existing Data or Enter New Data'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _showModelSelectionDialog();
//                 },
//                 child: Text('Select ML Models'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // Function to show dialog for data entry
//   void _showDataEntryDialog() {
//     // Implement the dialog to enter new data
//     // You can use TextFields to get input for each parameter
//     // Example: https://flutter.dev/docs/cookbook/forms/text-input
//   }
//
//   // Function to show dialog for model selection
//   void _showModelSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select ML Models'),
//           content: Column(
//             children: availableModels
//                 .map(
//                   (model) => CheckboxListTile(
//                 title: Text(model),
//                 value: selectedModels.contains(model),
//                 onChanged: (bool? value) {
//                   setState(() {
//                     if (value != null) {
//                       if (value) {
//                         selectedModels.add(model);
//                       } else {
//                         selectedModels.remove(model);
//                       }
//                     }
//                   });
//                 },
//               ),
//             )
//                 .toList(),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'data_viewer.dart'; // Import the DataViewerWithUsername class
import 'thermography_dl.dart'; // Import the Thermography DL class
import 'retinopathy_dl.dart'; // Import the Retinopathy DL class

class WelcomeScreen extends StatelessWidget {
  final String username;

  const WelcomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Diabetic App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $username!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Open the drawer when the button is pressed
                Scaffold.of(context).openDrawer();
              },
              child: const Text('Select Method'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Select Method',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('ML Model'),
              onTap: () {
                // Navigate to DataViewerWithUsername when ML Model is selected
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataViewerWithUsername(
                      username: username,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Thermography DL'),
              onTap: () {
                // Navigate to Thermography DL when selected
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThermographyDL(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Retinopathy DL'),
              onTap: () {
                // Navigate to Retinopathy DL when selected
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RetinopathyDL(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
