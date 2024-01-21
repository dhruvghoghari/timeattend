import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeattend/emailauth/Signup.dart';
import 'package:timeattend/emailauth/uihelper.dart';
import '../HomeScreen.dart';


class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {


  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  login(String email,String password) async{
    if(email=="" && password=="")
      {
        return uiHelper.customAlertbox(context, "Enter Email");
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
      appBar: AppBar(title: Text("LoginPage"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          uiHelper.CustomTextField(emailController, "Email", Icons.email_outlined, false),
          uiHelper.CustomTextField(passwordController, "Password", Icons.lock, true),

          SizedBox(height: 30.0),

          uiHelper.customButton(() {
            login(emailController.text.toString(), passwordController.text.toString());},
              "login"),

          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already Have An Account?",style: TextStyle(fontSize: 15.0),),
              TextButton(onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );

              }, child: Text("Sign Up",style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500
              ),))
            ],
          )
        ],
      ),
    );
  }
}
