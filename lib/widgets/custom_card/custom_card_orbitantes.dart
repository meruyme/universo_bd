import 'package:flutter/material.dart';

class custom_card_orbitantes extends StatefulWidget {

  IconData icon;
  String title1;
  String title2;
  String title3;

  custom_card_orbitantes({this.icon, this.title1, this.title2, this.title3});

  @override
  _custom_card_orbitantesState createState() => _custom_card_orbitantesState();
}

class _custom_card_orbitantesState extends State<custom_card_orbitantes> {
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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.title1, style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    //fontSize: 13
                  )),
                  Text(widget.title2, style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    //fontSize: 13
                  )),
                  Text(widget.title3, style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    //fontSize: 13
                  )),
                ],
              ),
              trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0))
      ),
    );
  }
}
