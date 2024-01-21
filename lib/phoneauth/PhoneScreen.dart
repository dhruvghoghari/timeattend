import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeattend/phoneauth/Otpscreen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Image.asset("img/phone.png"),
            Text("Enter Verify PhoneNumber ",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: TextField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Enter Phone Number",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            prefixIcon: IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () {},
                            ),
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
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                  verificationCompleted: (PhoneAuthCredential credential) {},
                                  verificationFailed: (FirebaseAuthException ex) {},
                                  codeSent: (String verificationid, int? resendtoken) {

                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => OtpScreen(
                                      verificationid: verificationid,))
                                    );
                                  },
                                  codeAutoRetrievalTimeout: (String verificationid) {},
                                  phoneNumber: _phone.text.toString());
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.black),
                            ),
                            child: Text("Verify", style:
                                  TextStyle(fontSize: 20.0, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
