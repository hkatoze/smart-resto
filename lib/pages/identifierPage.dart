import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';

import 'package:smart_resto/pages/SignInPage.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:smart_resto/size_config.dart';

class UserIdentifier extends StatefulWidget {
  const UserIdentifier({Key? key}) : super(key: key);

  @override
  _UserIdentifierState createState() => _UserIdentifierState();
}

class _UserIdentifierState extends State<UserIdentifier> {
  bool inLoginProcess = false;
  TextEditingController identifier_code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(70),
                  ),
                  Container(
                    width: getProportionateScreenHeight(500),
                    height: getProportionateScreenHeight(200),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.jpg"))),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(70),
                  ),
                  Text(
                    "Veuillez entrer votre code identifiant",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: getProportionateScreenHeight(70)),
                  Center(
                    child: PinCodeTextField(
                      controller: identifier_code,
                      pinTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.bold),
                      pinBoxColor: Color(0xFFcfa07f),
                      autofocus: true,
                      highlight: true,
                      highlightColor: kPrimaryColor,
                      defaultBorderColor: Color(0xFFcfa07f),
                      hasTextBorderColor: Color(0xFFcfa07f),
                      highlightPinBoxColor: Color(0xFFcfa07f),
                      maxLength: 6,
                      pinBoxRadius: 12,
                      pinBoxHeight: 52,
                      pinBoxWidth: 50,
                      wrapAlignment: WrapAlignment.spaceBetween,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(70),
                  ),
                  Container(
                    width: getProportionateScreenWidth(310),
                    child: inLoginProcess
                        ? Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              primary: kPrimaryColor,
                            ),
                            onPressed: () async {
                              setState(() {
                                inLoginProcess = true;
                              });
                              String response =
                                  await codeChecked(identifier_code.text);

                              var internet = await internetCheck();

                              if (response == "200") {
                                setState(() {
                                  inLoginProcess = false;
                                });

                                Fluttertoast.showToast(
                                    msg: "Identification réussie !",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.SCALE,
                                  dialogType: DialogType.SUCCES,
                                  body: Center(
                                    child: Text(
                                      "Vérifier votre messagerie et renseigner les informations d'utilisateur pour continuer",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: "Identification réussie !",
                                  btnOkText: "OK",
                                  btnOkOnPress: () {
                                    Navigator.push(context,
                                        ScaleRoute(page: LoginScreen()));
                                  },
                                )..show();
                              } else {
                                setState(() {
                                  inLoginProcess = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "Echec de l'identification !",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.SCALE,
                                  dialogType: DialogType.ERROR,
                                  onDissmissCallback: (DismissType value) {
                                    identifier_code.clear();
                                  },
                                  body: Center(
                                    child: Text(
                                      internet != 200
                                          ? "Echec de connexion au server\nVérifier votre connexion internet et réessayer !"
                                          : "Code identifiant invalide !\nAssurer vous que votre code identifiant est valide et réessayer.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: "Identification réussie !",
                                  btnOkColor: Colors.red,
                                  btnOkText: "REESAYER",
                                  btnOkOnPress: () {
                                    Navigator.canPop(context);
                                    identifier_code.clear();
                                  },
                                )..show();
                              }
                            },
                            child: Text(
                              "Valider",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                  ),
                ],
              ))),
              copyright()
            ],
          ),
        ),
      ),
    ));
  }
}
