import 'package:flutter/material.dart';

class show_card extends StatefulWidget {

  String titulo;
  String conteudo;
  double diferencaCards;

  show_card({this.titulo, this.conteudo, this.diferencaCards});

  @override
  _show_cardState createState() => _show_cardState();
}

class _show_cardState extends State<show_card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.diferencaCards),
      child: Padding(
          padding: EdgeInsets.only(bottom: widget.diferencaCards),
          child:Container(
            //height: 55,
            child:  Card(
                shape: StadiumBorder(
                    side: BorderSide(
                      color: Color.fromRGBO(64, 75, 96, 0.9),
                      width: 2,
                    )
                ),
                color: Color.fromRGBO(64, 75, 96, 0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left:15, right: 10) ,
                      child: Text(
                        widget.titulo,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(right:10, top: 15, bottom: 15) ,
                        child: Text(
                          widget.conteudo,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          )
      ),
    );
  }
}
