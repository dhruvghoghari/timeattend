import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeattend/HomeScreen.dart';
import 'package:timeattend/emailauth/uihelper.dart';


class Signup extends StatefulWidget {

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController firstController=TextEditingController();
  TextEditingController lastController=TextEditingController();


  signup(String email,String password, String first,String last) async {
    if(email=="" && password=="" && first=="" && last=="")
      {
        uiHelper.customAlertbox(context, "Enter Required Filed");
      }
    else
      {
        UserCredential? userCredential;
        try
        {
          userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            return null;
          });
        }
        on FirebaseAuthException catch(ex)
    {
      return uiHelper.customAlertbox(context, ex.code.toString());
    }
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffba4ffb) ,
        body:SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text("Sign In", style: TextStyle(
                      fontSize: 18.0,
                    ),
                    ),
                  ],
                ),
              ),
              Text("Sign Up", style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),),
              Text("To get the chosen plan, you need to"
                  " register the account.", style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20.0),
              Expanded(
                child: Container(
                  height: 800.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          uiHelper.CustomTextField(firstController, "Firstname",Icons.person,false),
                          uiHelper.CustomTextField(lastController, "Lastname",Icons.person_add_alt_1_outlined,false),
                          uiHelper.CustomTextField(emailController, "Email Id", Icons.email_outlined, false),
                          uiHelper.CustomTextField(passwordController, "Password", Icons.lock, true),

                          SizedBox(height: 30.0),

                          Container(
                            width: 360.0,
                            height: 50.0,
                            child: ElevatedButton(onPressed: ()async{

                              signup(firstController.text.toString(),lastController.text.toString(),emailController.text.toString(), passwordController.text.toString());

                            },  style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            ),

                                child: Text("Next",style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white
                                ),)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     uiHelper.CustomTextField(emailController, "Email Id", Icons.email_outlined, false),
        //     uiHelper.CustomTextField(passwordController, "Password", Icons.lock, true),
        //
        //     SizedBox(height: 30.0),
        //
        //     uiHelper.customButton(() {
        //       signup(emailController.text.toString(), passwordController.text.toString());
        //     }, "Sign Up"),
        //
        //   ],
        // )
    );
  }
}
