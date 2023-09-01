import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/amount_model.dart';
import 'package:smart_resto/size_config.dart';
import 'package:smart_resto/widgets/BottomNavBarWidget.dart';
import 'package:smart_resto/widgets/transactionItem.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:flutter_svg/flutter_svg.dart';

class WalletScreen extends StatefulWidget {
  final String auth_token;
  const WalletScreen({Key? key,required this.auth_token}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
 

  Stream<Amount> _getAmountValues() async* {
    

    while (true) {
      final _amountData = await getAmount(widget.auth_token);
      await Future<void>.delayed(const Duration(seconds: 1));

      yield _amountData;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget futureMethod() {
      return StreamBuilder<Amount>(
        stream: _getAmountValues(), // async work
        builder: (BuildContext context, AsyncSnapshot<Amount> snapshot) {
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
                    bottomNavigationBar: BottomNavBarWidget(
                      index: 3,
                    ),
                    extendBodyBehindAppBar: true,
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
                        new Column(
                          children: <Widget>[
                            new Container(
                              height: 360,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/back.jpg"))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: getProportionateScreenHeight(90),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      "Solde Actuel",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(12),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "Frs",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                  Container(
                                                    height: 20,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        10),
                                              ),
                                              Text(
                                                "${snapshot.data!.solde}",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: SvgPicture.asset(
                                              "assets/icons/graph.svg",
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    TransactionItem(
                                        title: "Achat de 3 tickets",
                                        amount: "-1500Frs",
                                        date: "15:52 Mardi 17",
                                        type: "Achat",
                                        icon: Icons.food_bank),
                                    TransactionItem(
                                        title: "Dépôt sur mon portefeuille",
                                        amount: "+2000Frs",
                                        date: "15:52 Jeudi 15",
                                        type: "Dépôt",
                                        icon: Icons.payment),
                                    TransactionItem(
                                        title: "Achat de 3 tickets",
                                        amount: "-1500Frs",
                                        date: "15:52 Mardi 17",
                                        type: "Achat",
                                        icon: Icons.food_bank),
                                    TransactionItem(
                                        title: "Dépôt sur mon portefeuille",
                                        amount: "+2000Frs",
                                        date: "15:52 Jeudi 15",
                                        type: "Dépôt",
                                        icon: Icons.payment),
                                    TransactionItem(
                                        title: "Achat de 3 tickets",
                                        amount: "-1500Frs",
                                        date: "15:52 Mardi 17",
                                        type: "Achat",
                                        icon: Icons.food_bank),
                                    TransactionItem(
                                        title: "Dépôt sur mon portefeuille",
                                        amount: "+2000Frs",
                                        date: "15:52 Jeudi 15",
                                        type: "Dépôt",
                                        icon: Icons.payment)
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                        // The card widget with top padding,
                        // incase if you wanted bottom padding to work,
                        // set the `alignment` of container to Alignment.bottomCenter
                        new Container(
                          alignment: Alignment.topCenter,
                          padding: new EdgeInsets.only(
                            top: 200,
                            right: 25,
                            left: 25,
                          ),
                          child: new Container(
                            height: 230,
                            width: 300,
                            child: new Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.white,
                                elevation: 10.0,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "Avec l'argent stocké sur votre portefeuille vous serez en mesure d'acheter des tickets afin de pouvoir commander des repas.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      width: 200,
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Builder(
                                          builder: (context) => ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(15),
                                                shape:
                                                    new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0),
                                                ),
                                                primary: kPrimaryColor,
                                              ),
                                              onPressed: () {
                                                modal(context);
                                              },
                                              child: Text(
                                                "Faire un dépôt",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ))),
                                    ),
                                  ],
                                )),
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
        builder: (context) => DoMoneyDeposit());
  }
}

class DoMoneyDeposit extends StatefulWidget {
  const DoMoneyDeposit({Key? key}) : super(key: key);

  @override
  State<DoMoneyDeposit> createState() => _DoMoneyDepositState();
}

class _DoMoneyDepositState extends State<DoMoneyDeposit> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController otpController = TextEditingController();
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.topLeft,
              child: Text(
                "Formulaire de dépôt",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              )),
          SizedBox(
            height: 17,
          ),
          Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.topLeft,
              color: kPrimaryColor.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_sharp),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 290,
                        child: Text(
                          "Veuillez composer le code suivant sur votre téléphone avant de procéder !",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                          width: 290,
                          child: Text(
                            "*144*XXXXXX*3*montant#",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  Container()
                ],
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Numéro de téléphone",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
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
                    hintText: "Numéro de téléphone du dépôt",
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
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Montant",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFebd6cf),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(
                      Icons.money,
                      color: kPrimaryColor,
                    ),
                    hintText: "Entrer le montant ",
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Le Code OTP",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: otpController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFebd6cf),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(
                      Icons.password,
                      color: kPrimaryColor,
                    ),
                    hintText: "Entrer le code OTP ",
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
                )
              ],
            )),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Entrer le code OTP que vous avez reçu par SMS",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              )),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 95,
            child: Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            int response = await MakeDeposit(
                                phoneController.text,
                                amountController.text,
                                otpController.text,
                                auth_token);

                            var internet = await internetCheck();

                            if (response == null) {
                              setState(() {
                                inLoginProcessBottom = !inLoginProcessBottom;
                              });
                              Fluttertoast.showToast(
                                  msg: "Echec du dépôt !",
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
                                  msg: "Dépôt éffectuée !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              phoneController.clear();
                              amountController.clear();
                              otpController.clear();
                              setState(() {});
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Envoyer",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ))),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
