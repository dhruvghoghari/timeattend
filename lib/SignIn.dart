import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeattend/Forgotpassword.dart';
import 'package:timeattend/HomeScreen.dart';
import 'package:timeattend/emailauth/CheckUser.dart';
import 'package:timeattend/emailauth/Signup.dart';
import 'package:timeattend/emailauth/uihelper.dart';
import 'package:timeattend/phoneauth/PhoneScreen.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  login(String email,String password) async
  {
    if(email=="" && password=="")
    {
      return uiHelper.customAlertbox(context, "Enter Email");
    }
    else
    {
      UserCredential? userCredential;
      try
      {
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async {

          var em = email.toString();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email",email);

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
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            color: Color(0xffba4ffb),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      GestureDetector(onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup())
                        );
                      },
                        child: Text("Sign Up", style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Sign In", style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet Conses-tear estimate."
                          " Ulm faucets quits at eu.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                ),
                color: Color(0xffFFFFFF),
              ),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email ID or Employee Code",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.email_outlined),
                              onPressed: () {
                              },
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffFE7551)),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                              },
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffFE7551)),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                          ),
                        ),
                      ),
                    ),
                    Align(alignment: Alignment.centerRight,
                        child: GestureDetector(onTap: (){

                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ForgotPassword())
                          );

                        },
                          child: Text("Forgot Password?",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                      ),),
                        ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: 380.0,
                      height: 50.0,
                      child: ElevatedButton(onPressed: ()async{

                        login(email.text.toString(), password.text.toString());

                      },  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),

                          child: Text("Sign In",style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),)),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(onTap: () async{
                      final GoogleSignIn googleSignIn = GoogleSignIn();
                      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
                      if (googleSignInAccount != null) {
                        final GoogleSignInAuthentication googleSignInAuthentication =
                            await googleSignInAccount.authentication;
                        final AuthCredential authCredential = GoogleAuthProvider.credential(
                            idToken: googleSignInAuthentication.idToken,
                            accessToken: googleSignInAuthentication.accessToken);

                        // Getting users credential
                        UserCredential result = await auth.signInWithCredential(authCredential);
                        User user = result.user!;


                        var name = user.displayName.toString();
                        var email = user.email.toString();
                        var photo = user.photoURL.toString();
                        var googleid = user.uid.toString();

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("name",name);
                        prefs.setString("isLogin","yes");
                        prefs.setString("email",email);
                        prefs.setString("photo",photo);
                        prefs.setString("googleid",googleid);


                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomeScreen())
                        );
                      }
                    },
                      child: Container(
                        width: 380.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("img/Google logo.png"),
                            ),
                            Text("Continue with Google",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                            SizedBox(width: 93.0),
                            Image.asset("img/backarrow.png"),
                          ],
                        ),
                      ),
                    ),            // Login With Google
                    SizedBox(height: 15.0),
                    GestureDetector(onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhoneScreen())
                      );
                    },
                      child: Container(
                        width: 380.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("img/phone-icon.png"),
                            ),
                            Text("Continue with Phone",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                            SizedBox(width: 100.0),
                            Image.asset("img/backarrow.png"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

