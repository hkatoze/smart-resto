import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/ticket_model.dart';
import 'package:smart_resto/size_config.dart';
import 'package:smart_resto/widgets/BottomNavBarWidget.dart';
import 'package:smart_resto/widgets/transactionItem.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
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

  void modal(BuildContext context, String employeeId) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return BuyTicketBottom(
            employeeId: employeeId,
          );
        });
  }

  Stream<Ticket> _getTicketValues() async* {
  

    while (true) {
      final _ticketData = await getTicket(auth_token);
      await Future<void>.delayed(const Duration(seconds: 1));

      yield _ticketData;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Widget futureMethod() {
      return StreamBuilder<Ticket>(
        stream: _getTicketValues(), // async work
        builder: (BuildContext context, AsyncSnapshot<Ticket> snapshot) {
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
                      index: 1,
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
                                      "Tickets Total",
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
                                                    "Tickets",
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
                                                "${snapshot.data!.nbr_ticket}",
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
                                        "Les tickets vous permet de commander un repas dans un de vos restaurant préféré !",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                                print(
                                                    "${snapshot.data!.employeeId.toString()}");
                                                modal(context,
                                                    "${snapshot.data!.employeeId.toString()}");
                                              },
                                              child: Text(
                                                "Acheter ticket",
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
}

class BuyTicketBottom extends StatefulWidget {
  final String employeeId;
  const BuyTicketBottom({Key? key, required this.employeeId}) : super(key: key);

  @override
  State<BuyTicketBottom> createState() => _BuyTicketBottomState();
}

class _BuyTicketBottomState extends State<BuyTicketBottom> {
  String _myActivity = "Moi";
  int _ticketnumber = 1;
  bool _isVisible = false;
  bool inLoginProcessBottom = false;
  TextEditingController ticketNbrController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
                "Formulaire d'achat de tickets",
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
                          "Vous serez débité de XXXX Frs par ticket acheté !",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container()
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
                  "Pour qui ?",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFebd6cf),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(90, 200, 5,
                              10), //here you can specify the location,
                          items: [
                            PopupMenuItem(
                              value: 0,
                              onTap: () {},
                              child: Text("Moi"),
                            ),
                            PopupMenuItem(
                              value: 1,
                              onTap: () {},
                              child: Text("Quelqu'un d'autre"),
                            ),
                          ],
                        ).then((value) {
                          if (value == 0) {
                            setState(() {
                              _myActivity = "Moi";
                              _isVisible = false;
                            });
                          } else if (value == 1) {
                            setState(() {
                              _myActivity = "Quelqu'un d'autre";
                              _isVisible = true;
                            });
                          } else {}
                        });
                      },
                      icon: Icon(Icons.arrow_drop_down),
                      color: kPrimaryColor,
                    ),
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: kPrimaryColor,
                    ),
                    hintText: _myActivity,
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
                  height: 2,
                ),
                Visibility(
                    visible: _isVisible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Numéro de téléphone du bénéficiaire",
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
                              borderSide:
                                  BorderSide(color: kPrimaryColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: kPrimaryColor,
                            ),
                            hintText: "Numéro de téléphone",
                            hintStyle: TextStyle(
                                color: Color(0XFFc97a63), fontSize: 16),
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
                      ],
                    )),
                Text(
                  "Nombre de ticket",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: TextFormField(
                        controller: ticketNbrController,
                        readOnly: true,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFebd6cf),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: _ticketnumber.toString(),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
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
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  if (_ticketnumber >= 1) {
                                    _ticketnumber++;
                                  }
                                });
                              },
                              child: Container(
                                  child: Text(
                                "+",
                                style: TextStyle(
                                    fontSize: 20, color: kPrimaryColor),
                              ))),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  if (_ticketnumber > 1) {
                                    _ticketnumber--;
                                  }
                                });
                              },
                              child: Container(
                                  child: Text(
                                "-",
                                style: TextStyle(
                                    fontSize: 20, color: kPrimaryColor),
                              ))),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
          ),
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
                            print("EmployeeId: " +
                                widget.employeeId +
                                "\nNombre de ticket: " +
                                _ticketnumber.toString() +
                                "\nauth_token: " +
                                auth_token);
                            String response = await buyTicket(widget.employeeId,
                                _ticketnumber.toString(), auth_token);

                            var internet = await internetCheck();

                            if (response == "Achat effectué avec succès") {
                              setState(() {
                                inLoginProcessBottom = !inLoginProcessBottom;
                              });
                              Fluttertoast.showToast(
                                  msg: "Achat de tickets réussi !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              phoneController.clear();
                              ticketNbrController.clear();

                              setState(() {});
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                inLoginProcessBottom = !inLoginProcessBottom;
                              });
                              Fluttertoast.showToast(
                                  msg: "Echec d'achat de tickets !",
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
                            }
                          },
                          child: Text(
                            "Acheter",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                ),
              )),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
