import 'package:flutter/material.dart';
import 'package:universo_bd/arguments/ArgumentsGiganteVermelha.dart';
import 'package:universo_bd/show_card.dart';

class exibir_gigante_vermelha extends StatefulWidget {

  ArgumentsGiganteVermelha arguments;

  exibir_gigante_vermelha({this.arguments});

  _exibir_gigante_vermelhaState createState() => _exibir_gigante_vermelhaState();
}

class _exibir_gigante_vermelhaState extends State<exibir_gigante_vermelha> {


  String _nome;
  double _idade;
  double _tamanho;
  double _distancia;
  String _textoMorte;
  String _tipo;

  double _diferencaCards=10;

  void initState() {
    super.initState();
    if(widget.arguments.giganteVermelha.morta==true){
      _textoMorte="Essa estrela está morta :(";
    }else{
      _textoMorte="Essa estrela está viva :)";
    }
    _nome=widget.arguments.giganteVermelha.nome;
    _distancia=widget.arguments.giganteVermelha.distanciaTerra;
    _idade=widget.arguments.giganteVermelha.idade;
    _tamanho=widget.arguments.giganteVermelha.tamanho;
    _tipo = widget.arguments.giganteVermelha.tipo;
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
            Navigator.pushNamed(context, "/editar_gigante_vermelha", arguments: widget.arguments.giganteVermelha);
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
      ];
    }
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
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
                show_card(
                  titulo: "Vitalidade: ",
                  conteudo: _textoMorte,
                  diferencaCards: _diferencaCards,
                ),
              ],
            ),
          ),
        )
    );
  }
}