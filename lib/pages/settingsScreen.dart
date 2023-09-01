import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/main.dart';
import 'package:smart_resto/models/user_model.dart';
import 'package:smart_resto/size_config.dart';
import 'package:smart_resto/widgets/BottomNavBarWidget.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

class SettingsScreen extends StatefulWidget {
  final String auth_token;

  const SettingsScreen({Key? key, required this.auth_token}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool bottomSheet = false;
  bool _switchValue = false;
  bool _isVisible = false;

  bool inLoginProcess = false;

  dynamic _profilImg = AssetImage("assets/images/user1.png");

  getImage() async {
    var _pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    File _file = File(_pickedFile!.path);

    setState(() {
      _profilImg = FileImage(_file);
    });
  }

  Stream<User> _getUserValues() async* {
    while (true) {
      final _userData = await getUser(widget.auth_token);
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
                    extendBodyBehindAppBar: true,
                    bottomNavigationBar: BottomNavBarWidget(
                      index: 3,
                    ),
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    body: Stack(
                      children: <Widget>[
                        // The containers in the background
                        new Column(
                          children: <Widget>[
                            new Container(
                              height: 300,
                              decoration: BoxDecoration(color: kPrimaryColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: getProportionateScreenHeight(90),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showMenu(
                                              context: context,
                                              position: RelativeRect.fromLTRB(
                                                  10,
                                                  10,
                                                  10,
                                                  10), //here you can specify the location,
                                              items: [
                                                PopupMenuItem(
                                                  value: 0,
                                                  onTap: () {},
                                                  child: Text("Voir la photo"),
                                                ),
                                                PopupMenuItem(
                                                  value: 1,
                                                  onTap: () {},
                                                  child:
                                                      Text("Changer de photo"),
                                                ),
                                              ],
                                            ).then((value) {
                                              if (value == 0) {
                                                viewImage(context);
                                              } else if (value == 1) {
                                                getImage();
                                                print("change image");
                                              } else {}
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: _profilImg),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            height: 100,
                                            width: 100,
                                            child: Container(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              getProportionateScreenWidth(35),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                "${snapshot.data!.lastname} ${snapshot.data!.firstname} ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              child: Text(
                                                "Tél: +226 ${snapshot.data!.phone} ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    fontSize: 15),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              child: Builder(
                                                  builder: (context) =>
                                                      ElevatedButton(
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
                                                                      20.0),
                                                            ),
                                                            primary:
                                                                Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            modal(context);
                                                          },
                                                          child: Text(
                                                            "Modifier Profil",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ))),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [],
                                ),
                              ),
                            ))
                          ],
                        ),

                        Container(
                          alignment: Alignment.topCenter,
                          margin: new EdgeInsets.only(
                              top: 230, left: 15, right: 15),
                          child: new Container(
                            height: 500,
                            width: 350,
                            child: new Card(
                                elevation: 14.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: SingleChildScrollView(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Color(0xFF8a8a8a)),
                                      )),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Structure :",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${snapshot.data!.organizationName}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Color(0xFF8a8a8a)),
                                      )),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Groupe :",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${snapshot.data!.groupName}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Color(0xFF8a8a8a)),
                                      )),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Email :",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${snapshot.data!.email}",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.SCALE,
                                            dialogType: DialogType.NO_HEADER,
                                            body: PasswordChangingModal(
                                              auth_token: widget.auth_token,
                                            ),
                                            title:
                                                "Changement de mot de passe !",
                                          )..show();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Color(0xFF8a8a8a)),
                                          )),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Changer mon mot de passe",
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              Icon(_isVisible
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_right)
                                            ],
                                          ),
                                        )),
                                  ],
                                ))),
                          ),
                        )
                      ],
                    )); // returns null
          }
        },
      );
    }

    return futureMethod();
  }

  void modal(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return ChangeProfilBottom();
        });
  }

  dynamic viewImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.topCenter,
            content: Container(
              width: 250,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: _profilImg),
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          getImage();
                          Navigator.pop(context);
                        },
                        child: Text("Changer")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Fermer"))
                  ],
                ),
              )
            ],
          );
        });
  }

  showFloatingFlushbar(
    BuildContext context,
    String message,
  ) {
    Flushbar flush;

    flush = Flushbar<bool>(
      messageColor: Colors.green,
      message: message,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(20),
      icon: Icon(
        Icons.verified_user,
        color: Colors.green,
      ),
    ) // <bool> is the type of the result passed to dismiss() and collected by show().then((result){})
      ..show(context).then((result) {});
  }
}

class ChangeProfilBottom extends StatefulWidget {
  const ChangeProfilBottom({Key? key}) : super(key: key);

