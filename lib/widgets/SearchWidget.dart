import 'package:flutter/material.dart';
import 'package:smart_resto/constants.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,top: 5,right: 10,bottom: 5),
      child: TextField(

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              width: 0,
              color: kPrimaryColor,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: kPrimaryColor,
          ),
          fillColor: Color(0xFFFAFAFA),
          suffixIcon: Icon(Icons.sort,color: kPrimaryColor,),
          hintStyle: new TextStyle(color: Color(0xFFd0cece), fontSize: 18),
          hintText: "Que voulez vous manger ?",
        ),
      ),
    );
  }
}
