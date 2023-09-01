import 'package:another_carousel_pro/another_carousel_pro.dart';

import 'package:flutter/material.dart';

class FoodDetailsSlider extends StatelessWidget {
  String? slideImage1;
  String? slideImage2;
  String? slideImage3;

  FoodDetailsSlider(
      {Key? key,
      @required this.slideImage1,
      @required this.slideImage2,
      @required this.slideImage3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
          child: AnotherCarousel(
        borderRadius: true,
        radius: Radius.circular(20),
        images: [ExactAssetImage(slideImage1!)],
      )),
    );
  }
}
