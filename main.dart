import 'package:credit_score/admin/addcustomer.dart';
import 'package:credit_score/admin/admin.dart';
import 'package:credit_score/admin/adminprofile.dart';
import 'package:credit_score/chatbot/bot.dart';
import 'package:credit_score/chatbot/splash.dart';
import 'package:credit_score/customer/customer.dart';
import 'package:credit_score/admin/loans.dart';
import 'package:credit_score/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:credit_score/gpt3/chat_screen.dart';
import 'package:credit_score/admin/updatecustomer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: LoginPage(),
      routes: {
        '/update': (context) => UpdateCustomerScreen(),
      },
    );
  }
}
