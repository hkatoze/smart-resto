import 'package:flutter/material.dart';
import 'package:smart_resto/animation/RotationRoute.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/dishes_model.dart';
import 'package:smart_resto/pages/FoodDetailsPage.dart';
import 'package:smart_resto/pages/FoodOrderPage.dart';
import 'package:smart_resto/widgets/BottomNavBarWidget.dart';
import 'package:smart_resto/widgets/PopularFoodsWidget.dart';
import 'package:smart_resto/widgets/cartIconWithBadge.dart';

class MenuPage extends StatefulWidget {
  @override
  final String? restoName;
  const MenuPage({Key? key, this.restoName});
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
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
            widget.restoName!,
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
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Plats du jour",
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
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: PopularFoodItems(
                  restoName: widget.restoName,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        index: 0,
      ),
    );
  }
}

class PopularFoodItems extends StatefulWidget {
  final String? restoName;
  const PopularFoodItems({Key? key, required this.restoName}) : super(key: key);

  @override
  State<PopularFoodItems> createState() => _PopularFoodItemsState();
}

class _PopularFoodItemsState extends State<PopularFoodItems> {
  var auth_token;
  var Id;

  void initState() {
    super.initState();
    readCredentials().then((String result) {
      setState(() {
        auth_token = result;
      });
      print("Auth_token reccupéré :" + auth_token);
    });
    readId().then((String result) {
      setState(() {
        Id = result;
      });
      print("EmployeeId reccupéré :" + Id);
    });
  }

  Stream<List<Dishes>> _getDishesValues() async* {
    while (true) {
      final _userData = await getDishes(auth_token);

      yield _userData;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget futureMethod() {
      return StreamBuilder<List<Dishes>>(
        stream: _getDishesValues(), // async work
        builder: (BuildContext context, AsyncSnapshot<List<Dishes>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Aucun plats",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return snapshot.data!.length == 0
                    ? Center(
                        child: Text(
                          "Aucun plats",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    : GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            childAspectRatio: 0.8),
                        itemBuilder: (context, index) {
                          return snapshot
                                      .data![index].restaurant.user.firstname ==
                                  widget.restoName
                              ? PopularFoodTiles(
                                  userId: Id,
                                  auth_token: auth_token,
                                  dishId: '${snapshot.data![index].id}',
                                  restaurantId:
                                      '${snapshot.data![index].restaurant.user.id}',
                                  done: "0",
                                  name: '${snapshot.data![index].name}',
                                  imageUrl: "ic_popular_food_1",
                                  rating: '4.9',
                                  numberOfRating: '200',
                                  price:
                                      '${snapshot.data![index].restaurant.user.firstname}',
                                  slug: "${snapshot.data![index].description}",
                                  category:
                                      '${snapshot.data![index].category.name}',
                                )
                              : SizedBox();
                        },
                      );
              }
          }
        },
      );
    }

    return futureMethod();
  }
}
