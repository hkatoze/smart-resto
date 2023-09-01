import 'package:flutter/material.dart';



const kPrimaryColor = Color(0xFFc5543d);
Widget copyright() {
  return Container(
 
    child: Text(
      "Copyright-" + DateTime.now().year.toString() + " | Smart Touch Group",
      style: TextStyle(color: Color(0xFF787878), fontWeight: FontWeight.bold),
    ),
  );
}