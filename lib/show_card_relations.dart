import 'package:flutter/material.dart';

class show_card_relations extends StatefulWidget {

  String titulo;
  String conteudo;
  double diferencaCards;

  show_card_relations({this.titulo, this.conteudo, this.diferencaCards});

  @override
  _show_card_relationsState createState() => _show_card_relationsState();
}

class _show_card_relationsState extends State<show_card_relations> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Card(
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
    );
  }
}
