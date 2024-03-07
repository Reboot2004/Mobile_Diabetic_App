import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilediabeticapp/phone_verification.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'config.dart';
import 'emailverify.dart';
import 'main.dart';
import 'login.dart';
//import 'email.dart';
import 'emailverify.dart';
import 'package:telephony/telephony.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  TextEditingController usernameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();
  TextEditingController otpC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  EmailVerification _emailVerification = EmailVerification(
      email1: '', password1: '', username1: '', phone1: '');
bool _isObscure = true;
  bool _isConfirmObscure = true;
  bool _isDark = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Diabetic App'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    const SizedBox(height: 20), // Adjust the space as needed
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0), // Adjust the corner radius as needed
                      child: Image.asset(
                        'assets/signup.jpg',
                        width: 250, // Use the full width of the screen
                        height: 175, // Adjust the height as needed
                        fit: BoxFit.cover, // Cover the widget bounds without changing the aspect ratio
                      ),
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                    //   child: Text('Sign Up', style: TextStyle(
                    //       fontSize: 37.5, fontWeight: FontWeight.bold)),
                    // ),
                    const Text('''Don’t wait! 🕒 
Take the first step towards a healthier future. ''', style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: usernameC,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          prefixIcon: Icon(Icons.person), // Adding a person icon as prefix
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    //const Text('Phone Number', style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: phoneNumberC,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5), // Adjust border radius for rectangular shape
                          ),
                          prefixIcon: Icon(Icons.phone), // Adding a phone icon as prefix
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number is required';
                          }
                          // Optional: Additional validation for phone number format can be added here
                          return null;
                        },
                        keyboardType: TextInputType.phone, // To show phone number keyboard
                      ),
                    ),
                    //const Text('E-mail', style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailC,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5), // Adjust border radius for rectangular shape
                          ),
                          prefixIcon: Icon(Icons.email), // Adding an email icon as prefix
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          if (!value.contains('@')) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress, // To show email keyboard
                      ),
                    ),
                    // const Text('Password', style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: passwordC,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5), // Adjust border radius for rectangular shape
                          ),
                          prefixIcon: Icon(Icons.lock_outline), // Adding a lock icon for password field
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Toggle visibility icon based on password visibility
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // Toggle the password visibility
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        obscureText: _isObscure, // Control the text visibility
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    //const Text(
                   //     'Confirm Password', style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: confirmPasswordC,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5), // Adjust border radius for rectangular shape
                          ),
                          prefixIcon: Icon(Icons.vpn_key), // Adding a lock icon for confirm password field
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Toggle visibility icon based on the _isConfirmObscure state
                              _isConfirmObscure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // Toggle the password visibility
                              setState(() {
                                _isConfirmObscure = !_isConfirmObscure;
                              });
                            },
                          ),
                        ),
                        obscureText: _isConfirmObscure, // Control the text visibility
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordC.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    // For Email OTP Verification
                    Row(
                      children: [
                        SizedBox(width: 30,),
                    TextButton(
                      onPressed: () async {
                        // Check if form is valid
                        if (_formKey.currentState!.validate()) {
                          final email = emailC.text.trim(); // Assuming emailC is your TextEditingController for email input

                          // Query Firestore to check if email already exists
                          final querySnapshot = await FirebaseFirestore.instance
                              .collection('users')
                              .where('email', isEqualTo: email)
                              .get();

                          if (querySnapshot.docs.isNotEmpty) {
                            // Email already exists, inform the user
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email already exists. Please use a different email.')),
                            );
                          } else {
                            // Email does not exist, navigate to EmailVerificationPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmailVerificationPage(
                                  emailController: emailC, // Assuming you have these controllers in your widget
                                  usernameController: usernameC,
                                  passwordController: passwordC,
                                  phoneController: phoneNumberC,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Text('Verify via Email OTP'),
                    ),
                    SizedBox(width: 20,),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        // Check if form is valid
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                PhoneVerification1(
                                    phoneNumberC: phoneNumberC,
                                    emailC: emailC,
                                    usernameC: usernameC,
                                    passwordC: passwordC),
                            ),
                          );
                        }
                      },
                      child: const Text('Verify via Phone OTP'),
                    ),
                    ]),
                    // OtpInput(
                    //   otpController: otpC,
                    //   onVerifyPressed: () async {
                    //     await _emailVerification.verifyEmailOTP(context, otpC.text, emailC.text, usernameC.text, passwordC.text, phoneNumberC.text);
                    //     String email = emailC.text;
                    //     String username = usernameC.text;
                    //     String password = passwordC.text;
                    //     String phone = phoneNumberC.text;
                    //     print(email);
                    //     print(username);
                    //     print(password);
                    //     EmailVerification(email1: email,
                    //         username1: username,
                    //         password1: password,
                    //         phone1: phone);
                    //   },
                    // ),
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
                      ),),]
              ),
            )
        )

    );
  }

