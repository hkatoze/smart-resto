import 'package:flutter/material.dart';
import 'package:smart_resto/constants.dart';


class TransactionItem extends StatefulWidget {
  const TransactionItem(
      {Key? key, this.title, this.amount, this.date, this.type, this.icon})
      : super(key: key);
  final String? type;
  final String? title;
  final String? date;
  final IconData? icon;
  final String? amount;
  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFF8a8a8a)),
        )),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        widget.icon,
                        color: kPrimaryColor,
                      ),
                      Container(
                        height: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title!,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        widget.type!,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          widget.date!,
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                          width: 80,
                          child: Text(widget.amount!,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)))
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
