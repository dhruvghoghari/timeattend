import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Userlogin extends StatefulWidget {
  const Userlogin({Key? key}) : super(key: key);

  @override
  State<Userlogin> createState() => _UserloginState();
}

class _UserloginState extends State<Userlogin> {
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _name,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "User Name",
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.0),
                      right: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _password,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  icon: Icon(Icons.lock_open_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.0),
                      right: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var username = _name.text.toString();
                var password = _password.text.toString();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                String os = Platform.operatingSystem;

                // String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwaS5lYXJ0aGNvbnRyb2xzeXMuY29tL2FwaS9sb2dpbiIsImlhdCI6MTcwMzU5MDkyMCwiZXhwIjoxNzAzNjc3MzIwLCJuYmYiOjE3MDM1OTA5MjAsImp0aSI6ImJRUWRvSE51aloyc0pZdkMiLCJzdWIiOiI4IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.ZMoSJN9sQ5ksVE5SO8RzlYMVGE5IxNVfiGGxr8JGpFE";

                Uri url = Uri.parse("https://api.earthcontrolsys.com/api/login");

                var params = {
                  "name": username,
                  "password": password,
                  "device_os": os,
                  // "accessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwaS5lYXJ0aGNvbnRyb2xzeXMuY29tL2FwaS9sb2dpbiIsImlhdCI6MTcwMzU5MDkyMCwiZXhwIjoxNzAzNjc3MzIwLCJuYmYiOjE3MDM1OTA5MjAsImp0aSI6ImJRUWRvSE51aloyc0pZdkMiLCJzdWIiOiI4IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.ZMoSJN9sQ5ksVE5SO8RzlYMVGE5IxNVfiGGxr8JGpFE",
                  // "token_type": "bearer",
                  // "expires_in": 8640000000,
                  // "token_id": 8
                };


                var headers = {
                  "Content-Type": "application/json"
                };

                var response = await http.post(url,body: jsonEncode(params), headers: headers);

                if (response.statusCode == 200)
                {
                  var json = jsonDecode(response.body.toString());
                  if (json.containsKey("Added Successfully"))
                  {
                    var message = json["Added Successfully"].toString();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.green,),);
                  }
                  else
                  {
                    var message = json["Added UnSuccessfully"].toString();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red,));
                  }
                }
                _name.text="";
                _password.text="";
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
