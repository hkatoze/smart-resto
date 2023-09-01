import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/pages/SignInPage.dart';
import 'package:smart_resto/pages/numberChecked.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:smart_resto/size_config.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController mailController = TextEditingController();
  bool insendProcess = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: kPrimaryColor,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(25),
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
              height: getProportionateScreenHeight(110),
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
                                    height: getProportionateScreenHeight(15)),
                                Text(
                                  "Mot de passe oublié ?",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Text(
                                  "Veuillez renseigner votre addresse e-mail",
                                  style: TextStyle(
                                      color: Color(0xFFedada0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Vous recevrez un mail pour réinitialiser votre mot de passe",
                                  style: TextStyle(
                                      color: Color(0xFFedada0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(50)),
                                Text(
                                  "Addresse e-mail",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                TextFormField(
                                  controller: mailController,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFebd6cf),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: kPrimaryColor, width: 1.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "Entrer votre addresse mail",
                                    hintStyle: TextStyle(
                                        color: Color(0XFFc97a63), fontSize: 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Color(0XFFc97a63),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          insendProcess
                              ? CircularProgressIndicator(
                                  color: kPrimaryColor,
                                )
                              : Container(
                                  width: getProportionateScreenWidth(340),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(15),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0),
                                        ),
                                        primary: kPrimaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          insendProcess = true;
                                        });

                                        var internet = await internetCheck();
                                        String response = await forgetPassword(
                                            mailController.text);

                                        if (response == null ||
                                            internet != 200) {
                                          setState(() {
                                            insendProcess = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: "Echec de la connexion !",
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
                                            body: Center(
                                              child: Text(
                                                internet != 200
                                                    ? "Echec de connexion au server\nVérifier votre connexion internet et réessayer !"
                                                    : "Votre addresse mail n'est pas valide\nVeuillez entrer une adresse mail correcte !.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            title: "Connexion échouer!",
                                            btnOkColor: Colors.red,
                                            btnOkText: "OK",
                                            btnOkOnPress: () {
                                              Navigator.canPop(context);
                                            },
                                          )..show();
                                        } else {
                                          setState(() {
                                            insendProcess = false;
                                          });

                                          Fluttertoast.showToast(
                                              msg:
                                                  "Réinitialisation de mot de passe réussie !",
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
                                                "Consulter votre boite mail et suivez la procédure pour créer votre nouveau mot de passe.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            title: "Connexion réussie !",
                                            btnOkColor: Colors.green,
                                            btnOkText: "OK",
                                            btnOkOnPress: () {
                                              Navigator.push(
                                                  context,
                                                  ScaleRoute(
                                                      page: LoginScreen()));
                                            },
                                          )..show();
                                        }
                                      },
                                      child: Text(
                                        "Envoyer",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                ),
                          SizedBox(
                            height: getProportionateScreenHeight(180),
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
