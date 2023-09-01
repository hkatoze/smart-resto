import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/dishes_commanded_model.dart';
import 'package:smart_resto/size_config.dart';
import 'package:smart_resto/widgets/BottomNavBarWidget.dart';

class CartIconWithBadge extends StatefulWidget {
  const CartIconWithBadge({Key? key}) : super(key: key);

  @override
  State<CartIconWithBadge> createState() => _CartIconWithBadgeState();
}

class _CartIconWithBadgeState extends State<CartIconWithBadge> {
  var auth_token;

  void initState() {
    super.initState();
    readCredentials().then((String result) {
      setState(() {
        auth_token = result;
      });
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
                return SpinKitThreeBounce(
                  size:20,
                  color: kPrimaryColor,
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Stack(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.business_center,
                            color: Color(0xFF3a3737),
                          ),
                          onPressed: () {}),
                      '${snapshot.data!.length}' != 0
                          ? Positioned(
                              right: 11,
                              top: 11,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  '${snapshot.data!.length}',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  );
            }
            // returns null
          });
    }

    return futureMethod();
  }
}
