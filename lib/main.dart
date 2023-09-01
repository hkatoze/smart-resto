import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:smart_resto/animation/RotationRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/user_model.dart';
import 'package:smart_resto/pages/HomePage.dart';


import 'package:smart_resto/pages/onboardingScreen.dart';
import 'package:get/get.dart';
import 'package:smart_resto/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Roboto', hintColor: Color(0xFFd0cece)),
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth_token = "";

  var internet;

  @override
  void initState() {
    super.initState();

    readCredentials().then((String result) {
      setState(() {
        auth_token = result;
      });
    });
    internetCheck().then((int result) {
      setState(() {
        internet = result;
      });
    });
  }

  Stream<User> _getUserValues(String auth_token_pass) async* {
    final _userData = await getUser(auth_token_pass);

    yield _userData;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Widget futureMethod() {
      var user;
      return StreamBuilder<User>(
        stream: _getUserValues(auth_token), // async work
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          print(snapshot.data);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                  body: Center(
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
                          ))));
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return snapshot.data!.email == "email"
                    ? (internet != 200 ? ErrorConnexion() : OnboardingScreen())
                    : HomePage(); // returns null
          }
        },
      );
    }

    return futureMethod();
  }
}

class ErrorConnexion extends StatefulWidget {
  const ErrorConnexion({Key? key}) : super(key: key);

  @override
  State<ErrorConnexion> createState() => _ErrorConnexionState();
}

class _ErrorConnexionState extends State<ErrorConnexion> {
  @override
  Widget build(BuildContext context) {
    void showAlert(BuildContext context) {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        body: Center(
          child: Text(
            "Echec de connexion au server\nVérifier votre connexion internet et réessayer !",
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
          exit(0);
        },
      )..show();
    }

    Future.delayed(Duration.zero, () => showAlert(context));
    return Scaffold();
  }
}
