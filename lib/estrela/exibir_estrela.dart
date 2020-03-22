import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/arguments/ArgumentsEstrela.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/Orbitantes.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/classes/SateliteNatural.dart';
import 'package:universo_bd/classes/SistemaEstrela.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/widgets/show_card/show_card.dart';

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
  Firestore db = Firestore.instance;
  bool isExpandedSystem = false, isExpandedSatellite = false, isExpandedPlanet = false;
  ScrollController scrollControllerSystem = ScrollController();
  ScrollController scrollControllerSatellite = ScrollController();
  ScrollController scrollControllerPlanet = ScrollController();

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
                  conteudo: _tamanho.toString() + " Km",
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
                StreamBuilder(
                  stream: db.collection("sistemas_estrelas").where("idEstrela", isEqualTo: widget.arguments.estrela.id).snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("");
                    }
                    else{
                      final relacoesDB = snapshot.data.documents;
                      List<SistemaEstrela> listaRelacoes = List();

                      for(DocumentSnapshot item in relacoesDB){
                        var dados = item.data;
                        SistemaEstrela sistemaEstrela = SistemaEstrela();
                        SistemaPlanetario sistemaPlanetario = SistemaPlanetario();
                        Estrela estrela = Estrela();
                        sistemaEstrela.id = item.documentID;
                        sistemaPlanetario.id = dados["idSistema"];
                        estrela.id = dados["idEstrela"];
                        sistemaEstrela.sistemaPlanetario = sistemaPlanetario;
                        sistemaEstrela.estrela = estrela;
                        listaRelacoes.add(sistemaEstrela);
                      }

                      return Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: Material(
                            color: Color.fromRGBO(64, 75, 96, 0.9),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                            child: GroovinExpansionTile(
                              title: Text("Sistemas planetários", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpandedSystem = value;
                                });
                              },
                              inkwellRadius: !isExpandedSystem
                                  ? BorderRadius.all(Radius.circular(32.0))
                                  : BorderRadius.only(
                                topRight: Radius.circular(32.0),
                                topLeft: Radius.circular(32.0),
                              ),
                              children: <Widget>[
                                ListView.builder(
                                  shrinkWrap: true,
                                  controller: scrollControllerSystem,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, position){
                                    SistemaEstrela sistemaEstrela = listaRelacoes[position];
                                    return StreamBuilder<DocumentSnapshot>(
                                        stream: db.collection("sistemas_planetarios").document(sistemaEstrela.sistemaPlanetario.id).snapshots(),
                                        builder: (context, snapshotSystem){
                                          if(!snapshotSystem.hasData){
                                            return Text("");
                                          }
                                          else{
                                            final dados = snapshotSystem.data;
                                            sistemaEstrela.sistemaPlanetario.nome = dados["nome"];
                                            return Padding(
                                              padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                              child: Text(sistemaEstrela.sistemaPlanetario.nome,
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
                  stream: db.collection("orbitantes").where("idEstrela", isEqualTo: widget.arguments.estrela.id).snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("");
                    }
                    else{
                      final relacoesDB = snapshot.data.documents;
                      List<Orbitantes> listaRelacoes = List();

                      for(DocumentSnapshot item in relacoesDB){
                        var dados = item.data;
                        if(dados["idSatelite"] != "-" && listaRelacoes.firstWhere((itemToCheck) => itemToCheck.sateliteNatural.id == dados["idSatelite"], orElse: () => null) == null){
                          Orbitantes orbitantes = Orbitantes();
                          SateliteNatural sateliteNatural = SateliteNatural();
                          orbitantes.id = item.documentID;
                          sateliteNatural.id = dados["idSatelite"];
                          orbitantes.sateliteNatural = sateliteNatural;
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
                              title: Text("Satélites orbitantes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              onExpansionChanged: (value) {
                                setState(() {
                                  isExpandedSatellite = value;
                                });
                              },
                              inkwellRadius: !isExpandedSatellite
                                  ? BorderRadius.all(Radius.circular(32.0))
                                  : BorderRadius.only(
                                topRight: Radius.circular(32.0),
                                topLeft: Radius.circular(32.0),
                              ),
                              children: <Widget>[
                                ListView.builder(
                                  shrinkWrap: true,
                                  controller: scrollControllerSatellite,
                                  itemCount: listaRelacoes.length,
                                  itemBuilder: (context, position){
                                    Orbitantes orbitantes = listaRelacoes[position];
                                    return StreamBuilder<DocumentSnapshot>(
                                        stream: db.collection("satelites_naturais").document(orbitantes.sateliteNatural.id).snapshots(),
                                        builder: (context, snapshotSatellite){
                                          if(!snapshotSatellite.hasData){
                                            return Text("");
                                          }
                                          else{
                                            final dados = snapshotSatellite.data;
                                            orbitantes.sateliteNatural.nome = dados["nome"];
                                            return Padding(
                                              padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                              child: Text(orbitantes.sateliteNatural.nome,
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
                  stream: db.collection("orbitantes").where("idEstrela", isEqualTo: widget.arguments.estrela.id).snapshots(),
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