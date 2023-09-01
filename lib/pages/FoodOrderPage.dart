import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_resto/api_services/api_services.dart';

import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/dishes_commanded_model.dart';
import 'package:smart_resto/size_config.dart';
import 'package:smart_resto/widgets/BottomNavBarWidget.dart';
import 'package:smart_resto/widgets/cartIconWithBadge.dart';

class FoodOrderPage extends StatefulWidget {
  @override
  _FoodOrderPageState createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage> {
  int counter = 3;
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

  Future<List<DishesCommanded>> _getDishesCommandedListValues() async {
   final _dishesData = await getCommandDishes(auth_token);
     

      return _dishesData;
  }

  @override
  Widget build(BuildContext context) {
    Widget futureMethod() {
      return FutureBuilder<List<DishesCommanded>>(
        future: _getDishesCommandedListValues(), // async work
        builder: (BuildContext context,
            AsyncSnapshot<List<DishesCommanded>> snapshot) {
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
                    appBar: AppBar(
                      backgroundColor: Color(0xFFFAFAFA),
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF3a3737),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      title: Center(
                        child: Text(
                          "Liste de commandes",
                          style: TextStyle(
                              color: Color(0xFF3a3737),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      brightness: Brightness.light,
                      actions: <Widget>[
                        CartIconWithBadge(),
                      ],
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          snapshot.data!.length == 0
                              ? Center(
                                  child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(21),
                                      vertical:
                                          getProportionateScreenHeight(270)),
                                  child: Text(
                                    "Aucun plats commandé",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ))
                              : Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Vos Commandes du jour",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF3a3a3b),
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot
                                                .data!.length, // this one
                                            itemBuilder: (context, index) {
                                              return CartItem(
                                                productName:
                                                    "${snapshot.data![index].dishes.name}",
                                                productPrice: "À: 12h45",
                                                productImage:
                                                    "ic_popular_food_1",
                                                productCartQuantity: "",
                                                isValidate:
                                                    "${snapshot.data![index].done}",
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TotalCalculationWidget(snapshot),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Methode de paiement",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF3a3a3b),
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          PaymentMethodWidget(),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                        ],
                      ),
                    ),
                    bottomNavigationBar: BottomNavBarWidget(
                      index: 2,
                    ));
            // returns null
          }
        },
      );
    }

    return futureMethod();
  }
}

class PaymentMethodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/menus/ic_credit_card.png",
                  width: 50,
                  height: 50,
                ),
              ),
              Text(
                "Tickets/Mobile Money",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF3a3a3b),
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TotalCalculationWidget extends StatelessWidget {
  AsyncSnapshot<List<DishesCommanded>>? snapshot;
  TotalCalculationWidget(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              padding:
                  EdgeInsets.only(left: 25, right: 30, top: 10, bottom: 10),
              child: Column(
                children: <Widget>[
                  snapshot!.data!.length == 0
                      ? Text(
                          "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "- ${snapshot!.data!.length} tickets",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromoCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 3, right: 3),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFFfae3e2).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ]),
        child: TextFormField(
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
                  borderRadius: BorderRadius.circular(7)),
              fillColor: Colors.white,
              hintText: 'Ajouter votre Code Promo',
              filled: true,
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.local_offer,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    debugPrint('222');
                  })),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  String? productName;
  String? productPrice;
  String? productImage;
  String? productCartQuantity;
  String? isValidate;

  CartItem({
    Key? key,
    @required this.productName,
    @required this.productPrice,
    @required this.productImage,
    @required this.productCartQuantity,
    @required this.isValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFFfae3e2).withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ]),
      child: Column(
        children: <Widget>[
          Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Center(
                            child: Image.asset(
                          "assets/images/popular_foods/$productImage.png",
                          width: 110,
                          height: 100,
                        )),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "$productName",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    "$productPrice",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: isValidate == "0"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SpinKitPouringHourGlass(
                                              size: 25, color: Colors.orange),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(10),
                                          ),
                                          Text("en cours",
                                              style: TextStyle(
                                                  color: Colors.orange
                                                      .withOpacity(0.5)))
                                        ],
                                      )
                                    : Icon(
                                        Icons.verified,
                                        color: Colors.green,
                                      ))
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerRight,
                          child: AddToCartMenu(1, isValidate),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class AddToCartMenu extends StatefulWidget {
  int productCounter;
  String? isvalidate;

  AddToCartMenu(this.productCounter, this.isvalidate);

  @override
  State<AddToCartMenu> createState() => _AddToCartMenuState();
}

class _AddToCartMenuState extends State<AddToCartMenu> {
  int number = 1;

  void initState() {
    super.initState();
    setState(() {
      number = widget.productCounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              if (number > 1) {
                setState(() {
                  number--;
                });
              }
            },
            icon: Icon(Icons.food_bank),
            color: Colors.orange,
            iconSize: 18,
          ),
          InkWell(
            onTap: () => print('hello'),
            child: Container(
              width: 100.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: widget.isvalidate == "0" ? kPrimaryColor : Colors.grey,
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: Text(
                  '${number} plats',
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (number > 1) {
                setState(() {
                  number--;
                });
              }
            },
            icon: Icon(Icons.food_bank),
            color: Colors.orange,
            iconSize: 18,
          )
        ],
      ),
    );
  }
}
