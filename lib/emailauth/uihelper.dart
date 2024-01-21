import 'package:flutter/material.dart';

class uiHelper
{

  static CustomTextField(TextEditingController controller,String text,IconData iconData,bool toHide)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          )
        ),
      ),
    );
  }


  static customButton(VoidCallback voidCallback,String text,)
  {
    return SizedBox(height: 50.0,width: 350.0,child: ElevatedButton(onPressed: () {
      voidCallback();
    },style: ElevatedButton.styleFrom(shape:
        RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),)
    ),child: Text(text,style: TextStyle(
      fontSize: 20.0,
      color: Colors.white
    ),)));
  }


  static customAlertbox(BuildContext context, String text) {
    showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Ok"))
          ],
        );
      },
    );
  }

}
