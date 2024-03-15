import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobilediabeticapp/RDL.dart';
import 'package:mobilediabeticapp/userpredictions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about ML page.dart';
import 'config.dart';
import 'login.dart';
import 'h.dart';
import 'main.dart';
import 'multiselect.dart';
import 'dart:io';
import 'RDL.dart';
class MLModel extends StatefulWidget {
  final String username;
  MLModel({Key? key, required this.username}) : super(key: key);
  @override
  _MLModelState createState() => _MLModelState(username: username);
}
class _MLModelState extends State<MLModel> {
  String selectedDataset = '-Select-'; // Default selected dataset
  List<String> datasetOptions = ['-Select-',
    'Patient 1', 'Patient 2', 'Patient 3', 'Patient 4', 'Patient 5', 'Patient 6','Patient 7', 'Patient 8', 'Patient 9'
  ];
  List<Map<String, dynamic>> datasets = [
    {'Pregnancies': 6, 'Glucose': 148, 'BloodPressure': 72, 'SkinThickness': 35, 'Insulin': 0, 'BMI': 33.6, 'DiabetesPedigreeFunction': 0.627, 'Age': 50, 'Ground Truth': 1},
    {'Pregnancies': 1, 'Glucose': 85, 'BloodPressure': 66, 'SkinThickness': 29, 'Insulin': 0, 'BMI': 26.6, 'DiabetesPedigreeFunction': 0.351, 'Age': 31, 'Ground Truth': 0},
    {'Pregnancies': 8, 'Glucose': 183, 'BloodPressure': 64, 'SkinThickness': 0, 'Insulin': 0, 'BMI': 23.3, 'DiabetesPedigreeFunction': 0.672, 'Age': 32, 'Ground Truth': 1},
    {'Pregnancies': 1, 'Glucose': 89, 'BloodPressure': 66, 'SkinThickness': 23, 'Insulin': 94, 'BMI': 28.1, 'DiabetesPedigreeFunction': 0.167, 'Age': 21, 'Ground Truth': 0},
    {'Pregnancies': 0, 'Glucose': 137, 'BloodPressure': 40, 'SkinThickness': 35, 'Insulin': 168, 'BMI': 43.1, 'DiabetesPedigreeFunction': 2.288, 'Age': 33, 'Ground Truth': 1},
    {'Pregnancies': 5, 'Glucose': 116, 'BloodPressure': 74, 'SkinThickness': 0, 'Insulin': 0, 'BMI': 25.6, 'DiabetesPedigreeFunction': 0.201, 'Age': 30, 'Ground Truth': 0},
    {'Pregnancies': 3, 'Glucose': 78, 'BloodPressure': 50, 'SkinThickness': 32, 'Insulin': 88, 'BMI': 31, 'DiabetesPedigreeFunction': 0.248, 'Age': 26, 'Ground Truth': 1},
    {'Pregnancies': 10, 'Glucose': 115, 'BloodPressure': 0, 'SkinThickness': 0, 'Insulin': 0, 'BMI': 35.3, 'DiabetesPedigreeFunction': 0.134, 'Age': 29, 'Ground Truth': 0},
    {'Pregnancies': 2, 'Glucose': 197, 'BloodPressure': 70, 'SkinThickness': 45, 'Insulin': 543, 'BMI': 30.5, 'DiabetesPedigreeFunction': 0.158, 'Age': 53, 'Ground Truth': 1},
    {'Pregnancies': 8, 'Glucose': 125, 'BloodPressure': 96, 'SkinThickness': 0, 'Insulin': 0, 'BMI': 0, 'DiabetesPedigreeFunction': 0.232, 'Age': 54, 'Ground Truth': 1},
  ];
  final String username;
  _MLModelState({Key? key, required this.username});
  String predictionResult = '';
  final _formKey = GlobalKey<FormState>();
  //String selectedModel = '-Select-';
  List<String> models = ['Random Forest', 'Decision Tree', 'SVM', 'XGBoost',];

  final pregnanciesController = TextEditingController();
  final glucoseController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final skinThicknessController = TextEditingController();
  final insulinController = TextEditingController();
  final bmiController = TextEditingController();
  final sdController = TextEditingController();
  final ageController = TextEditingController();
  final diabetesPedigreeFunctionController = TextEditingController();
  final outcomeController = TextEditingController();

