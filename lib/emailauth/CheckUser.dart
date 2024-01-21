import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeattend/HomeScreen.dart';
import 'package:timeattend/SignIn.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({Key? key}) : super(key: key);

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {

  checkUser()
  {
    final user = FirebaseAuth.instance.currentUser;
    if(user==null)
      {
        return HomeScreen();
      }
    else
      {
        return SignIn();
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}
