import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/user_model.dart';
import 'package:smart_resto/pages/HomePage.dart';
import 'package:smart_resto/pages/forgetPassword.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:smart_resto/size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  bool inLoginProcess = false;
  String _password = '';
  String _phone = '';
  TextEditingController passwordController = TextEditingController();
  var auth_token = "";

  void initState() {
    super.initState();
    auth_token = "";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          body: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                Container(
                  height: getProportionateScreenHeight(190),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.jpg"))),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Container(
                    child: Text(
                  "Connexion",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      Text(
                        "Numéro de téléphone",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      IntlPhoneField(
                        dropdownTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFebd6cf),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: kPrimaryColor,
                          ),
                          hintText: "Votre numéro de téléphone",
                          hintStyle:
                              TextStyle(color: Color(0XFFc97a63), fontSize: 18),
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
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        initialCountryCode: 'BF',
                        onChanged: (phone) {
                          setState(() {
                            _phone = phone.number;
                          });
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text(
                        "Mot de passe",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: showPassword,
                            obscuringCharacter: "*",
                            onChanged: (password) {
                              setState(() {
                                _password = password;
                              });
                            },
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFebd6cf),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                child: Icon(
                                  showPassword == false
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: kPrimaryColor,
                              ),
                              hintText: "Entrer votre mot de passe",
                              hintStyle: TextStyle(
                                  color: Color(0XFFc97a63), fontSize: 18),
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
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          )),
                    ],
                  )),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: ForgetPassword()));
                      },
                      child: Text(
                        "Mot de passe oublié ?",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      )),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Container(
                  width: getProportionateScreenWidth(340),
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
                            var response =
                                await loginChecked(_phone, _password);
                            var internet = await internetCheck();

                            if (response.auth_token != "auth_token") {
                              setState(() {
                                inLoginProcess = false;
                              });

                              //await writeCredentials(response.auth_token);
                              //await writeId(response.user.id.toString());

                              Fluttertoast.showToast(
                                  msg: "Connexion réussie !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              Navigator.push(
                                  context, ScaleRoute(page: HomePage()));
                            } else {
                              setState(() {
                                inLoginProcess = false;
                              });

                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.ERROR,
                                body: Center(
                                  child: Text(
                                    internet != 200
                                        ? "Echec de connexion au server\nVérifier votre connexion internet et réessayer !"
                                        : "Vos identifiants sont invalides !\nVérifier votre messagerie pour voir vos identifiants et réessayer.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: "Connexion échouer!",
                                btnOkColor: Colors.red,
                                btnOkText: "REESAYER",
                                btnOkOnPress: () {
                                  Navigator.canPop(context);
                                },
                              )..show();
                            }
                          },
                          child: Text(
                            "Se connecter",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                )
              ],
            ))),
            copyright()
          ],
        ),
      )),
    );
  }
}
