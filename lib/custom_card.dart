import 'package:flutter/material.dart';

class custom_card extends StatefulWidget {

  IconData icon;
  String title;
  String subtitle1;
  String subtitle2;

  custom_card({this.icon, this.title, this.subtitle1, this.subtitle2});

  @override
  _custom_cardState createState() => _custom_cardState();
}

class _custom_cardState extends State<custom_card> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, 0.9)),
          child:  ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.white24))),
                child: Icon(widget.icon, color: Colors.white),
              ),
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.subtitle1, style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 13
                  )),
                  Text(widget.subtitle2, style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 13
                  )),
                ],
              ),
              trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0))
      ),
    );
  }
}
