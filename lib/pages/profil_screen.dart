import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/user_model.dart';
import 'package:smart_resto/pages/FoodOrderPage.dart';
import 'package:smart_resto/pages/SignInPage.dart';
import 'package:smart_resto/pages/onboardingScreen.dart';
import 'package:smart_resto/pages/settingsScreen.dart';
import 'package:smart_resto/pages/walletScreen.dart';
import 'package:smart_resto/size_config.dart';

import 'package:smart_resto/widgets/BottomNavBarWidget.dart';
import 'package:smart_resto/widgets/profil_element.dart';

class Profil extends StatefulWidget {
  const Profil({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  List<Widget> spaces = [];
  bool inDeconnextionProcess = false;

  var auth_token;

  void initState() {
    super.initState();
    readCredentials().then((String result) {
      setState(() {
        auth_token = result;
      });

    });
  }

  Stream<User> _getUserValues() async* {
    while (true) {
      final _userData = await getUser(auth_token);
      await Future<void>.delayed(const Duration(seconds: 1));

      yield _userData;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget futureMethod() {
      return StreamBuilder<User>(
        stream: _getUserValues(), // async work
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/profil_font.PNG"))),
                  child: Container(
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(21),
                                  vertical: getProportionateScreenHeight(280)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/logo.jpg",
                                    scale: getProportionateScreenHeight(18),
                                  ),
                                  SpinKitChasingDots(
                                    color: kPrimaryColor,
                                    size: 50.0,
                                  ),
                                ],
                              ))),
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.9))),
                ),
              );
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return Scaffold(
                  body: Stack(
                    children: [
                      Container(
                          color: kPrimaryColor,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Text(
                                  "${snapshot.data!.lastname} ${snapshot.data!.firstname} ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Expanded(
                                  child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 125,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print("Mon Portefeuille");
                                              Navigator.push(
                                                  context,
                                                  ScaleRoute(
                                                      page: WalletScreen(
                                                    auth_token: auth_token,
                                                  )));
                                            },
                                            child: ProfilElement(
                                              svg: "assets/icons/Cash.svg",
                                              title: "Mon portefeuille",
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print("Mes Commandes");
                                              Navigator.push(
                                                  context,
                                                  ScaleRoute(
                                                      page: FoodOrderPage()));
                                            },
                                            child: ProfilElement(
                                              numOfItems: 3,
                                              svg: "assets/icons/Cart Icon.svg",
                                              title: "Mes commandes",
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print("Mes paramètres");
                                              Navigator.push(
                                                  context,
                                                  ScaleRoute(
                                                      page: SettingsScreen(
                                                    auth_token: auth_token,
                                                  )));
                                            },
                                            child: ProfilElement(
                                              svg: "assets/icons/Settings.svg",
                                              title: "Paramètres",
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: inDeconnextionProcess
                                                  ? CircularProgressIndicator(
                                                      color: kPrimaryColor,
                                                    )
                                                  : Container(
                                                      width: 300,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            shape:
                                                                new RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color:
                                                                      kPrimaryColor),
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      10.0),
                                                            ),
                                                            primary:
                                                                Colors.white,
                                                          ),
                                                          onPressed: () async {
                                                            AwesomeDialog(
                                                              context: context,
                                                              animType: AnimType
                                                                  .SCALE,
                                                              dialogType:
                                                                  DialogType
                                                                      .WARNING,
                                                              body: Center(
                                                                child: Text(
                                                                  "Voulez vous vraiment vous déconnecter de la plateforme ?\nCela entrainera une déconnexion à tous les services disponibles jusqu'à votre prochaine reconnexion.",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              title:
                                                                  "Connexion échouer!",
                                                              btnOkColor:
                                                                  kPrimaryColor,
                                                              btnCancelColor:
                                                                  kPrimaryColor,
                                                              btnOkText:
                                                                  "VALIDER",
                                                              btnCancelText:
                                                                  "ANNULER",
                                                              btnCancelOnPress:
                                                                  () {
                                                                Navigator.canPop(
                                                                    context);
                                                              },
                                                              btnOkOnPress:
                                                                  () async {
                                                                setState(() {
                                                                  inDeconnextionProcess =
                                                                      true;
                                                                });

                                                                var internet =
                                                                    await internetCheck();
                                                                int response =
                                                                    await logout(
                                                                        auth_token);

                                                                if (response ==
                                                                        null ||
                                                                    internet !=
                                                                        200) {
                                                                  setState(() {
                                                                    inDeconnextionProcess =
                                                                        false;
                                                                  });
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Echec de déconnexion !",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          16.0);
                                                                  AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    animType:
                                                                        AnimType
                                                                            .SCALE,
                                                                    dialogType:
                                                                        DialogType
                                                                            .ERROR,
                                                                    body:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        internet !=
                                                                                200
                                                                            ? "Echec de déconnexion au server\nVérifier votre connexion internet et réessayer !"
                                                                            : "Une erreur a intervenue lors de votre déconnexion\nVeuilez réessayer plus-tard.",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    title:
                                                                        "Connexion échouer!",
                                                                    btnOkColor:
                                                                        Colors
                                                                            .red,
                                                                    btnOkText:
                                                                        "OK",
                                                                    btnOkOnPress:
                                                                        () {
                                                                      Navigator
                                                                          .canPop(
                                                                              context);
                                                                    },
                                                                  )..show();
                                                                } else {
                                                                  setState(() {
                                                                    inDeconnextionProcess =
                                                                        false;
                                                                  });

                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Déconnexion du serveur réussie !",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          16.0);
                                                                  Navigator.push(
                                                                      context,
                                                                      ScaleRoute(
                                                                          page:
                                                                              LoginScreen()));
                                                                }
                                                              },
                                                            )..show();
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 25,
                                                                width: 25,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            20),
                                                                child: Icon(
                                                                  Icons.logout,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Déconnexion",
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                      )))
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 100),
                        alignment: Alignment.topCenter,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(100)),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 2),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(100)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image:  AssetImage(
                                          "assets/images/user1.png"))),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  bottomNavigationBar: BottomNavBarWidget(
                    index: 3,
                  ),
                ); // returns null
          }
        },
      );
    }

    return futureMethod();
  }
}
