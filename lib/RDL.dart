import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mobilediabeticapp/userpredictions.dart';
import 'MLModel.dart';
import 'about ML page.dart';
import 'config.dart';
import 'h.dart';
import 'login.dart';

class RetinopathyScreen extends StatefulWidget {
  final String username;

  RetinopathyScreen({Key? key, required this.username}) : super(key: key);

  @override
  _RetinopathyScreenState createState() => _RetinopathyScreenState();
}

class _RetinopathyScreenState extends State<RetinopathyScreen> {
  String selectedImage = '-Select-'; // Default selected image
  List<String> imageOptions = [
    "-Select-",
    'Image 1',
    'Image 2',
    'Image 3',
    'Image 4'
  ];
  List<int> GT = [-1, 0, 1, 1, 1];
  int SelectedGT = -1;
  bool _isDark = true;
  bool groundTruthValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retinopathy Detection'),
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
                    primary: Colors.transparent, // Removes any splash color
                    onSurface: Colors.transparent, // Removes any surface color in disabled state
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ground Truth Switch:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: groundTruthValue,
              onChanged: (value) {
                setState(() {
                  if (selectedImage != "-Select-")
                    groundTruthValue = value;
                });
              },
              activeColor: Colors.cyan, // Use your theme's accent color
              activeTrackColor: Colors.cyanAccent[100], // Use a lighter version of the accent color
            ),
            SizedBox(height: 16),
            Text(
              'Select an Image:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness != Brightness.dark ? Colors.white : Colors.black, // Use a color that suits your theme
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedImage,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedImage = newValue!;
                      SelectedGT = getSelectedGT(selectedImage);
                    });
                  },
                  items: imageOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Selected Image:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (selectedImage != "-Select-")
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    getImagePath(selectedImage),
                    height: 200,
                    width: double.infinity,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call a function to send the selected image to the Flask server
                sendImageToServer(selectedImage, groundTruthValue);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan, // Button background color
                onPrimary: Colors.white, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text('Send Image to Server'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to get image path based on the selected image name
  String getImagePath(String imageName) {
    return 'assets/$imageName.jpg';
  }

  // Function to get the ground truth (GT) based on the selected image name
  int getSelectedGT(String imageName) {
    int index = imageOptions.indexOf(imageName);
    return (index >= 0 && index < GT.length) ? GT[index] : -1;
  }

  Future<void> sendImageToServer(String selectedImage, bool groundTruth) async {
    try {
      // Get the image file bytes
      List<int> imageBytes = await getImageBytes(selectedImage);

      // Construct the API endpoint URL
      String apiUrl = 'http://192.168.69.92:5000/upload';

      // Create a MultipartRequest
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add the image file to the request
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'selected_image.jpg',
      ));

      // Add ground truth to the request

      // Send the request
      var response = await http.Response.fromStream(await request.send());

      // Handle the response from the server
      if (response.statusCode == 200) {
        print('Image successfully sent to the server');
        print('Server response: ${response.body}');
        Map<String, dynamic> jsonResponse = json.decode(response.body);
  print(jsonResponse['predictions']);
        // Show an alert dialog with the server response
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String groundTruthMessage = (SelectedGT == 0)
                ? 'Non-Diabetic'
                : (SelectedGT == 1)
                ? 'Diabetic'
                : 'Unknown';
            String predictionMessage = (jsonResponse['predictions'][0] == 0.0)
                ? 'Non-Diabetic'
                : (jsonResponse['predictions'][0] == 1.0)
                ? 'Diabetic'
                : 'Unknown';
            return AlertDialog(
              title: const Text('Server Response'),
              content: SingleChildScrollView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                child: ListBody(
                  children: <Widget>[
                Visibility(
                visible: groundTruthValue,
                  child : Text("Ground Truth: $groundTruthMessage"),),
                  SizedBox(height: 8),
                  Text("Prediction: $predictionMessage"),
                ],
                ),),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to send image. Server returned: ${response.statusCode}');
        // Show an alert dialog with the error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to send image. Server returned: ${response.statusCode}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error sending image to server: $e');
      // Show an alert dialog with the error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error sending image to server: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  // Function to get the image file bytes
  Future<List<int>> getImageBytes(String imageName) async {
    String imagePath = 'assets/$imageName.jpg';
    ByteData byteData = await rootBundle.load(imagePath);
    List<int> imageBytes = byteData.buffer.asUint8List();
    return imageBytes;
  }
}
