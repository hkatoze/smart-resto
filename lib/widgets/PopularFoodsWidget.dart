import 'package:flutter/material.dart';
import 'package:smart_resto/animation/RotationRoute.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/dishes_model.dart';
import 'package:smart_resto/pages/FoodDetailsPage.dart';

class PopularFoodsWidget extends StatefulWidget {
  @override
  _PopularFoodsWidgetState createState() => _PopularFoodsWidgetState();
}

class _PopularFoodsWidgetState extends State<PopularFoodsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PopularFoodTitle(),
          Expanded(
            child: PopularFoodItems(),
          )
        ],
      ),
    );
  }
}

class PopularFoodTiles extends StatelessWidget {
  String? name;
  String? imageUrl;
  String? rating;
  String? numberOfRating;
  String? price;
  String? slug;
  String? category;

  final String? dishId;
  final String? restaurantId;
  final String? userId;
  final String? done;
  final String? auth_token;

  PopularFoodTiles(
      {Key? key,
      @required this.name,
      @required this.imageUrl,
      @required this.rating,
      @required this.numberOfRating,
      @required this.price,
      @required this.slug,
      @required this.category,
      required this.userId,
      required this.dishId,
      required this.restaurantId,
      required this.done,
      required this.auth_token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ScaleRoute(
                page: FoodDetailsPage(
              userId: userId,
              slug: slug,
              image: imageUrl!,
              resto: price!,
              name: name,
              dishId: dishId,
              restaurantId: restaurantId,
              done: done,
              auth_token: auth_token,
            )));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(boxShadow: []),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  width: 170,
                  height: 210,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              alignment: Alignment.topRight,
                              width: double.infinity,
                              padding: EdgeInsets.only(right: 5, top: 5),
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white70,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFfae3e2),
                                        blurRadius: 25.0,
                                        offset: Offset(0.0, 0.75),
                                      ),
                                    ]),
                                child: Icon(
                                  Icons.favorite,
                                  color: kPrimaryColor,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Image.asset(
                              'assets/images/popular_foods/' +
                                  imageUrl! +
                                  ".png",
                              width: 130,
                              height: 140,
                            )),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5),
                            child: Text(name!,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(right: 5),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFfae3e2),
                                      blurRadius: 25.0,
                                      offset: Offset(0.0, 0.75),
                                    ),
                                  ]),
                              child: Icon(
                                Icons.near_me,
                                color: kPrimaryColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 3, left: 5),
                                child: Text(category!),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                            child: Text(price!,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class PopularFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Plats du jour",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          Text(
            "Voir tout",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}

class PopularFoodItems extends StatefulWidget {
  const PopularFoodItems({Key? key}) : super(key: key);

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

  Future<List<Dishes>> _getDishesValues() async {
  final _userData = await getDishes(auth_token);
    

      return  _userData;
  }

  @override
  Widget build(BuildContext context) {
    Widget futureMethod() {
      return FutureBuilder<List<Dishes>>(
        future: _getDishesValues(), // async work
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
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return PopularFoodTiles(
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
                            category: '${snapshot.data![index].category.name}',
                          );
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
