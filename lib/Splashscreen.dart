import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeattend/HomeScreen.dart';
import 'package:timeattend/emailauth/CheckUser.dart';
import 'package:timeattend/welcomePage.dart';
import 'SignIn.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {



  loginData() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("isLogin"))
    {
      Navigator.pop(context);
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
    else
    {
      Navigator.pop(context);
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => welcomePage()),
      );
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      loginData();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(158, 0, 255, 0.70),
              Color.fromRGBO(31, 12, 43, 0.35),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("img/logo.png"),
            ),
          ],
        ),

      ),
    );
  }
}
