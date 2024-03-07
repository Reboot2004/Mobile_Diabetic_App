import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/twilio_flutter.dart';
import 'register.dart';
import 'main.dart';
import 'login.dart';
import 'emailverify.dart';
import 'dialog.dart';
class EmailVerification {
  EmailOTP _myAuth = EmailOTP();
  String email1;
  String password1;
  String username1;
  String phone1;

  EmailVerification({
    Key? key,
    required this.email1,
    required this.password1,
    required this.username1,
    required this.phone1,
  });

  Future<void> sendEmailOTP(String email) async {
    _myAuth.setConfig(
      appEmail: "myapp@diabeticapp.com",
      appName: "Registeration OTP",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );

    await _myAuth.sendOTP();

    debugPrint(email1);
    debugPrint(password1);
    debugPrint(username1);
  }
  Future<bool> verifyEmailOTP(BuildContext context, String enteredOTP, String email, String password, String username, String phone) async {
    try {
      var result = await _myAuth.verifyOTP(otp: enteredOTP);

      // For demonstration purposes, assuming the verification is successful
      if (result) {
        // Redirect to a new page or perform any other action on successful verification
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmailVerificationSuccess(email1 : email,password1 : password,username1 : username, phone1:phone1),
          ),
        );
        return true;
      } else {
        // Redirect to a new page or perform any other action on verification failure
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EmailVerificationFailure(email5 : '' ,password5 : '' ,username5 : ''),
          ),
        );
        return false;
      }
    } catch (e) {
      // Handle the FormatException
      print('Error parsing OTP: $e');
      return false;
    }
  }
}
class EmailVerificationSuccess extends StatelessWidget {

  String email1;
  String password1;
  String username1;
  String phone1;
  EmailVerificationSuccess({
    Key? key,
    required this.email1,
    required this.password1,
    required this.username1,
    required this.phone1,
  }) : super(key: key);
  // Function to navigate to the login page
  void navigateToLogin(BuildContext context) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (_) => const Login(),
      ),
    );
    debugPrint(email1);
    debugPrint(password1);
    debugPrint(username1);
  }

  // Function to register user and store data in Firestore
  Future<void> registerUser(String email, String password, String username, String phone) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email1,
        password: username1,
      );
      print(email1);
      print(password1);
      // Add user data to Firestore
      await usersCollection.add({
        'username': password1,
        'email': email1,
        'uid': userCredential.user?.uid,
        'password': username1,
        'phone' : phone1,
      });
      // Registration successful
      // Import the widget file
      showDialog(
        context : navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return RegistrationSuccessDialog(
            context: context,  // Pass the context here
            onOkPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const Login(),
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      print("Error during registration: $e");
      // Handle the registration error, e.g., display an error message.
    }
  }

  @override
  Widget build(BuildContext context) {
    // Delay before navigating and storing data
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the login page
      navigateToLogin(context);
      // Call the registerUser function with appropriate parameters
      registerUser(email1,password1,username1, phone1);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Successful'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text('Email verification successful!\n Press Back Button to resume to login Page'),
          ],
        ),
      ),
    );
  }
}
class EmailVerificationFailure extends StatelessWidget {
  final String email5;
  final String password5;
  final String username5;

  const EmailVerificationFailure({
    Key? key,
    required this.email5,
    required this.password5,
    required this.username5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delay before navigating back to the registration page
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the registration page with the entered data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Failed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.cancel, color: Colors.red, size: 100),
            SizedBox(height: 20),
            Text('Invalid OTP. Please try again.'),
          ],
        ),
      ),
    );
  }
}
// class OtpInputPage extends StatelessWidget {
//   const OtpInputPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter OTP'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text('Enter OTP here'),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class OtpInput extends StatelessWidget {
//   final TextEditingController otpController;
//   final VoidCallback onVerifyPressed;
//   const OtpInput({
//     Key? key,
//     required this.otpController,
//     required this.onVerifyPressed,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text('OTP', style: TextStyle(fontSize: 18)),
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child: SizedBox(
//             width: 250,
//             child: TextField(
//               controller: otpController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter OTP',
//               ),
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: onVerifyPressed,
//           style: ButtonStyle(
//             foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//           ),
//           child: const Text('Verify OTP'),
//         ),
//       ],
//     );
//   }
// }