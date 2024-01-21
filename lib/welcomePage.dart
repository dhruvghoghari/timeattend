import 'package:flutter/material.dart';
import 'package:timeattend/SignIn.dart';
import 'package:timeattend/emailauth/Signup.dart';

class welcomePage extends StatefulWidget {

  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("img/launchericon.png",
            ),
            SizedBox(height: 130.0,),
        Container(
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
          height: 300.0,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Welcome",style: TextStyle(
                      fontSize: 30.0,
                      fontWeight:FontWeight.bold
                    ),),
                  ],
                ),
                Text("This is the most useful application for "
                    "managing attendance of the staff.",style: TextStyle(
                  fontSize: 18.0,
                ),),
                SizedBox(height: 50.0,width: 50,),
                Row(
                  children: [
                    Container(
                      width: 140.0,
                      height: 50.0,
                      child: ElevatedButton(onPressed: (){

                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );

                      },  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),

                          child: Text("Sign In",style: TextStyle(
                        fontSize: 20.0,
                            color: Colors.white
                      ),)),
                    ),
                    SizedBox(width: 40,),
                    Container(
                      width: 140.0,
                      child: ElevatedButton(onPressed: (){

                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup())
                        );

                      }, child: Text("Sign Up",style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black
                      ),)),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
        ],
        ),
      ),
    );
  }
}
