import 'package:flutter/material.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/show_card.dart';

class exibir_gigante_vermelha extends StatefulWidget {

  GiganteVermelha estrela;

  exibir_gigante_vermelha({this.estrela});

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
    if(widget.estrela.morta==true){
      _textoMorte="Essa estrela está morta :(";
    }else{
      _textoMorte="Essa estrela está viva :)";
    }
    _nome=widget.estrela.nome;
    _distancia=widget.estrela.distanciaTerra;
    _idade=widget.estrela.idade;
    _tamanho=widget.estrela.tamanho;
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
                  Navigator.pushNamed(context, "/editar_gigante_vermelha", arguments: widget.estrela);
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => editar_gigante_vermelha(_nome,_tamanho,_idade,_distancia,widget.morteAntiga))
                  );*/
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