import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/classes/SateliteNatural.dart';
import 'package:universo_bd/show_card.dart';

class exibir_satelite_natural extends StatefulWidget {

  SateliteNatural sateliteNatural;

  exibir_satelite_natural({this.sateliteNatural});

  @override
  _exibir_satelite_naturalState createState() => _exibir_satelite_naturalState();
}

class _exibir_satelite_naturalState extends State<exibir_satelite_natural> {
  @override

  double width;
  double _diferencaCards=10;
  ScrollController scrollController = ScrollController();
  bool isExpanded = false;


  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/fundo_telas6.jpg"),
              fit: BoxFit.cover,
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
                "Satélite " + widget.sateliteNatural.nome
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/editar_satelite_natural", arguments: widget.sateliteNatural);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                show_card(
                  titulo: "Nome: ",
                  conteudo: widget.sateliteNatural.nome,
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Tamanho: ",
                  conteudo: widget.sateliteNatural.tamanho.toString() + " Km",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Massa: ",
                  conteudo: widget.sateliteNatural.massa.toString() + " Kg",
                  diferencaCards: _diferencaCards,
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: _diferencaCards),
                    child: Material(
                      color: Color.fromRGBO(64, 75, 96, 0.9),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                      child: GroovinExpansionTile(
                        title: Text("Componentes gasosos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        onExpansionChanged: (value) {
                          setState(() {
                            isExpanded = value;
                          });
                        },
                        inkwellRadius: !isExpanded
                            ? BorderRadius.all(Radius.circular(32.0))
                            : BorderRadius.only(
                          topRight: Radius.circular(32.0),
                          topLeft: Radius.circular(32.0),
                        ),
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: widget.sateliteNatural.componentes.length,
                            itemBuilder: (context, position){
                              List aux = widget.sateliteNatural.componentes[position].split("-");
                              return Padding(
                                padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                child: Text("Gás: " + aux[0] +
                                    " - Porcentagem: " + aux[1] + "%",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              );
                            },
                          ),
                        ],
                      ),
                    )

                ),
              ],
            ),
          ),
        )
    );
  }
}

