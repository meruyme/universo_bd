import 'package:flutter/material.dart';
import 'package:universo_bd/arguments/ArgumentsEstrela.dart';
import 'package:universo_bd/arguments/ArgumentsGiganteVermelha.dart';
import 'package:universo_bd/arguments/ArgumentsSistema.dart';
import 'package:universo_bd/classes/SistemaEstrela.dart';
import 'package:universo_bd/information_icon_icons.dart';
import 'package:universo_bd/show_card_relations.dart';

class exibir_sistema_estrela extends StatefulWidget {

  SistemaEstrela sistemaEstrela;

  exibir_sistema_estrela({this.sistemaEstrela});

  @override
  _exibir_sistema_estrelaState createState() => _exibir_sistema_estrelaState();
}

class _exibir_sistema_estrelaState extends State<exibir_sistema_estrela> {


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
        widget.sistemaEstrela.deletarSistemaEstrela();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.popUntil(context, ModalRoute.withName("/listar_sistema_estrela"));
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
                "Relação Sistema-Estrela"
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/editar_sistema_estrela", arguments: widget.sistemaEstrela);
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
              children: <Widget>[
                Row(
                  children: <Widget>[
                    show_card_relations(
                      titulo: "Sistema Planetário: ",
                      conteudo: widget.sistemaEstrela.sistemaPlanetario.nome,
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
                              Navigator.pushNamed(context, "/exibir_sistema_planetario", arguments: ArgumentsSistema(widget.sistemaEstrela.sistemaPlanetario, "relations"));
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
                        titulo: "Estrela: ",
                        conteudo: widget.sistemaEstrela.estrela.nome,
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
                                if(widget.sistemaEstrela.estrela.tipo != "Gigante Vermelha"){
                                  Navigator.pushNamed(context, "/exibir_estrela", arguments: ArgumentsEstrela(widget.sistemaEstrela.estrela, "relations"));
                                }
                                else{
                                  Navigator.pushNamed(context, "/exibir_gigante_vermelha", arguments: ArgumentsGiganteVermelha(widget.sistemaEstrela.estrela, "relations"));
                                }
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
