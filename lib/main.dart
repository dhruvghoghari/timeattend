import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeattend/HomeScreen.dart';
import 'package:timeattend/SignIn.dart';
import 'package:timeattend/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timeattend/emailauth/CheckUser.dart';
import 'Forgotpassword.dart';
import 'Userlogin.dart';
import 'emailauth/Signup.dart';
import 'firebase_options.dart';
import 'phoneauth/Otpscreen.dart';
import 'phoneauth/PhoneScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", "12345678");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Userlogin(),
    );
  }
}
