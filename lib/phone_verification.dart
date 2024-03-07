import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:telephony/telephony.dart';
import 'constants.dart';
import 'package:flutter/material.dart';



class PhoneVerification {
  PhoneVerification({required this.number});
//make sure number should not contain +91 and currently this package only works on Indian Phone Number
//example
//number = +919647812350(not allowed)
//number = 9647812350( allowed)
  final Telephony telephony = Telephony.instance;//this package is dependent on telephony and http package
  final String number;//number should not be null
  sendotp(String? message) async {
    int otp = 0;
    for (var i = 0; i < 4; i++) {
      otp = otp * 10 + (Random().nextInt(9) + 1);//4 digit otp
    }
    try {
      var res = await http.post(Uri.parse(url_sendotp),
          body: {'number': number, 'otp': otp.toString()});//storing the number and otp in the database
      String finalmessage =
          (message == null ? '' : message) + ' ' + otp.toString();
      var data = await jsonDecode(res.body);
      if (res.statusCode == 200 ||
          data.toString() == 'Success_1' ||
          data.toString() == 'Success_2') {
        telephony.sendSms(to: number, message: finalmessage);//sending automatic sms
      } else {
        if (kDebugMode) {
          print(res.statusCode.toString() + data.toString());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> verifyotp(String enteredotp) async {
    try {
      var res =
      await http.post(Uri.parse(url_receiveotp), body: {'number': number});//collecting otp for the given number
      print(res);
      if (res.statusCode == 200) {
        var data = await jsonDecode(res.body);
        if (data[0]['otp_string'].toString() == enteredotp) {//checking otp
          if (kDebugMode) {
            print('Otp Verified 👍');
          }

          await http.post(Uri.parse(url_verification_complete),//creating space so that the limited database should be utilise properly
              body: {'number': number});

          return true;
        } else {
          if (kDebugMode) {
            print('Otp Not Verified 👎');
          }
          return false;
        }
      } else {
        if (kDebugMode) {
          print(res.statusCode.toString() + 'Error');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Verification Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Enter Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retrieve the entered phone number
                String phoneNumber = _numberController.text.trim();

                // Check if the phone number is not empty
                if (phoneNumber.isNotEmpty) {
                  // Creating an instance of PhoneVerification
                  PhoneVerification phoneVerification =
                  PhoneVerification(number: phoneNumber);

                  // Sending OTP
                  print('Sending OTP...');
                  phoneVerification.sendotp("hello"); // You can pass a message here if needed
                  print('OTP Sent!');
                } else {
                  // Show an error message if the phone number is empty
                  print('Please enter a valid phone number.');
                }
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}