import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/arguments/ArgumentsSatelite.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/Orbitantes.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/widgets/show_card/show_card.dart';

class exibir_satelite_natural extends StatefulWidget {

  ArgumentsSatelite arguments;

  exibir_satelite_natural({this.arguments});

  @override
  _exibir_satelite_naturalState createState() => _exibir_satelite_naturalState();
}

class _exibir_satelite_naturalState extends State<exibir_satelite_natural> {
  @override

  double width;
  double _diferencaCards=10;
  ScrollController scrollController = ScrollController();
  bool isExpanded = false, isExpandedPlanet = false, isExpandedStar = false;
  ScrollController scrollControllerPlanet = ScrollController();
  ScrollController scrollControllerStar = ScrollController();

  Firestore db = Firestore.instance;

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
            Navigator.pushNamed(context, "/editar_satelite_natural", arguments: widget.arguments.sateliteNatural);
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

  confirmarDeletar(){
    // set up the buttons
    String _nome = widget.arguments.sateliteNatural.nome;
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
        widget.arguments.sateliteNatural.deletarSateliteNatural();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.popUntil(context, ModalRoute.withName("/listar_satelite_natural"));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Deletar satélite natural"),
      content: Text("Você gostaria de deletar o satélite natural $_nome?"),
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
                "Satélite " + widget.arguments.sateliteNatural.nome
            ),
            actions: actionsAppBar()
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                show_card(
                  titulo: "Nome: ",
                  conteudo: widget.arguments.sateliteNatural.nome,
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Tamanho: ",
                  conteudo: widget.arguments.sateliteNatural.tamanho.toString() + " Km",
                  diferencaCards: _diferencaCards,
                ),
                show_card(
                  titulo: "Massa: ",
                  conteudo: widget.arguments.sateliteNatural.massa.toString() + " Kg",
                  diferencaCards: _diferencaCards,
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Material(
                      color: Color.fromRGBO(64, 75, 96, 0.9),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                      child: GroovinExpansionTile(
                        title: Text("Componentes gasosos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                            itemCount: widget.arguments.sateliteNatural.componentes.length,
                            itemBuilder: (context, position){
                              List aux = widget.arguments.sateliteNatural.componentes[position].split("-");
                              return Padding(
                                padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                child: Text("Gás: " + aux[0] +
                                    " - Porcentagem: " + aux[1] + "%",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                ),
                StreamBuilder(
                  stream: db.collection("orbitantes").where("idSatelite", isEqualTo: widget.arguments.sateliteNatural.id).snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("");
                    }
                    else{
                      final relacoesDB = snapshot.data.documents;
                      List<Orbitantes> listaRelacoes = List();

                      for(DocumentSnapshot item in relacoesDB){
                        var dados = item.data;
                        if(dados["idEstrela"] != "-" && listaRelacoes.firstWhere((itemToCheck) => itemToCheck.estrela.id == dados["idEstrela"], orElse: () => null) == null){
                          Orbitantes orbitantes = Orbitantes();
                          Estrela estrela = Estrela();
                          orbitantes.id = item.documentID;
                          estrela.id = dados["idEstrela"];
                          orbitantes.estrela = estrela;
                          listaRelacoes.add(orbitantes);
                        }
                      }

                      return Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: Material(
                            color: Color.fromRGBO(64, 75, 96, 0.9),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                            child: GroovinExpansionTile(
                              title: Text("Estrelas orbitantes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpandedStar = value;
                                });
                              },
                              inkwellRadius: !isExpandedStar
                                  ? BorderRadius.all(Radius.circular(32.0))
                                  : BorderRadius.only(
                                topRight: Radius.circular(32.0),
                                topLeft: Radius.circular(32.0),
                              ),
                              children: <Widget>[
                                ListView.builder(
                                  shrinkWrap: true,
                                  controller: scrollControllerStar,
                                  itemCount: listaRelacoes.length,
                                  itemBuilder: (context, position){
                                    Orbitantes orbitantes = listaRelacoes[position];
                                    return StreamBuilder<DocumentSnapshot>(
                                        stream: db.collection("estrelas").document(orbitantes.estrela.id).snapshots(),
                                        builder: (context, snapshotStar){
                                          if(!snapshotStar.hasData){
                                            return Text("");
                                          }
                                          else{
                                            final dados = snapshotStar.data;
                                            orbitantes.estrela.nome = dados["nome"];
                                            return Padding(
                                              padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                              child: Text(orbitantes.estrela.nome,
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                            );
                                          }
                                        }
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                      );
                    }
                  },
                ),
                StreamBuilder(
                  stream: db.collection("orbitantes").where("idSatelite", isEqualTo: widget.arguments.sateliteNatural.id).snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("");
                    }
                    else{
                      final relacoesDB = snapshot.data.documents;
                      List<Orbitantes> listaRelacoes = List();

                      for(DocumentSnapshot item in relacoesDB){
                        var dados = item.data;
                        if(dados["idPlaneta"] != "-" && listaRelacoes.firstWhere((itemToCheck) => itemToCheck.planeta.id == dados["idPlaneta"], orElse: () => null) == null){
                          Orbitantes orbitantes = Orbitantes();
                          Planeta planeta = Planeta();
                          orbitantes.id = item.documentID;
                          planeta.id = dados["idPlaneta"];
                          orbitantes.planeta = planeta;
                          listaRelacoes.add(orbitantes);
                        }
                      }

                      return Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: Material(
                            color: Color.fromRGBO(64, 75, 96, 0.9),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                            child: GroovinExpansionTile(
                              title: Text("Planetas orbitantes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpandedPlanet = value;
                                });
                              },
                              inkwellRadius: !isExpandedPlanet
                                  ? BorderRadius.all(Radius.circular(32.0))
                                  : BorderRadius.only(
                                topRight: Radius.circular(32.0),
                                topLeft: Radius.circular(32.0),
                              ),
                              children: <Widget>[
                                ListView.builder(
                                  shrinkWrap: true,
                                  controller: scrollControllerPlanet,
                                  itemCount: listaRelacoes.length,
                                  itemBuilder: (context, position){
                                    Orbitantes orbitantes = listaRelacoes[position];
                                    return StreamBuilder<DocumentSnapshot>(
                                        stream: db.collection("planetas").document(orbitantes.planeta.id).snapshots(),
                                        builder: (context, snapshotPlanet){
                                          if(!snapshotPlanet.hasData){
                                            return Text("");
                                          }
                                          else{
                                            final dados = snapshotPlanet.data;
                                            orbitantes.planeta.nome = dados["nome"];
                                            return Padding(
                                              padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                              child: Text(orbitantes.planeta.nome,
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                            );
                                          }
                                        }
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}

