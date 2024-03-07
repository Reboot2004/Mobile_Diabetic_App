import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilediabeticapp/userpredictions.dart';
import 'MLModel.dart';
import 'about ML page.dart';
import 'config.dart';
import 'login.dart';
import 'RDL.dart';

class WelcomeScreen extends StatefulWidget {
  final String username;

  const WelcomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isDark = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        title: Text(
          'Mobile Diabetic App',
          style: TextStyle(color: Theme.of(context).brightness != Brightness.dark ? Colors.white : Colors.black),
        ),centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness != Brightness.dark ? Colors.white : Colors.black, // Changes color of hamburger icon and other icons in AppBar
        ),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
          children: [
            const SizedBox(height: 20), // Add some space
            CircleAvatar(
              radius: 50, // Size of the profile icon
              backgroundColor: Theme.of(context).brightness != Brightness.dark ? Colors.black54 : Colors.grey[200], // Optional: background color of the CircleAvatar
              child: Icon(
                Icons.person, // Icon from Flutter's material icons library
                size: 50, // Size of the icon
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[200], // Color of the icon
              ),
            ),
            const SizedBox(height: 20), // Add some space between the icon and text
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
              child: Text(
                'Home Page',
                style: TextStyle(fontFamily: 'Barlow', fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: widget.username) // Assuming you're looking for a specific username
        .get(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      print(widget.username);
    // Assuming you expect only one document for a unique username
    final userData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
    return Center(
        child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        RichText(
        text: TextSpan(
        children: [
          TextSpan(
          text: "Username: ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      TextSpan(
        text: "${userData['username'] ?? 'N/A'}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
      ),
      ],
    ),
      ),
      SizedBox(height: 8), // Spacing between text widgets
      RichText(
      text: TextSpan(
      children: [
      TextSpan(
      text: "Email: ",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      TextSpan(
      text: "${userData['email'] ?? 'N/A'}",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
      ),
      ],
      ),
      ),
      SizedBox(height: 8),
      RichText(
      text: TextSpan(
      children: [
      TextSpan(
      text: "Phone: ",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      TextSpan(
      text: "${userData['phone'] ?? 'N/A'}",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
      ),
      ],
      ),
      ),]
      ));
    } else if (snapshot.hasError) {
    return Text("Error: ${snapshot.error}");
    } else {
    return Text("No data found.");
    }
    } else {
    return Center(child: CircularProgressIndicator()); // Centered loading indicator
    }
    },
    ),
] ),)
    ));
  }
}
