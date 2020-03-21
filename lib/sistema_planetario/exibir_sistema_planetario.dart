import 'package:flutter/material.dart';
import 'package:universo_bd/arguments/ArgumentsSistema.dart';
import 'package:universo_bd/widgets/show_card/show_card.dart';


class exibir_sistema_planetario extends StatefulWidget {

  ArgumentsSistema arguments;

  exibir_sistema_planetario({this.arguments});

  _exibir_sistema_planetarioState createState() => _exibir_sistema_planetarioState();
}

class _exibir_sistema_planetarioState extends State<exibir_sistema_planetario> {

  String _nome;
  String _galaxia;
  double _idade;
  int _qtdPlanetas;
  int _qtdEstrelas;

  double _diferencaCards=10;

  List<Widget> actionsAppBar(){
    if(widget.arguments.tela == "relations"){
      return null;
    }
    else{
      return <Widget>[
        IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/editar_sistema_planetario", arguments: widget.arguments.sistemaPlanetario);
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
      ];
    }
  }

  void initState(){
    super.initState();
    _galaxia=widget.arguments.sistemaPlanetario.galaxia.nome;
    _nome=widget.arguments.sistemaPlanetario.nome;
    _idade=widget.arguments.sistemaPlanetario.idade;
    _qtdPlanetas=widget.arguments.sistemaPlanetario.qtdPlanetas;
    _qtdEstrelas=widget.arguments.sistemaPlanetario.qtdEstrelas;
  }

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
        widget.arguments.sistemaPlanetario.deletarSistemaPlanetario();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.popUntil(context, ModalRoute.withName("/listar_sistema_planetario"));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Deletar sistema planetário"),
      content: Text("Você gostaria de deletar o sistema planetário $_nome?"),
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
                "Sistema $_nome"
            ),
            actions: actionsAppBar()
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                show_card(
                  titulo: "Nome: ",
                  conteudo: _nome,
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Idade: ",
                  conteudo: _idade.toString() + " Bilhões de anos",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Galáxia: ",
                  conteudo: _galaxia,
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Qtd. Planetas: ",
                  conteudo: _qtdPlanetas == 1 ? _qtdPlanetas.toString() + " Planeta" :
                  _qtdPlanetas.toString() + " Planetas",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Qtd. Estrelas: ",
                  conteudo: _qtdEstrelas == 1 ? _qtdEstrelas.toString() + " Estrela" :
                  _qtdEstrelas.toString() + " Estrelas",
                  diferencaCards: _diferencaCards,
                ),
              ],
            ),
          ),
        )
    );
  }
}