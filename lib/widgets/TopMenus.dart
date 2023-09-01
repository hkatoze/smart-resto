import 'package:flutter/material.dart';
import 'package:smart_resto/animation/RotationRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/restaurant_list_model.dart';
import 'package:smart_resto/pages/menuPage.dart';

class TopMenus extends StatefulWidget {
  final AsyncSnapshot<List<AllRestaurant>> data;
  const TopMenus({Key? key, required this.data});
  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  @override
  Widget build(BuildContext context) {
    if (widget.data.hasError)
      return Text('Error: ${widget.data.error}');
    else
      return Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.data.data!.length, // this one
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print('${widget.data.data![index].user.firstname}');
                Navigator.push(
                    context,
                    RotationRoute(
                        page: MenuPage(
                      restoName: "${widget.data.data![index].user.firstname}",
                    )));
              },
              child: TopMenuTiles(
                  name: "${widget.data.data![index].user.firstname}",
                  imageUrl: "ic_burger",
                  slug: ""),
            );
          },
        ),
      );
    ;
  }
}

class TopMenuTiles extends StatelessWidget {
  String? name;
  String? imageUrl;
  String? slug;

  TopMenuTiles(
      {Key? key,
      @required this.name,
      @required this.imageUrl,
      @required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 25.0,
                offset: Offset(0.0, 0.75),
              ),
            ]),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Center(
                      child: Image.asset(
                    'assets/images/topmenu/' + imageUrl! + ".png",
                    width: 24,
                    height: 24,
                  )),
                )),
          ),
          Text(name!,
              style: TextStyle(
                  color: Color(0xFF6e6e71),
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ],
      );
  
  }
}
