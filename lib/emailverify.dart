// import 'package:email_otp/email_otp.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:twilio_flutter/twilio_flutter.dart';
// import 'register.dart';
// import 'main.dart';
// import 'login.dart';
// import 'email.dart';
// import 'dialog.dart';
// class EmailVerification {
//   EmailOTP _myAuth = EmailOTP();
//   String email1;
//   String password1;
//   String username1;
//   String phone1;
//
//   EmailVerification({
//     Key? key,
//     required this.email1,
//     required this.password1,
//     required this.username1,
//     required this.phone1,
//   });
//
//   Future<void> sendEmailOTP(String email) async {
//     _myAuth.setConfig(
//       appEmail: "myapp@diabeticapp.com",
//       appName: "Registeration OTP",
//       userEmail: email,
//       otpLength: 6,
//       otpType: OTPType.digitsOnly,
//     );
//
//     await _myAuth.sendOTP();
//
//     debugPrint(email1);
//     debugPrint(password1);
//     debugPrint(username1);
//   }
//   Future<bool> verifyEmailOTP(BuildContext context, String enteredOTP, String email, String password, String username, String phone) async {
//     try {
//       var result = await _myAuth.verifyOTP(otp: enteredOTP);
//
//       // For demonstration purposes, assuming the verification is successful
//       if (result) {
//         // Redirect to a new page or perform any other action on successful verification
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => EmailVerificationSuccess(email1 : email,password1 : password,username1 : username, phone1:phone1),
//           ),
//         );
//         return true;
//       } else {
//         // Redirect to a new page or perform any other action on verification failure
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const EmailVerificationFailure(email5 : '' ,password5 : '' ,username5 : ''),
//           ),
//         );
//         return false;
//       }
//     } catch (e) {
//       // Handle the FormatException
//       print('Error parsing OTP: $e');
//       return false;
//     }
//   }
// }
// class EmailVerificationSuccess extends StatelessWidget {
//
//   String email1;
//   String password1;
//   String username1;
//   String phone1;
//   EmailVerificationSuccess({
//     Key? key,
//     required this.email1,
//     required this.password1,
//     required this.username1,
//     required this.phone1,
//   }) : super(key: key);
//   // Function to navigate to the login page
//   void navigateToLogin(BuildContext context) {
//     navigatorKey.currentState?.pushReplacement(
//       MaterialPageRoute(
//         builder: (_) => const Login(),
//       ),
//     );
//     debugPrint(email1);
//     debugPrint(password1);
//     debugPrint(username1);
//   }
//
//   // Function to register user and store data in Firestore
//   Future<void> registerUser(String email, String password, String username, String phone) async {
//     try {
//       WidgetsFlutterBinding.ensureInitialized();
//       final FirebaseAuth _auth = FirebaseAuth.instance;
//       final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
//
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email1,
//         password: username1,
//       );
//       print(email1);
//       print(password1);
//       // Add user data to Firestore
//       await usersCollection.add({
//         'username': password1,
//         'email': email1,
//         'uid': userCredential.user?.uid,
//         'password': username1,
//         'phone' : phone1,
//       });
//       // Registration successful
//       // Import the widget file
//       showDialog(
//         context : navigatorKey.currentContext!,
//         builder: (BuildContext context) {
//           return RegistrationSuccessDialog(
//             context: context,  // Pass the context here
//             onOkPressed: () {
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(
//                   builder: (_) => const Login(),
//                 ),
//               );
//             },
//           );
//         },
//       );
//     } catch (e) {
//       print("Error during registration: $e");
//       // Handle the registration error, e.g., display an error message.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Delay before navigating and storing data
//     Future.delayed(const Duration(seconds: 2), () {
//       // Navigate to the login page
//       navigateToLogin(context);
//       // Call the registerUser function with appropriate parameters
//       registerUser(email1,password1,username1, phone1);
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Verification Successful'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(Icons.check_circle, color: Colors.green, size: 100),
//             SizedBox(height: 20),
//             Text('Email verification successful!\n Press Back Button to resume to login Page'),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class EmailVerificationFailure extends StatelessWidget {
//   final String email5;
//   final String password5;
//   final String username5;
//
//   const EmailVerificationFailure({
//     Key? key,
//     required this.email5,
//     required this.password5,
//     required this.username5,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Delay before navigating back to the registration page
//     Future.delayed(const Duration(seconds: 3), () {
//       // Navigate to the registration page with the entered data
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Register(),
//         ),
//       );
//     });
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Verification Failed'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(Icons.cancel, color: Colors.red, size: 100),
//             SizedBox(height: 20),
//             Text('Invalid OTP. Please try again.'),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class EmailVerificationPage extends StatefulWidget {
//   final TextEditingController emailController;
//   final TextEditingController usernameController;
//   final TextEditingController passwordController;
//   final TextEditingController phoneController;
//
//   const EmailVerificationPage({
//     Key? key,
//     required this.emailController,
//     required this.usernameController,
//     required this.passwordController,
//     required this.phoneController,
//   }) : super(key: key);
//
//   @override
//   _EmailVerificationPageState createState() => _EmailVerificationPageState();
// }
//
// class _EmailVerificationPageState extends State<EmailVerificationPage> {
//   final TextEditingController otpController = TextEditingController();
//   late EmailVerification _emailVerification;
//
//   @override
//   void initState() {
//     super.initState();
//     _emailVerification = EmailVerification(
//       email1: widget.emailController.text,
//       password1: widget.passwordController.text,
//       username1: widget.usernameController.text,
//       phone1: widget.phoneController.text,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Verification'),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//               foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//             ),
//             onPressed: () async {
//               await _emailVerification.sendEmailOTP(widget.emailController.text);
//             },
//             child: const Text('Send Email OTP'),
//           ),
//           OtpInput(
//             otpController: otpController,
//             onVerifyPressed: () async {
//               bool verificationSuccess = await _emailVerification.verifyEmailOTP(
//                 context,
//                 otpController.text,
//                 widget.emailController.text,
//                 widget.usernameController.text,
//                 widget.passwordController.text,
//                 widget.phoneController.text,
//               );
//
//               if (verificationSuccess) {
//                 // If OTP verification is successful, wait for 5 seconds before navigating
//                 Future.delayed(const Duration(seconds: 5), () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => const Login()),
//                         (Route<dynamic> route) => false,
//                   );
//                 });
//               } else {
//                 // If OTP verification fails, navigate back to the Register page immediately
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Register()),
//                       (Route<dynamic> route) => false,
//                 );
//               }
//             },
//           ),
//         ]
//     ),
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
// // class OtpInputPage extends StatefulWidget {
// //   final String email;
// //   final String password;
// //   final String username;
// //   final String phone;
// //
// //   const OtpInputPage({
// //     Key? key,
// //     required this.email,
// //     required this.password,
// //     required this.username,
// //     required this.phone,
// //   }) : super(key: key);
// //
// //   @override
// //   _OtpInputPageState createState() => _OtpInputPageState();
// // }
// //
// // class _OtpInputPageState extends State<OtpInputPage> {
// //   final TextEditingController otpController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Enter OTP'),
// //       ),
// //       body: Center(
// //         child: OtpInput(
// //           otpController: otpController,
// //           onVerifyPressed: () async {
// //             // Assuming you have a method to verify OTP
// //             bool isOtpValid = await EmailVerification(email1: email, password1: '', username1: '', phone1: '').verifyEmailOTP(
// //               context,
// //               otpController.text,
// //               widget.email,
// //               widget.password,
// //               widget.username,
// //               widget.phone,
// //             );
// //
// //             // Handle success or failure
// //             if (isOtpValid) {
// //               // Navigate to success screen or directly login
// //             } else {
// //               // Show error message
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilediabeticapp/register.dart';
import 'login.dart';

