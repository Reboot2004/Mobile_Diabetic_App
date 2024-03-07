//import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilediabeticapp/config.dart';
import 'package:provider/provider.dart';
import 'package:telephony_sms/telephony_sms.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'login.dart';
import 'register.dart';
import 'email.dart';
//import 'py.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
final CollectionReference users = FirebaseFirestore.instance.collection('users');

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.light(),
      themeMode: currentTheme.currentTheme(),
      home: Login(),
    );
  }
}




