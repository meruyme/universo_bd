import 'package:flutter/material.dart';
import 'package:universo_bd/arguments/ArgumentsEstrela.dart';
import 'package:universo_bd/show_card.dart';

class exibir_estrela extends StatefulWidget {

  ArgumentsEstrela arguments;

  exibir_estrela({this.arguments});

  _exibir_estrelaState createState() => _exibir_estrelaState();
}

class _exibir_estrelaState extends State<exibir_estrela> {

  String _nome;
  String _tipo;
  double _idade;
  double _tamanho;
  double _distancia;

  double _diferencaCards=10;

  void initState() {
    super.initState();
    _nome = widget.arguments.estrela.nome;
    _distancia = widget.arguments.estrela.distanciaTerra;
    _idade = widget.arguments.estrela.idade;
    _tamanho = widget.arguments.estrela.tamanho;
    _tipo = widget.arguments.estrela.tipo;
  }

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
            Navigator.pushNamed(context, "/editar_estrela", arguments: widget.arguments.estrela);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          onPressed: () {
            confirmarDeletar();
            // do something
          },
        )
      ];
    }
  }

  confirmarDeletar(){
    // set up the buttons
    String _nome = widget.arguments.estrela.nome;
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
        widget.arguments.estrela.deletarEstrela();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.popUntil(context, ModalRoute.withName("/listar_estrela"));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Deletar estrela"),
      content: Text("Você gostaria de deletar a estrela $_nome?"),
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
                "Estrela $_nome"
            ),
            actions: actionsAppBar()
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                show_card(
                  titulo: "Nome: ",
                  conteudo: _nome,
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Tamanho: ",
                  conteudo: _tamanho.toString() + "Km",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Idade: ",
                  conteudo: _idade.toString() + " Bilhões de anos",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Distância da Terra: ",
                  conteudo: _distancia.toString() + " Anos-luz",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Tipo da estrela: ",
                  conteudo: _tipo,
                  diferencaCards: _diferencaCards,
                ),
              ],
            ),
          ),
        )
    );
  }
}