import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilElement extends StatefulWidget {
  const ProfilElement({
    Key? key,
    this.title,
    this.svg,
    this.numOfItems = 0,
  }) : super(key: key);

  final String? svg;
  final String? title;

  final int numOfItems;

  @override
  _ProfilElementState createState() => _ProfilElementState();
}

class _ProfilElementState extends State<ProfilElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1, color: Color(0xFF8a8a8a)),
      )),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  widget.svg!,
                  color: Color(0xFF8a8a8a),
                ),
              ),
              Text(
                widget.title!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0XFF8a8a8a)),
              ),
            ],
          ),
          if (widget.numOfItems != 0)
            Container(
              height: 20,
              width:20,
              decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white)),
              child: Center(
                  child: Text(widget.numOfItems.toString(),
                      style: TextStyle(
                          fontSize: 10,
                          height: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))),
            ),
        ],
      ),
    );
  }
}
