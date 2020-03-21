import 'package:flutter/material.dart';
import 'package:universo_bd/arguments/ArgumentsPlaneta.dart';
import 'package:universo_bd/arguments/ArgumentsSistema.dart';
import 'package:universo_bd/classes/SistemaPlaneta.dart';
import 'package:universo_bd/information_icon_icons.dart';
import 'package:universo_bd/widgets/show_card/show_card_relations.dart';

class exibir_sistema_planeta extends StatefulWidget {

  SistemaPlaneta sistemaPlaneta;

  exibir_sistema_planeta({this.sistemaPlaneta});

  @override
  _exibir_sistema_planetaState createState() => _exibir_sistema_planetaState();
}

class _exibir_sistema_planetaState extends State<exibir_sistema_planeta> {

  confirmarDeletar(){
    // set up the buttons
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
        widget.sistemaPlaneta.deletarSistemaPlaneta();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.popUntil(context, ModalRoute.withName("/listar_sistema_planeta"));
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

  @override
  Widget build(BuildContext context) {
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
                "Relação Sistema-Planeta"
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/editar_sistema_planeta", arguments: widget.sistemaPlaneta);
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
                  children: <Widget>[
                    show_card_relations(
                      titulo: "Sistema Planetário: ",
                      conteudo: widget.sistemaPlaneta.sistemaPlanetario.nome,
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
                              Navigator.pushNamed(context, "/exibir_sistema_planetario", arguments: ArgumentsSistema(widget.sistemaPlaneta.sistemaPlanetario, "relations"));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      show_card_relations(
                        titulo: "Planeta: ",
                        conteudo: widget.sistemaPlaneta.planeta.nome,
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
                                Navigator.pushNamed(context, "/exibir_planeta", arguments: ArgumentsPlaneta(widget.sistemaPlaneta.planeta, "relations"));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
