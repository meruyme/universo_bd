import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/show_card.dart';

class exibir_estrela extends StatefulWidget {

  Estrela estrela;

  exibir_estrela({this.estrela});

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
    _nome = widget.estrela.nome;
    _distancia = widget.estrela.distanciaTerra;
    _idade = widget.estrela.idade;
    _tamanho = widget.estrela.tamanho;
    _tipo = widget.estrela.tipo;
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
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/editar_estrela", arguments: widget.estrela);
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
                  conteudo: widget.estrela.nome,
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Tamanho: ",
                  conteudo: widget.estrela.tamanho.toString() + "Km",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Idade: ",
                  conteudo: widget.estrela.idade.toString() + " Bilhões de anos",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Distância da Terra: ",
                  conteudo: widget.estrela.distanciaTerra.toString() + " Anos-luz",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Tipo da estrela: ",
                  conteudo: widget.estrela.tipo,
                  diferencaCards: _diferencaCards,
                ),
              ],
            ),
          ),
        )
    );
  }
}