  @override
  State<ChangeProfilBottom> createState() => _ChangeProfilBottomState();
}

class _ChangeProfilBottomState extends State<ChangeProfilBottom> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool inLoginProcessBottom = false;

  var auth_token;

  void initState() {
    super.initState();
    readCredentials().then((String result) {
      setState(() {
        auth_token = result;
      });
      print("Auth_token reccupéré :" + auth_token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Nom",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: firstNameController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFebd6cf),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: kPrimaryColor,
                    ),
                    hintText: "Entrer votre nom",
                    hintStyle:
                        TextStyle(color: Color(0XFFc97a63), fontSize: 15),
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
                ),
                SizedBox(height: 15),
                Text(
                  "Prénoms",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: lastNameController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFebd6cf),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: kPrimaryColor,
                    ),
                    hintText: "Entrer votre prénom ",
                    hintStyle:
                        TextStyle(color: Color(0XFFc97a63), fontSize: 15),
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
                ),
                SizedBox(height: 15),
                Text(
                  "Numéro de téléphone",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                IntlPhoneField(
                  controller: phoneController,
                  dropdownTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFebd6cf),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                    ),
                    hintText: "Entrer votre numéro de téléphone",
                    hintStyle:
                        TextStyle(color: Color(0XFFc97a63), fontSize: 16),
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
                    print(phone.completeNumber);
                  },
                ),
              ],
            )),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 120,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Center(
                  child: inLoginProcessBottom
                      ? CircularProgressIndicator(
                          color: kPrimaryColor,
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            primary: kPrimaryColor,
                          ),
                          onPressed: () async {
                            setState(() {
                              inLoginProcessBottom = !inLoginProcessBottom;
                            });
                            int response = await changeInformations(
                                firstNameController.text.toUpperCase(),
                                lastNameController.text,
                                phoneController.text,
                                auth_token);

                            var internet = await internetCheck();

                            if (response == null) {
                              setState(() {
                                inLoginProcessBottom = !inLoginProcessBottom;
                              });
                              Fluttertoast.showToast(
                                  msg: "Echec de changement des informations !",
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
                                        : "Les informations entrées ne sont pas conformes\nVeuillez saisir des informations valides.",
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
                                inLoginProcessBottom = !inLoginProcessBottom;
                              });
                              Fluttertoast.showToast(
                                  msg: "Mise à jour de profil effectuée !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              firstNameController.clear();
                              lastNameController.clear();
                              phoneController.clear();
                              setState(() {});
                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                            child: Text(
                              "Modifier",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          )),
                ),
              )),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
    ;
  }
}

class PasswordChangingModal extends StatefulWidget {
  final String auth_token;
  const PasswordChangingModal({Key? key, required this.auth_token})
      : super(key: key);

  @override
  State<PasswordChangingModal> createState() => _PasswordChangingModalState();
}

class _PasswordChangingModalState extends State<PasswordChangingModal> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  ButtonState stateTextWithIcon = ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            child: TextFormField(
                controller: _password,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    hintText: "Nouveau mot de passe")),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 300,
            child: TextFormField(
                controller: _confirmPassword,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    hintText: "Confirmer mot de passe")),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: ProgressButton.icon(
                iconedButtons: {
                  ButtonState.idle: IconedButton(
                      text: "CHANGER",
                      icon: Icon(Icons.send, color: Colors.white),
                      color: kPrimaryColor),
                  ButtonState.loading: IconedButton(
                      text: "CONNEXION AU SERVEUR", color: kPrimaryColor),
                  ButtonState.fail: IconedButton(
                      text: "ECHEC",
                      icon: Icon(Icons.cancel, color: Colors.white),
                      color: Colors.red),
                  ButtonState.success: IconedButton(
                      text: "Success",
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      color: Colors.green.shade400)
                },
                onPressed: () async {
                  if (stateTextWithIcon == ButtonState.success) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      stateTextWithIcon = ButtonState.loading;
                    });

                    int response = await changePassword(_password.text,
                        _confirmPassword.text, widget.auth_token);

                    var internet = await internetCheck();

                    if (response == 0) {
                      setState(() {
                        stateTextWithIcon = ButtonState.fail;
                      });

                      Fluttertoast.showToast(
                          msg: "Echec de changement de mot de passe!",
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
                                : "Le mot de passe inséré n'est pas autorisé !\nVeuillez saisir un mot de passe valide.",
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
                        stateTextWithIcon = ButtonState.success;
                      });

                      Fluttertoast.showToast(
                          msg: "Changement de mot de passe réussi !",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      _password.clear();
                      _confirmPassword.clear();
                    }
                  }
                },
                state: stateTextWithIcon),
          )
        ],
      ),
    );
  }
}
