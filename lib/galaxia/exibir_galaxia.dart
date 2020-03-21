import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/widgets/show_card/show_card.dart';


class exibir_galaxia extends StatefulWidget {
  @override

  Galaxia galaxia;

  exibir_galaxia({this.galaxia});

  _exibir_galaxiaState createState() => _exibir_galaxiaState();
}

class _exibir_galaxiaState extends State<exibir_galaxia> {

  String _nome;
  double _distancia;
  int _qtdSistemas;
  double _diferencaCards=10;

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
        widget.galaxia.deletarGalaxia();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.popUntil(context, ModalRoute.withName("/listar_galaxia"));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Deletar galáxia"),
      content: Text("Você gostaria de deletar a galáxia $_nome?"),
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

  Firestore db = Firestore.instance;
  ScrollController scrollController = ScrollController();
  bool isExpanded = false;

  void initState(){
    super.initState();
    _nome=widget.galaxia.nome;
    _distancia=widget.galaxia.distanciaTerra;
    _qtdSistemas=widget.galaxia.qtdSistemas;
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
                "Galáxia $_nome"
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/editar_galaxia", arguments: widget.galaxia);
                  // do something
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
                  conteudo: widget.galaxia.nome,
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Distância da Terra: ",
                  conteudo: _distancia.toString() + " Anos-luz",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Qtd. Sistemas: ",
                  conteudo: _qtdSistemas == 1 ? _qtdSistemas.toString() + " Sistema" :
                  _qtdSistemas.toString() + " Sistemas",
                  diferencaCards: _diferencaCards,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: db.collection("sistemas_planetarios").where("idGalaxia", isEqualTo: widget.galaxia.id).orderBy("nome").snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading...");
                    }
                    else{

                      final sistemasDB = snapshot.data.documents;
                      List<SistemaPlanetario> listaSistemas = List();

                      for(DocumentSnapshot item in sistemasDB){
                        var dados = item.data;
                        SistemaPlanetario sistemaPlanetario = SistemaPlanetario();
                        sistemaPlanetario.id = item.documentID;
                        sistemaPlanetario.nome = dados["nome"];
                        sistemaPlanetario.idade = double.tryParse(dados["idade"].toString());
                        sistemaPlanetario.qtdEstrelas = int.tryParse(dados["qtdEstrelas"].toString());
                        sistemaPlanetario.qtdPlanetas = int.tryParse(dados["qtdPlanetas"].toString());
                        sistemaPlanetario.galaxia = widget.galaxia;
                        listaSistemas.add(sistemaPlanetario);
                      }

                      return Padding(
                          padding: EdgeInsets.only(bottom: _diferencaCards),
                          child: Material(
                            color: Color.fromRGBO(64, 75, 96, 0.9),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                            child: GroovinExpansionTile(
                              title: Text("Sistemas Planetários", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, position){
                                    return Padding(
                                      padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                      child: Text(listaSistemas[position].nome,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )

                      );
                    }
                  },
                )

              ],
            ),
          ),
        )
    );
  }
}