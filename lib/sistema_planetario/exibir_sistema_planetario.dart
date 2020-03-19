import 'package:flutter/material.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/show_card.dart';


class exibir_sistema_planetario extends StatefulWidget {

  SistemaPlanetario sistemaPlanetario;

  exibir_sistema_planetario({this.sistemaPlanetario});

  _exibir_sistema_planetarioState createState() => _exibir_sistema_planetarioState();
}

class _exibir_sistema_planetarioState extends State<exibir_sistema_planetario> {

  String _nome;
  String _galaxia;
  double _idade;
  int _qtdPlanetas;
  int _qtdEstrelas;

  double _diferencaCards=10;

  void initState(){
    super.initState();
    _galaxia=widget.sistemaPlanetario.galaxia.nome;
    _nome=widget.sistemaPlanetario.nome;
    _idade=widget.sistemaPlanetario.idade;
    _qtdPlanetas=widget.sistemaPlanetario.qtdPlanetas;
    _qtdEstrelas=widget.sistemaPlanetario.qtdEstrelas;
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
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/editar_sistema_planetario", arguments: widget.sistemaPlanetario);
                  // do something
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