class EmailVerification {
  EmailOTP _myAuth = EmailOTP();
  String email1;
  String password1;
  String username1;
  String phone1;
  EmailVerification({
    required this.email1,
    required this.password1,
    required this.username1,
    required this.phone1,
  });

  Future<void> sendEmailOTP(String email) async {
    _myAuth.setConfig(
      appEmail: "myapp@diabeticapp.com",
      appName: "Registration OTP",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );

    await _myAuth.sendOTP();
  }

  Future<bool> verifyEmailOTP(BuildContext context, String enteredOTP) async {
    try {
      var result = await _myAuth.verifyOTP(otp: enteredOTP);
      return result;
    } catch (e) {
      print('Error parsing OTP: $e');
      return false;
    }
  }
}

class EmailVerificationPage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
   EmailVerificationPage({
    Key? key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.phoneController,
  }) : super(key: key);

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final TextEditingController otpController = TextEditingController();
  late EmailVerification _emailVerification;

  @override
  void initState() {
    super.initState();
    _emailVerification = EmailVerification(
      email1: widget.emailController.text,
      password1: widget.passwordController.text,
      username1: widget.usernameController.text,
      phone1: widget.phoneController.text,
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');
  var z = 0;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: widget.emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Verify your email id',
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _emailVerification.sendEmailOTP(
                          widget.emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sending OTP to ${widget.emailController
                              .text}...'),
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue),
                    ),
                    child: const Text('Send OTP'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                child: TextField(
                  controller: otpController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter OTP',
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  bool verificationSuccess = await _emailVerification
                      .verifyEmailOTP(context, otpController.text);
                  if (verificationSuccess) {
                    // Handle successful verification
                    handleSuccessfulVerification(context);
                  } else {
                    // Handle failed verification
                    handleFailedVerification(context);
                  }
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue),
                ),
                child: const Text('Verify OTP / Registration'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleSuccessfulVerification(BuildContext context) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: _emailVerification.email1,
      password: _emailVerification.password1,
    );
    await usersCollection.add({
      'username': _emailVerification.username1,
      'email': _emailVerification.email1,
      'uid': userCredential.user?.uid,
      'password': _emailVerification.password1,
      'phone': _emailVerification.phone1,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration Successful!')),
    );
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
            (Route<dynamic> route) => false,
      );
    });
  }

  void handleFailedVerification(BuildContext context) {
    if (z <= 2) {
      z += 1;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification Failed. Try again!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Failed. Try again!')),
      );
      z = 0;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Register()),
            (Route<dynamic> route) => false,
      );
    }
  }
}