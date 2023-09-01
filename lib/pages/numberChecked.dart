import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/pages/SignInPage.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:smart_resto/size_config.dart';

class NumberCheck extends StatefulWidget {
  const NumberCheck({Key? key}) : super(key: key);

  @override
  _NumberCheckState createState() => _NumberCheckState();
}

class _NumberCheckState extends State<NumberCheck> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        color: kPrimaryColor,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: getProportionateScreenWidth(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7)),
                child: ClipRect(
                  child: Icon(
                    Icons.arrow_back,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(90),
            ),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17),
                            topRight: Radius.circular(17))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: getProportionateScreenHeight(25),
                                ),
                                Text(
                                  "Code de vérification",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.verified_user,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(10),
                                    ),
                                    Text(
                                      "Veuillez entrer le code",
                                      style: TextStyle(
                                          color: Color(0xFFedada0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: getProportionateScreenHeight(30)),
                                Center(
                                  child: PinCodeTextField(
                                    pinTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                    pinBoxColor: Color(0xFFcfa07f),
                                    autofocus: true,
                                    pinBoxOuterPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    highlight: true,
                                    highlightColor: kPrimaryColor,
                                    defaultBorderColor: Color(0xFFcfa07f),
                                    hasTextBorderColor: Color(0xFFcfa07f),
                                    highlightPinBoxColor: Color(0xFFcfa07f),
                                    maxLength: 4,
                                    pinBoxRadius: 12,
                                    pinBoxHeight: 46,
                                    pinBoxWidth: 46,
                                    wrapAlignment: WrapAlignment.spaceBetween,
                                  ),
                                ),
                                SizedBox(height: getProportionateScreenHeight(30)),
                              ],
                            )),
                          ),
                          Container(
                            width: getProportionateScreenWidth(280),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  primary: kPrimaryColor,
                                ),
                                onPressed: () {
                              
                                },
                                child: Text(
                                  "Envoyer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(320),
                          ),
                          copyright()
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
