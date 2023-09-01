import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/user_model.dart';
import 'package:smart_resto/pages/FoodOrderPage.dart';
import 'package:smart_resto/widgets/cartIconWithBadge.dart';

class FoodDetailsPage extends StatefulWidget {
  final String? image;
  final String? resto;
  final String? name;
  final String? slug;
  final String? userId;
  final String? dishId;
  final String? restaurantId;

  final String? done;
  final String? auth_token;
  const FoodDetailsPage(
      {Key? key,
      this.image,
      this.resto,
      this.name,
      this.slug,
      required this.userId,
      required this.dishId,
      required this.restaurantId,
      required this.done,
      required this.auth_token});

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
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
          brightness: Brightness.light,
          actions: <Widget>[
            InkWell(
                child: CartIconWithBadge(),
                onTap: () {
                  Navigator.push(context, ScaleRoute(page: FoodOrderPage()));
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  "assets/images/popular_foods/" + widget.image! + ".png",
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                elevation: 1,
                margin: EdgeInsets.all(5),
              ),
              FoodTitleWidget(
                  productName: widget.name,
                  productPrice: "-1 tickets/plat",
                  productHost: widget.resto!),
              SizedBox(
                height: 15,
              ),
              AddToCartMenu(
                userId: widget.userId,
                dishId: widget.dishId,
                restaurantId: widget.restaurantId,
                done: widget.done,
                auth_token: widget.auth_token,
              ),
              SizedBox(
                height: 15,
              ),
              PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: TabBar(
                  labelColor: kPrimaryColor,
                  indicatorColor: kPrimaryColor.withOpacity(0.8),
                  unselectedLabelColor: Color(0xFFa4a1a1),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(
                      text: 'Détails du plat',
                    ),
                    Tab(
                      text: 'Food Reviews',
                    ),
                  ], // list of tabs
                ),
              ),
              Container(
                height: 150,
                child: TabBarView(
                  children: [
                    Container(
                      color: Colors.white24,
                      child: DetailContentMenu(
                        slug: widget.slug,
                      ),
                    ),
                    Container(
                      color: Colors.white24,
                      child: DetailContentMenu(),
                    ), // class name
                  ],
                ),
              ),
              BottomMenu(),
            ],
          )),
        ),
      ),
    );
  }
}

class FoodTitleWidget extends StatelessWidget {
  String? productName;
  String? productPrice;
  String? productHost;

  FoodTitleWidget({
    Key? key,
    @required this.productName,
    @required this.productPrice,
    @required this.productHost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              productName!,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              productPrice!,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Text(
              "de ",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFa9a9a9),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              productHost!,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1f1f1f),
                  fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }
}

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.timelapse,
                color: Color(0xFF404aff),
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "7H  à 20H",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.directions,
                color: Color(0xFF23c58a),
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "3.5 km",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.map,
                color: kPrimaryColor,
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Localisation",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.directions_bike,
                color: Color(0xFFe95959),
                size: 35,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Livraison",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AddToCartMenu extends StatefulWidget {
  final String? dishId;
  final String? restaurantId;
  final String? userId;
  final String? done;
  final String? auth_token;

  const AddToCartMenu(
      {Key? key,
      required this.dishId,
      required this.restaurantId,
      required this.done,
      required this.userId,
      required this.auth_token})
      : super(key: key);

  @override
  _AddToCartMenuState createState() => _AddToCartMenuState();
}

class _AddToCartMenuState extends State<AddToCartMenu> {
  int qty = 1;
  Stream<User> _getUserValues() async* {
   
      final _userData = await getUser(widget.auth_token!);

      yield _userData;
    
  }

  @override
  Widget build(BuildContext context) {
    futureMethod() {
      return StreamBuilder<User>(
        stream: _getUserValues(), // async work
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SpinKitThreeBounce(
                color: kPrimaryColor,
              );
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove),
                        color: Colors.black,
                        iconSize: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          String response = await CommandDishes(
                              '${snapshot.data!.employeeId}',
                              widget.dishId!,
                              widget.restaurantId!,
                              widget.userId!,
                              widget.auth_token!);

                          print("EmployeeID: " +
                              '${snapshot.data!.employeeId}' +
                              "\ndishId : " +
                              widget.dishId! +
                              "\nrestaurantId: " +
                              widget.restaurantId! +
                              "\nuserId: " +
                              widget.userId! +
                              "\ndone: " +
                              "0" +
                              "\nauth_token: " +
                              widget.auth_token!);

                          var internet = await internetCheck();

                          if (response == "commande effectuée avec succés") {
                            Fluttertoast.showToast(
                                msg: "Plats commandé !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.push(
                                context, ScaleRoute(page: FoodOrderPage()));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Echec de connexion au server !\nVerifier votre connexion internet",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                          width: 200.0,
                          height: 45.0,
                          decoration: new BoxDecoration(
                            color: kPrimaryColor,
                            border: Border.all(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              "Commander 1 plats",
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            qty++;
                          });
                        },
                        icon: Icon(Icons.add),
                        color: kPrimaryColor,
                        iconSize: 30,
                      ),
                    ],
                  ),
                );
          }
        },
      );
    }

    return futureMethod();
  }
}

class DetailContentMenu extends StatelessWidget {
  final String? slug;
  const DetailContentMenu({Key? key, this.slug});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        slug.toString(),
        style: TextStyle(
            fontSize: 14.0,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            height: 1.50),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
