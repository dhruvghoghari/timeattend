import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeattend/SignIn.dart';
import 'package:timeattend/welcomePage.dart';
import 'package:uuid/uuid.dart';
import 'package:country_code_picker/country_code_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _search = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? selectedFile;
  var Isloading=false;

  PageController _pageController = PageController();
  int _currentIndex = 0;


  var name = "";
  var email ="";
  var photo ="";
  var googleId ="";

  getData() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name").toString();
      email= prefs.getString("email").toString();
      photo= prefs.getString("photo").toString();
      googleId= prefs.getString("googleId").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  logout() async
  {
    FirebaseAuth.instance.signOut().then((value){
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => SignIn())
      );
    });
  }
  // final items = <BottomNavigationBarItem>[
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.home, size: 30),
  //     label: 'Home',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.search, size: 30),
  //     label: 'Search',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.favorite, size: 30),
  //     label: 'Favorites',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.settings, size: 30),
  //     label: 'Settings',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.person, size: 30),
  //     label: 'Profile',
  //   ),
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications_active_outlined),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'User Profile',
      //     ),
      //   ],
      //   selectedItemColor: Colors.deepPurple,
      //   unselectedItemColor: Colors.black,
      //   backgroundColor: Colors.grey.shade200,
      //   elevation: 5.0,
      //   selectedFontSize: 15.0,
      // ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        buttonBackgroundColor: Colors.white,
        height: 65,
        items: const <Widget>[
          Icon(Icons.home, size: 35),
          Icon(Icons.camera, size: 35),
          Icon(Icons.favorite, size: 35),
          Icon(Icons.person, size: 35),
          Icon(Icons.phone, size: 35)
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
        index: _currentIndex,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          setState(() {
            Isloading=true;
          });

          var uuid = Uuid();
          var filename = uuid.v1();

          // await FirebaseStorage.instance.ref(filename).putFile(selectedFile!)
          //     .whenComplete((){}).then((fileData) async{
          //   await fileData.ref.getDownloadURL().then((fileUrl) async{
          //     await FirebaseFirestore.instance.collection("TRIP MASTER").add({
          //       "filename":filename,
          //       "fileUrl":fileUrl
          //     }).then((value){
          //       print("Insert Successfully");
          //     });
          //     setState(() {
          //       Isloading=false;
          //     });
          //   });
          // });


        },
        child: Icon(Icons.photo_library_outlined),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("img/TimeAttend.png"),
        actions: [
          IconButton(
            onPressed: () async{

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();

              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.signOut();

              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => welcomePage())
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Name :- "+name),
              accountEmail: Text("Email :- "+email),
              currentAccountPicture: CircleAvatar(
                  child: Image.network(photo)
              ),
            ),
      ListTile(
        leading: Icon(Icons.dashboard),
        title: Text('Select Country'),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return CountryCodePicker(
                onChanged: print,
                initialSelection: 'IT',
                favorite: const ['+91', 'FR'],
                countryFilter: const ['IT', 'FR'],
                showFlagDialog: false,
                comparator: (a, b) => b.name!.compareTo(name),
                // Get the country information relevant to the initial selection
                onInit: (code) => debugPrint(
                    "on init ${code!.name} ${code.dialCode} ${code.name}"),
              );
            },
          );
        },
      ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                // Add your functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.price_change_outlined),
              title: Text('Pricing'),
              onTap: () {
                // Add your functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark),
              title: Text('FAQ'),
              onTap: () {
                // Add your functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('About Us'),
              onTap: () {
                // Add your functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text('Contact Us'),
              onTap: () {
                // Add your functionality here
              },
            ),
            SizedBox(height: 180.0),
            Image.asset("img/TimeAttend.png")
          ],
        ),
      ),
      body:
      // (Isloading==true)?Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _search,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Search Here",
                    filled: true,
                    fillColor: Color(0xffFFFFFF),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Add your search functionality here
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFFFFFF)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  ),
                ),
              ),
              SizedBox(height: 13.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset("img/plane.jpg"),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset("img/bike.png"),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset("img/train.png"),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset("img/carr.png"),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Popular Destination",style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("See All",style: TextStyle(
                      fontSize: 15.0,
                    color: Colors.grey
                  ),),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width,
                height:  280,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      child:Row(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    selectedFile = File(image!.path);
                                  });
                                },
                                child: Container(
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.asset(
                                      "img/london.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "London",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                "\$2000",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),

                            ],
                          ),
                          SizedBox(width: 10.0),

                          Column(
                            children: [
                              Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset("img/paris.jpg", fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text("Paris", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              ),
                              Text("\$5000", style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.0),

                          Column(
                            children: [
                              Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset("img/india.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text("india", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              ),
                              Text("\$8000", style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Adventure Trips ",style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),),
                  Text("See All",style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey
                  ),),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width,
                height:  280,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      child:Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset("img/london.jpg", fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text("London", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              ),
                              Text("\$2000", style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.0),

                          Column(
                            children: [
                              Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset("img/paris.jpg", fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text("Paris", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              ),
                              Text("\$5000", style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.0),

                          Column(
                            children: [
                              Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset("img/india.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text("india", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              ),
                              Text("\$8000", style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
