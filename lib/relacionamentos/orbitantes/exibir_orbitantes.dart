import 'package:flutter/material.dart';
import 'package:universo_bd/arguments/ArgumentsEstrela.dart';
import 'package:universo_bd/arguments/ArgumentsGiganteVermelha.dart';
import 'package:universo_bd/arguments/ArgumentsPlaneta.dart';
import 'package:universo_bd/arguments/ArgumentsSatelite.dart';
import 'package:universo_bd/classes/Orbitantes.dart';

import '../../information_icon_icons.dart';
import '../../show_card_relations.dart';

class exibir_orbitantes extends StatefulWidget {
  @override

  Orbitantes orbitante;

  exibir_orbitantes({this.orbitante});

  _exibir_orbitantesState createState() => _exibir_orbitantesState();
}

class _exibir_orbitantesState extends State<exibir_orbitantes> {
  @override

  confirmarDeletar(){
    Widget cancelButton = FlatButton(
      textColor: Colors.deepPurpleAccent,
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      textColor: Colors.deepPurpleAccent,
      child: Text("Continuar"),
      onPressed:  () {
        widget.orbitante.deletarOrbitantes();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.popUntil(context, ModalRoute.withName("/listar_orbitantes"));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Deletar relacionamento"),
      content: Text("Você gostaria de deletar esse relacionamento?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Widget> cardRowPlaneta(){
    String idPlaneta=widget.orbitante.planeta.id;
    if(idPlaneta=="-"){
      return <Widget>[
        show_card_relations(
          titulo: "Planeta: ",
          conteudo: widget.orbitante.planeta.nome,
        ),
      ];
    }
    else {
      return <Widget>[
     show_card_relations(
       titulo: "Planeta: ",
       conteudo: widget.orbitante.planeta.nome,
     ),
      Padding(
        padding: EdgeInsetsDirectional.only(start: 10),
        child: ClipOval(
            child: Material(
                color: Colors.deepPurpleAccent, // button color
                child: InkWell(
                      splashColor: Colors.deepPurple, // inkwell color
                      child: SizedBox(width: 30, height: 30, child: Icon(InformationIcon.information, color: Colors.white, size: 20,)),
                      onTap: () {
                           Navigator.pushNamed(context, "/exibir_planeta", arguments: ArgumentsPlaneta(widget.orbitante.planeta, "relations"));
                          },
                 ),
            ),
        ),
     )
    ];
    }
  }

  List<Widget> cardRowSatelite(){
    String idSatelite=widget.orbitante.sateliteNatural.id;
    if(idSatelite=="-"){
      return <Widget>[
        show_card_relations(
          titulo: "Satélite Natural: ",
          conteudo: widget.orbitante.sateliteNatural.nome,
        ),
      ];
    }
    else {
      return <Widget>[
        show_card_relations(
          titulo: "Satélite Natural: ",
          conteudo: widget.orbitante.sateliteNatural.nome,
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 10),
          child: ClipOval(
            child: Material(
              color: Colors.deepPurpleAccent, // button color
              child: InkWell(
                splashColor: Colors.deepPurple, // inkwell color
                child: SizedBox(width: 30, height: 30, child: Icon(InformationIcon.information, color: Colors.white, size: 20,)),
                onTap: () {
                  Navigator.pushNamed(context, "/exibir_satelite_natural", arguments: ArgumentsSatelite(widget.orbitante.sateliteNatural, "relations"));
                },
              ),
            ),
          ),
        )
      ];
    }
  }

  List<Widget> cardRowEstrela(){
    String idEstrela=widget.orbitante.estrela.id;
    if(idEstrela=="-"){
      return <Widget>[
        show_card_relations(
          titulo: "Estrela: ",
          conteudo: widget.orbitante.estrela.nome,
        ),
      ];
    }
    else {
      return <Widget>[
        show_card_relations(
          titulo: "Estrela: ",
          conteudo: widget.orbitante.estrela.nome,
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 10),
          child: ClipOval(
            child: Material(
              color: Colors.deepPurpleAccent, // button color
              child: InkWell(
                splashColor: Colors.deepPurple, // inkwell color
                child: SizedBox(width: 30, height: 30, child: Icon(InformationIcon.information, color: Colors.white, size: 20,)),
                onTap: () {
                  if(widget.orbitante.estrela.tipo=="Gigante Vermelha"){
                    Navigator.pushNamed(context, "/exibir_gigante_vermelha", arguments: ArgumentsGiganteVermelha(widget.orbitante.estrela, "relations"));
                  }else{
                    Navigator.pushNamed(context, "/exibir_estrela", arguments: ArgumentsEstrela(widget.orbitante.estrela, "relations"));
                  }
                },
              ),
            ),
          ),
        )
      ];
    }
  }

  Widget build(BuildContext context) {
    return  Container(
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
                "Orbitantes"
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/editar_orbitantes", arguments: widget.orbitante);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  confirmarDeletar();
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: cardRowPlaneta(),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20),
                  child: Row(
                    children: cardRowEstrela(),
                  ),
                ),Padding(
                  padding: EdgeInsetsDirectional.only(top: 20),
                  child: Row(
                    children: cardRowSatelite(),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
