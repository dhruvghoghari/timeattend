import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeattend/HomeScreen.dart';

class OtpScreen extends StatefulWidget {
  String verificationid;
  OtpScreen({required this.verificationid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset("img/phone.png"),
              Text("Enter Otp ",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Text("A 4 digit code has been sent"
                " to example@gmail.com",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              Expanded(
                child: Container(
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: TextField(
                          controller: _otp,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Enter Otp",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                          ),
                        ),
                      ),
                Container(
                  width: 250.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationid,
                          smsCode: _otp.text.toString(),
                        );
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                      catch (ex)
                      {
                        print('Verification failed: $ex');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text("Verify",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                )
                ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
