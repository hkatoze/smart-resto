import 'package:flutter/material.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/pages/FoodOrderPage.dart';
import 'package:smart_resto/pages/menuPage.dart';
import 'package:smart_resto/widgets/cartIconWithBadge.dart';

class RestoDetails extends StatefulWidget {
  const RestoDetails({
    Key? key,
    this.name,
    this.image,
    this.location,
    this.speciality,
    this.introducing,
  }) : super(key: key);
  final String? name;
  final String? speciality;
  final String? image;
  final String? location;
  final String? introducing;
  @override
  _RestoDetailsState createState() => _RestoDetailsState();
}

class _RestoDetailsState extends State<RestoDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.name!,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF3a3737),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            InkWell(
                child: CartIconWithBadge(),
                onTap: () {
                  Navigator.push(context, ScaleRoute(page: FoodOrderPage()));
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 2.0)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(widget.image!))),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name!,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text("Menu"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              ScaleRoute(
                                  page: MenuPage(restoName: widget.name)));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.introducing!,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Slogan",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.speciality!,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Localisation",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.location!,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
