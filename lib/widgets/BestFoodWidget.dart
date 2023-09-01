import 'package:flutter/material.dart';
import 'package:smart_resto/animation/RotationRoute.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/restaurant_list_model.dart';
import 'package:smart_resto/pages/menuPage.dart';
import 'package:smart_resto/pages/restoDetailsScreen.dart';

class BestFoodWidget extends StatefulWidget {
  final AsyncSnapshot<List<AllRestaurant>> snapshot;

  const BestFoodWidget({Key? key, required this.snapshot});
  @override
  _BestFoodWidgetState createState() => _BestFoodWidgetState();
}

class _BestFoodWidgetState extends State<BestFoodWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          BestFoodTitle(),
          Expanded(
            child: BestFoodList(
              snapshot: widget.snapshot,
            ),
          )
        ],
      ),
    );
  }
}

class BestFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Restaurants de la place",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class BestFoodTiles extends StatelessWidget {
  String? name;
  String? imageUrl;
  String? location;
  String? description;
  String? slogan;
  String? slug;

  BestFoodTiles(
      {Key? key,
      @required this.name,
      @required this.imageUrl,
      @required this.location,
      @required this.description,
      @required this.slogan,
      @required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ScaleRoute(
                page: RestoDetails(
              image: "assets/images/bestfood/" + imageUrl! + ".jpg",
              name: slug!,
              location: location,
              speciality: slogan,
              introducing:
                 description,
            )));
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 15.0,
                offset: Offset(0, 0.75),
              ),
            ]),
            child: Container(
              height: 250,
              width: 370,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/bestfood/' + imageUrl! + ".jpg",
                      ))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          slug!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container()
                    ],
                  ),
                  SizedBox(
                    height: 125,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Container(
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryColor),
                          child: Text("Menu"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                RotationRoute(
                                    page: MenuPage(
                                  restoName: slug!,
                                )));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BestFoodList extends StatelessWidget {
  final AsyncSnapshot<List<AllRestaurant>> snapshot;

  const BestFoodList({Key? key, required this.snapshot});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length, // this one
      itemBuilder: (context, index) {
        return BestFoodTiles(
            name: "Salade de pattes",
            imageUrl: "resto1",
            location: '${snapshot.data![index].localization}',
            description: '${snapshot.data![index].description}',
            slogan: '${snapshot.data![index].slogan}',
            slug: "${snapshot.data![index].user.firstname}");
      },
    );
  }
}
