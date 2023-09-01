import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/dishes_model.dart';
import 'package:smart_resto/models/restaurant_list_model.dart';

import 'package:smart_resto/models/user_model.dart';
import 'package:smart_resto/pages/FoodOrderPage.dart';

import 'package:smart_resto/size_config.dart';
import 'package:smart_resto/widgets/BestFoodWidget.dart';
import 'package:smart_resto/widgets/BottomNavBarWidget.dart';
import 'package:smart_resto/widgets/PopularFoodsWidget.dart';
import 'package:smart_resto/widgets/SearchWidget.dart';
import 'package:smart_resto/widgets/TopMenus.dart';
import 'package:smart_resto/widgets/cartIconWithBadge.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future<List<AllRestaurant>> _getRestaurantsListValues() async {
    final _userData = await getRestaurants(auth_token);


      return _userData;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Widget futureMethod() {
      return FutureBuilder<List<AllRestaurant>>(
        future:_getRestaurantsListValues(), // async work
        builder: (BuildContext context,
            AsyncSnapshot<List<AllRestaurant>> snapshot) {
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
                      title: Text(
                        " Que voulez vous manger aujourd'hui?",
                        style: TextStyle(
                            color: Color(0xFF3a3737),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      actions: [
                        InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              Navigator.push(
                                  context, ScaleRoute(page: FoodOrderPage()));
                            },
                            child: CartIconWithBadge())
                      ],
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SearchWidget(),
                          snapshot.data!.length == 0
                              ? Center(
                                  child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(21),
                                      vertical:
                                          getProportionateScreenHeight(250)),
                                  child: Text(
                                    "Votre structure n'est abonné à aucun restaurant pour le moment",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ))
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TopMenus(data: snapshot,),
                                    PopularFoodsWidget(),
                                    BestFoodWidget(snapshot: snapshot,),
                                  ],
                                )
                        ],
                      ),
                    ),
                    bottomNavigationBar: BottomNavBarWidget(
                      index: 0,
                    ));
          }
        },
      );
    }

    return futureMethod();
  }
}
