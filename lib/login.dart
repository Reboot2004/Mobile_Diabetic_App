import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mobilediabeticapp/config.dart';
//import 'package:twilio/models/message.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'h.dart';
import 'register.dart';
import 'main.dart';
import 'theme.dart';
import 'config.dart';
class Login extends StatefulWidget {
  const Login({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  String loggedInUser = ''; // Variable to store the logged-in user
bool Value = false;
  Future<void> _signIn() async {
    String username = usernameC.text.trim();
    String password = passwordC.text.trim();

    if (username.isEmpty || password.isEmpty) {
      // Show an alert for empty fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign In Failed'),
            content: const Text('Please enter both username and password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Set the logged-in user
      setState(() {
        loggedInUser = username;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign In Successful'),
            content: const Text('You have successfully signed in.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WelcomeScreen(username: loggedInUser)),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign In Failed'),
            content: const Text('Invalid username or password. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  bool _isObscure = true;
  bool _isDark = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mobile Diabetic App',
          style: TextStyle(fontFamily: 'Barlow', fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset(
              'assets/login1.png', // Path to your image asset
              width: 250, // Adjust width as needed
              height: 250, // Adjust height as needed
              fit: BoxFit.fitWidth, // Adjust the fit property as needed
            ),
            const SizedBox(height: 0),
            const Padding(
              padding: EdgeInsets.symmetric(),
              child: Text(
                'Welcome Back',
                style: TextStyle(fontFamily: 'Barlow', fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // const Text('Username', style: TextStyle(fontFamily: 'Barlow', fontSize: 18)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: usernameC,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(fontFamily: 'Barlow'),
                  prefixIcon: Icon(Icons.person), // Adding a profile icon
                ),
              ),
            ),
            // const Text('Password', style: TextStyle(fontFamily: 'Barlow', fontSize: 18)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: passwordC,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5), // Adjust border radius for rectangular shape
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(fontFamily: 'Barlow'),
                  prefixIcon: Icon(Icons.vpn_key), // Adding a lock icon for password field
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Change the icon based on the state of _isObscure
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      // Update the state to toggle password visibility
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity, // Make the container fill the width of the screen
              padding: const EdgeInsets.symmetric(horizontal: 20), // Add some horizontal padding
              child: ElevatedButton(
                onPressed: _signIn,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                  foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness != Brightness.dark ? Colors.white : Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)), // Add some padding inside the button
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Round the button corners
                    ),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18), // Increase the font size
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Text color based on theme
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Not Registered with Us? ', // Part without underline
                    ),
                    TextSpan(
                      text: 'Sign Up', // Part with underline
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Your existing showDialog code
                      return AlertDialog(
                        title: Text('Recovery Options'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Choose an option below:', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Reset Password'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              _resetPasswordProcedure(context);
                            },
                          ),
                          TextButton(
                            child: Text('Retrieve Password'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              _retrievePasswordProcedure(context);
                            },
                          ),
                          TextButton(
                            child: Text('Retrieve Username'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              _retrieveUsernameProcedure(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Forgot Username / Password?',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.cyan: Colors.redAccent, // Use the theme's accent color
                    decoration: TextDecoration.underline, // Underline the text for emphasis
                    fontWeight: FontWeight.bold, // Make it bold
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove default padding
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Minimize the tap target size
                ),
              ),
            ),
     SizedBox(height : 50),
     Align(
       alignment: Alignment.bottomRight,
     child: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _isDark = !_isDark; // Assuming _isDark is a property in your State class
            currentTheme.switchTheme();
            if (_isDark == true)
              _isDark = true;
            else
              _isDark = false;
          });
        },
        icon: _isDark ? Icon(Icons.bedtime) : Icon(Icons.sunny),
        label: Text("Dark/Light"),
        //extendedPadding: EdgeInsets.all(70000.0),
      ),),
          ],
        ),
      ),
    );
  }
}
Future<void> _resetPasswordProcedure(BuildContext context) async {
  TextEditingController emailC = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
String f = '';
  showDialog(
    context: context,
    barrierDismissible: false, // User must tap button to close dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reset Password'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: emailC,
                decoration: InputDecoration(hintText: 'Username'),
              ),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(hintText: 'New Password'),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(hintText: 'Confirm New Password'),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Reset'),
            onPressed: () async {
  if (newPasswordController.text == confirmPasswordController.text && newPasswordController.text.isNotEmpty) {
                final firestoreInstance = FirebaseFirestore.instance;
                var usersCollection = firestoreInstance.collection('users');
                QuerySnapshot querySnapshot = await users.where('username', isEqualTo: emailC.text).get();
                if (querySnapshot.docs.isNotEmpty) {
                  querySnapshot.docs.forEach((doc) {
                    String docId = doc.id;
                     f = docId;
                  });
                  usersCollection.doc(f).update({'password': newPasswordController.text}).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password reset successfully')));
                    Navigator.of(context).pop(); // Close the AlertDialog
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to reset password: $error')));
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found with that email')));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match or empty')));
              }
            },
          ),
        ],
      );
    },
  );
}
Future<void> _retrieveUsernameProcedure(BuildContext context) async {
  TextEditingController emailController = TextEditingController();
  String f = '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Retrieve Username'),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: 'Enter registered Email'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Retrieve'),
            onPressed: () async {
              String email = emailController.text.trim();

              // Check if the email field is empty
              if (email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Email field is empty")),
                );
                return;
              }
              final firestoreInstance = FirebaseFirestore.instance;
              QuerySnapshot userQuerySnapshot = await firestoreInstance.collection('users').where('email', isEqualTo: email).get();

              if (userQuerySnapshot.docs.isNotEmpty) {
                userQuerySnapshot.docs.forEach((doc) {
                  String docId = doc.id;
                  f = docId;
                });
                final data = userQuerySnapshot.docs.first.data() as Map<String, dynamic>;
                String? username = data['username'] as String?;
                bool emailSent = await sendEmail(email, username!);
                print(username);
                Navigator.of(context).pop();

                if(emailSent) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Username has been sent to your email.")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to send email. Please try again.")),
                  );
                }
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Email not registered.")),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
Future<void> _retrievePasswordProcedure(BuildContext context) async {
  TextEditingController emailController = TextEditingController();
String f = '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Retrieve Password'),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: 'Enter Username'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Retrieve'),
            onPressed: () async {
              String email = emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Username field is empty")),
                  );
                  return;
                }
                final firestoreInstance = FirebaseFirestore.instance;
              QuerySnapshot userQuerySnapshot = await firestoreInstance.collection('users').where('username', isEqualTo: email).get();

                if (userQuerySnapshot.docs.isNotEmpty) {
                    userQuerySnapshot.docs.forEach((doc) {
                      String docId = doc.id;
                       f = docId;
                    });
                    final data = userQuerySnapshot.docs.first.data() as Map<String, dynamic>;
                    String? passs = data['password'] as String?;
                    String? email1 = data['email'] as String?;
                    // Send the username to the user's email
                    bool emailSent = await sendEmail1(email1!, passs!, email);
                    Navigator.of(context).pop(); // Close the dialog

                    if(emailSent) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password has been sent to registered email.")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Failed to send email. Please try again.")),
                      );
                    }
                  }
                 else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User not registered.")),
                  );
                }
              },
          ),
        ],
      );
    },
  );
}
Future<bool> sendEmail(String toEmail, String body) async {
  String username = r'your@gmail.com';
  String password = r'app password';
  final smtpServer = gmail(username, password);
  final message = Message()
    ..from = Address(username, 'Your App Name')
    ..recipients.add(toEmail)
    ..subject = "Username Pertatining to ${toEmail}"
    ..text = body;

  try {
    final sendReport = await send(message, smtpServer);
    return true;
  } catch (e) {
    print('Message not sent: $e');
    return false;
  }
}
Future<bool> sendEmail1(String toEmail, String body, String username1) async {
  String username = r'your@gmail.com';
  String password = r'app password';
  final smtpServer = gmail(username, password);
  final message = Message()
    ..from = Address(username, 'Your App Name')
    ..recipients.add(toEmail)
    ..subject = "Password Pertaining to ${toEmail}"
    ..text = "${body} is the Password for account with Username: ${username1}";

  try {
    final sendReport = await send(message, smtpServer);
    return true;
  } catch (e) {
    print('Message not sent: $e');
    return false;
  }
}

class VerificationResult {
  final String? verificationSid;
  final int statusCode;
  VerificationResult({required this.verificationSid, required this.statusCode});
}