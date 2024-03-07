import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'MLModel.dart';
import 'RDL.dart';
import 'about ML page.dart';
import 'config.dart';
import 'h.dart';
import 'login.dart';

class UserPredictionsPage extends StatefulWidget {
  final String username;

  const UserPredictionsPage({super.key, required this.username});

  @override
  _UserPredictionsPageState createState() => _UserPredictionsPageState();
}

class _UserPredictionsPageState extends State<UserPredictionsPage> {
  Future<String?> fetchUserIdByUsername(String username) async {
    var userQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      // Assuming username is unique and only one document is returned
      return userQuerySnapshot.docs.first.id;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Predictions'),
      ),
      drawer: Drawer(
        width: 200,
        backgroundColor: Theme.of(context).brightness != Brightness.dark ? Colors.white : Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                margin: const EdgeInsets.fromLTRB(0, 100, 0, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()), // Ensure Login() is correctly instantiated
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: const Row(
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
                margin: const EdgeInsets.fromLTRB(100, 10, 0, 10),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      //_isDark = !_isDark; // Toggle the theme state
                      currentTheme.switchTheme(); // Assuming you have a theme switcher
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent, disabledForegroundColor: Colors.transparent.withOpacity(0.38), // Removes any surface color in disabled state
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
      body: FutureBuilder<String?>(
        future: fetchUserIdByUsername(widget.username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              String? userId = snapshot.data;
              return FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('prediction')
                    .orderBy('timestamp', descending: true)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var prediction = snapshot.data!.docs[index];
                          var inputData = prediction['inputData'] as Map<String, dynamic>;
                          var modelNames = inputData['Model'];
                          var predictionResult = prediction['predictionResult']['prediction'];
                          var groundTruth = prediction['Ground Truth'];

                          List<Widget> inputDataWidgets = inputData.entries.map((entry) {
                            return Text('${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 16));
                          }).toList();
                          List<Widget> predictionWidgets = List<Widget>.generate(predictionResult.length, (i) {
                            String riskLevel = predictionResult[i] == '1' ? "High Risk" : "Low Risk";
                            return Text('${modelNames[i]}: $riskLevel', style: const TextStyle(fontSize: 16));
                          });
                          return ExpansionTile(
                            title: Text('Prediction #$index'),
                            children: <Widget>[
                              ...inputDataWidgets, // Spread inputDataWidgets to include them as children
                              ...predictionWidgets,
                              ListTile(
                                title: Text('Ground Truth: $groundTruth'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return const Text('No predictions found.');
                    }
                  } else {
                    return const CircularProgressIndicator(strokeAlign: CircularProgressIndicator.strokeAlignCenter,);
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text('No user found.');
            }
          } else {
            return const CircularProgressIndicator(strokeAlign: CircularProgressIndicator.strokeAlignCenter,);
          }
        },
      ),
    );
  }
}