  void setControllersValues() {
    // Find the selected dataset based on the chosen option
    Map<String, dynamic> selectedData = datasets[datasetOptions.indexOf(
        selectedDataset)];
    // Update controllers with values from the selected dataset
    if (selectedData != null) {
      pregnanciesController.text = selectedData['Pregnancies'].toString();
      glucoseController.text = selectedData['Glucose'].toString();
      bloodPressureController.text = selectedData['BloodPressure'].toString();
      skinThicknessController.text = selectedData['SkinThickness'].toString();
      insulinController.text = selectedData['Insulin'].toString();
      bmiController.text = selectedData['BMI'].toString();
      diabetesPedigreeFunctionController.text = selectedData['DiabetesPedigreeFunction'].toString();
      ageController.text = selectedData['Age'].toString();
      outcomeController.text = selectedData['Ground Truth'].toString();
    }
    if (outcomeController.text == '1') {
      outcomeController.text = "High Risk";
    }
    else {
      outcomeController.text = "Low Risk";
    }
    Map<String, dynamic> inputData = {
      'Pregnancies': pregnanciesController.text,
      'Glucose': glucoseController.text,
      'BloodPressure': bloodPressureController.text,
      'SkinThickness': skinThicknessController.text,
      'Insulin': insulinController.text,
      'BMI': bmiController.text,
      'DiabetesPedigreeFunction': diabetesPedigreeFunctionController.text,
      'Age': ageController.text,
    };
    //_makePrediction(inputData);
  }
  // Future<void> _makePrediction(List<Map<String, dynamic>> inputData) async {
  Future<void> _makePrediction() async {
    try {
      // Validate the form
      if (_formKey.currentState!.validate()) {
        // Retrieve user input data
        Map<String, dynamic> inputData = {
          'Pregnancies': int.parse(pregnanciesController.text),
          'Glucose': int.parse(glucoseController.text),
          'BloodPressure': int.parse(bloodPressureController.text),
          'SkinThickness': int.parse(skinThicknessController.text),
          'Insulin': int.parse(insulinController.text),
          'BMI': double.parse(bmiController.text),
          "DiabetesPedigreeFunction" : double.parse(diabetesPedigreeFunctionController.text),
          'Age': int.parse(ageController.text),
          'Model':selectedModels,
        };
      }
      Map<String, dynamic> inputData = {
        'Pregnancies': pregnanciesController.text,
        'Glucose': glucoseController.text,
        'BloodPressure': bloodPressureController.text,
        'SkinThickness': skinThicknessController.text,
        'Insulin': insulinController.text,
        'BMI': bmiController.text,
        'DiabetesPedigreeFunction': diabetesPedigreeFunctionController.text,
        'Age': ageController.text,
        'Model':selectedModels,
      };
      print(jsonEncode(inputData));
      final response = await http.post(
       Uri.parse('URL Running Flask Server'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(inputData),
      );
      print(response.body);
      Map<String, dynamic> result = jsonDecode(response.body);
      String ina = response.body;
      if (response.statusCode == 200) {
          print("yes");
          predictionResult = 'High Risk';
        String username = widget.username;
        print(username);
        String f = '';
        QuerySnapshot querySnapshot = await users.where('username', isEqualTo: username).get();
        querySnapshot.docs.forEach((doc) {
          // Get the document id
          String docId = doc.id;
          f = docId;
          // Print the document id
          print('Document id: $docId');
        }
        );
        // Add the data to Firestore under the user's collection
        await FirebaseFirestore.instance.collection('users')
            .doc(f)
            .collection('prediction')
            .add({
          'inputData': inputData,
          'predictionResult': result,
          'Ground Truth' : outcomeController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        String aaa = result['prediction'][0];
          if (selectedModels.length > 1) {
            result['prediction'].join();
            print(result);
            showPredictionResultDialog1(
                context, result['prediction'].join(), selectedModels,gt,outcomeController.text);
            return;
          }
          else
            print(selectedModels[0]);
            if (aaa == '1') {
              String va = "High Risk";
              showPredictionResultDialog(context, va, selectedModels[0],gt,outcomeController.text);
            }
            else if (aaa == '0'){
              String vsa = "Low Risk";
            showPredictionResultDialog(context, vsa, selectedModels[0],gt,outcomeController.text);
            }
        }
    } catch (e) {
      print('Error making prediction: $e');
    }
  }
  List<String> selectedModels = [];
  bool Value = false;
  String gt = '0';
  bool _isDark = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Diabetes Predictions'),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: 200,
        backgroundColor: Theme.of(context).brightness != Brightness.dark ? Colors.white : Colors.black,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: [
              Center(child:
              //Text('Menu', style: TextStyle(fontSize: 37.5, color: !_isDark ? Colors.black : Colors.white)),
              Container(
                color: Colors.transparent ,//!_isDark ? Colors.black : Colors.white, // Container color based on _isDark
                width: 200,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 37.5,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Text color based on _isDark
                  ),
                ),
              ),
              ),
              Container(
                width: 200,
                color: Colors.transparent,//_isDark ? Colors.black87 : Colors.white,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen(username: widget.username)),(Route<dynamic> route) => false,);
                  },
                  child: Text(
                    "Home",
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Container(
                width: 200,
                color: Colors.transparent,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MLModel(username: widget.username)));
                  },
                  child: Text(
                    "ML Model",
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                  ),
                ),
              ),
              // Container(
              //   width: 500,
              //   color: Colors.white,
              //   margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              //   child: TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       "Thermography DL",
              //       style: TextStyle(color: Colors.black, fontSize: 18),
              //     ),
              //   ),
              // ),
              Container(
                width: 200,
                color: Colors.transparent,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RetinopathyScreen(username: widget.username)));
                  },
                  child: Text(
                    "Retinopathy DL",
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Container(
                width: 200,
                color: Colors.transparent,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserPredictionsPage(username: widget.username)));
                  },
                  child: Text(
                    "Previous Predictions",
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Container(
                width: 200,
                color: Colors.transparent,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TestingMethodsPage(username: widget.username)));
                  },
                  child: Text(
                    "About",
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Container(
                width: 200,
                color: Colors.red,
                margin: EdgeInsets.fromLTRB(0, 100, 0, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()), // Ensure Login() is correctly instantiated
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 10), // It's better to use SizedBox for spacing
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.fromLTRB(100, 10, 0, 10),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isDark = !_isDark; // Toggle the theme state
                      currentTheme.switchTheme(); // Assuming you have a theme switcher
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent, disabledForegroundColor: Colors.transparent.withOpacity(0.0), // Removes any surface color in disabled state
                  ),
                  child: Icon(
                    Theme.of(context).brightness != Brightness.dark ? Icons.sunny : Icons.bedtime, // Toggle the icon based on the theme state
                    color: Theme.of(context).brightness != Brightness.dark ?  Colors.orange : Colors.grey, // Icon color based on _isDark
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(125, 10, 0, 20),
                child: Text(
                  'ML Model',
                  style: TextStyle(fontFamily: 'Barlow',fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: selectedDataset,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDataset = newValue!;
                        setControllersValues();});},
                    items: datasetOptions.map<DropdownMenuItem<String>>((
                        String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),);}).toList(),),
                  MultiSelectDropdown.simpleList(
                    list: models,
                    initiallySelected: const [],
                    onChange: (newList) {
                      setState(() {
                        selectedModels = List<String>.from(newList);
                        print(selectedModels);});},
                    includeSearch: true,
                    includeSelectAll: true,
                    isLarge: true,
                    width: 120, // Must be a definite number
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),),),
                  Column(
                    children: [
                      Switch(
                        value: Value,
                        onChanged: (value){setState(() => Value = value);
                        if(Value==true) {
                          gt = '1';}
                        else{
                          gt = '0';}},),
                      Text('Show Ground Truth'),
                    ],
                  ),
                ],
              ),
              // ElevatedButton(onPressed: _launchURL, child: Text("Hosted Website URL Open")),
              // ElevatedButton(onPressed: dialog, child: Text("Hosted Website POP-UP")),
              TextFormField(
                controller: pregnanciesController,
                decoration: InputDecoration(
                  labelText: 'Pregnancies',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty
                      || double.tryParse(value) == null ) {
                    return 'Please enter a valid input';
                  }
                },
              ),
              TextFormField(
                controller: glucoseController,
                decoration: InputDecoration(
                  labelText: 'Glucose (mg/dL)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null ) {
                    return 'Please enter a valid input';
                  }
                },
              ),
              TextFormField(
                controller: bloodPressureController,
                decoration: InputDecoration(
                  labelText: 'Blood Pressure (mm of Hg)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null ) {
                    return 'Please enter a valid input';
                  }
                },
              ),
              TextFormField(
                controller: skinThicknessController,
                decoration: InputDecoration(
                  labelText: 'Skin Thickness (mm)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null ) {
                    return 'Please enter a valid input';
                  }
                },
              ),
              TextFormField(
                controller: insulinController,
                decoration: InputDecoration(
                  labelText: 'Insulin (µU/ml)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null ) {
                    return 'Please enter a valid input';
                  }
                },
              ),
              TextFormField(
                controller: bmiController,
                decoration: InputDecoration(
                  labelText: 'BMI (Kg/m^2)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null ) {
                    return 'Please enter a valid input';
                  }
                },
              ),
              TextFormField(
                controller: diabetesPedigreeFunctionController,
                decoration: InputDecoration(
                  labelText: 'Diabetes Pedigree Function',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null ) {
                    return 'Please enter a valid input';
                  }
                },
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty
                      || double.tryParse(value) == null ) {
                    return 'Please enter a valid input';
                  }
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _makePrediction,
                child: Text('Make Prediction'),
              ),
              // Display the prediction result
              //Text(predictionResult),
            ],
          ),
        ),
      ),
    );
  }
}
_launchURL() async {
  const url = 'https://flask-service.ipmpa2dupjgl8.us-east-1.cs.amazonlightsail.com/a';
    await launchUrl(Uri.parse(url));
}
void showPredictionResultDialog1(
    BuildContext context,
    String predictionResult,
    List<String> modelList,
    String gt,
    String groundtruth
    ) {
  print("Hello");
  print(predictionResult);
  print(modelList);
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Prediction Result'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              for (int i = 0; i < modelList.length; i++)
                if (predictionResult[i]=='0')
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${modelList[i]} : ',
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "Low Risk",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${modelList[i]} : ',
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "High Risk",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
              if(gt=='1')
                Text('Ground Truth : $groundtruth', style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void showPredictionResultDialog(BuildContext context,
    String predictionResult,String modelList, String gt,String groundtruth) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Prediction Result'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              if (predictionResult=='0')
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${modelList} : ',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Low Risk",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              else
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${modelList} : ',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "High Risk",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              if(gt=='1')
                Text('Ground Truth : $groundtruth', style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