//   Future<void> registerUser(String email, String password, String username, String phone) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     try {
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await usersCollection.add({
//         'username': username,
//         'email': email,
//         'uid': userCredential.user?.uid,
//         'password': password,
//         'phone': phone,
//       });
//       print(userCredential.user?.uid);
//       if (_isMounted) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Registration Successful'),
//               content: const Text('You can now sign in with your credentials.'),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushAndRemoveUntil(context,
//                       MaterialPageRoute(builder: (context) => Login()), (
//                           Route<dynamic> route) => false,);
//                     // Navigate to the login page or any other screen.
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//     catch (e) {
//       if (_isMounted) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Registration Failed'),
//               content: Text('Error: $e'),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }
// }
  Future<void> registerUser(String email, String password, String username,
      String phone) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await usersCollection.add({
        'username': username,
        'email': email,
        'uid': userCredential.user?.uid,
        'password': password,
        'phone': phone,
      });
      print(userCredential.user?.uid);
      if (_isMounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
              'Registration Successful. You can now sign in with your credentials.')),
        );
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
                (Route<dynamic> route) => false,
          );
        });
      }
    } catch (e) {
      if (_isMounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed: $e')),
        );
      }
    }
  }
}
  class TwilioService {
  final String accountSid = 'AC1b5eb38b535fb4409350c4dd7d8f0b6f';
  final String authToken = '622e3d18e5331828c934ff40d0215e88';
  final String serviceSid = 'VAf96df62c39052aa28a1718b05aeea0fc';
  Future<VerificationResult?> initiateVerification(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://verify.twilio.com/v2/Services/$serviceSid/Verifications'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64Encode(
              utf8.encode('$accountSid:$authToken'))}',
        },
        body: {
          'To': phoneNumber,
          'Channel': 'sms',
        },
      );
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String verificationSid = responseData['sid'];
        return VerificationResult(
          verificationSid: verificationSid,
          statusCode: response.statusCode,
        );
      } else {
        print('Error initiating verification: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error initiating verification: $e');
      return null;
    }
  }
  Future<bool> checkVerificationCode(String phoneNumber,String verificationSid,String code) async {
    try {
      if (verificationSid != null) {
        final response = await http.post(
          Uri.parse(
              'https://verify.twilio.com/v2/Services/$serviceSid/Verifications/$verificationSid'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Basic ${base64Encode(
                utf8.encode('$accountSid:$authToken'))}',
          },
          body: {
            'To': phoneNumber,
            'Code': code,
          },
        );
        print(response.body);

        return response.statusCode == 200 &&
            json.decode(response.body)['status'] == 'approved';
      }else{
        print('error: verificationSid not found');
        return false;
      }
    } catch (e) {
      print('Error checking verification code: $e');
      return false;
    }
  }
}
class PhoneVerification1 extends StatefulWidget {
  final TextEditingController phoneNumberC;
  final TextEditingController emailC;
  final TextEditingController usernameC;
  final TextEditingController passwordC;

  const PhoneVerification1({super.key, required this.phoneNumberC, required this.emailC, required this.usernameC, required this.passwordC});

  @override
  State<PhoneVerification1> createState() => _PhoneVerificationState(phoneNumberC: phoneNumberC,emailC: emailC,usernameC: usernameC,passwordC: passwordC);
}

class _PhoneVerificationState extends State<PhoneVerification1> {
  final TextEditingController phoneNumberC;
  final TextEditingController emailC;
  final TextEditingController usernameC;
  final TextEditingController passwordC;
  TextEditingController otpC = TextEditingController();
  var register = _RegisterState();
  var twilioService = TwilioService();
  TwilioFlutter? twilioFlutter;
  String? verificationSid;
  // void _navigateToOtpInputPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => OtpInputPage()),
  //   );
  // }

  _PhoneVerificationState({required this.phoneNumberC, required this.emailC, required this.usernameC, required this.passwordC});

  @override
  void initState() {
    super.initState();
    twilioFlutter = TwilioFlutter(
      accountSid: 'AC1b5eb38b535fb4409350c4dd7d8f0b6f',
      authToken: '622e3d18e5331828c934ff40d0215e88',
      twilioNumber: '+18557299201',
    );
  }

  @override
  void dispose() {
    twilioFlutter=null;
    super.dispose();
  }

  void sendOTP() async {
    String phoneNumber = phoneNumberC.text;
    VerificationResult? verificationResult = await twilioService.initiateVerification('+91'+phoneNumber);

    if(verificationResult != null) {
      verificationSid = verificationResult.verificationSid;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('OTP Sent'),
            content: const Text('An OTP has been sent to your phone number.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  //_navigateToOtpInputPage(); // Navigate to OTP input page
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle error when OTP cannot be sent
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to send OTP. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  void verifyOTP() async {
    String phoneNumber = phoneNumberC.text;
    String userEnteredOTP = otpC.text;
    var twilioService = TwilioService();


    if (verificationSid != null) {
      bool isVerified = await twilioService.checkVerificationCode( '+91' + phoneNumberC.text ,verificationSid!, userEnteredOTP);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('OTP Verified'),
            content: const Text('Your OTP has been successfully verified.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
            title: const Text('OTP Verification Failed'),
            content: const Text('Invalid OTP. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Diabetic App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 60),
              child: Text('Phone Verification', style: TextStyle(fontSize: 37.5, fontWeight: FontWeight.bold)),
            ),
            const Text('Phone Number', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 200,
                    child: TextField(controller: phoneNumberC, decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter your phone number'),),
                  ),
                ),
                TextButton(
                  onPressed: () => sendOTP(),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text('Send OTP'),
                ),
              ],
            ),
            const Text('OTP', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 200,
                    child: TextField(controller: otpC, decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter OTP'),),
                  ),
                ),
                TextButton(
                  onPressed: () => verifyOTP(),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  child: const Text('Verify OTP'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                register.registerUser(emailC.text,passwordC.text,usernameC.text,phoneNumberC.text);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    if(verificationSid != null) {
                      return AlertDialog(
                        title: Text('Registration Successful'),
                        content: Text(
                            'You can now sign in with your credentials.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Login()), // Ensure Login() is correctly instantiated
                                    (Route<dynamic> route) => false,
                              );
                              // Navigate to the login page or any other screen.
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    }else{
                      return AlertDialog(
                        title: Text('Registration Failed'),
                        content: Text(
                            'You need to verify first.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigate to the login page or any other screen.
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),),
              child: const Text('Register'),
            ),

          ],
        ),
      ),
    );
  }
}
