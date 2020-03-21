import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/arguments/ArgumentsSistema.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/classes/SistemaEstrela.dart';
import 'package:universo_bd/classes/SistemaPlaneta.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
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
  Firestore db = Firestore.instance;
  double _diferencaCards=10;
  ScrollController scrollControllerPlanet = ScrollController();
  bool isExpandedPlanet = false;
  ScrollController scrollControllerStar = ScrollController();
  bool isExpandedStar = false;


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
                StreamBuilder(
                 stream: db.collection("sistemas_planetas").where("idSistema", isEqualTo: widget.arguments.sistemaPlanetario.id).snapshots(),
                 builder: (context, snapshot){
                   if(!snapshot.hasData){
                     return Text("Loading...");
                   }
                   else{
                     final relacoesDB = snapshot.data.documents;
                     List<SistemaPlaneta> listaRelacoes = List();

                     for(DocumentSnapshot item in relacoesDB){
                       var dados = item.data;
                       SistemaPlaneta sistemaPlaneta = SistemaPlaneta();
                       SistemaPlanetario sistemaPlanetario = SistemaPlanetario();
                       Planeta planeta = Planeta();
                       sistemaPlaneta.id = item.documentID;
                       sistemaPlanetario.id = dados["idSistema"];
                       planeta.id = dados["idPlaneta"];
                       sistemaPlaneta.sistemaPlanetario = sistemaPlanetario;
                       sistemaPlaneta.planeta = planeta;
                       listaRelacoes.add(sistemaPlaneta);
                     }

                     return Padding(
                         padding: EdgeInsets.only(bottom: 25),
                         child: Material(
                           color: Color.fromRGBO(64, 75, 96, 0.9),
                           elevation: 2.0,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                           child: GroovinExpansionTile(
                             title: Text("Planetas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                                 itemCount: snapshot.data.documents.length,
                                 itemBuilder: (context, position){
                                   SistemaPlaneta sistemaPlaneta = listaRelacoes[position];
                                   return StreamBuilder<DocumentSnapshot>(
                                       stream: db.collection("planetas").document(sistemaPlaneta.planeta.id).snapshots(),
                                       builder: (context, snapshotPlanet){
                                         if(!snapshotPlanet.hasData){
                                           return Text("");
                                         }
                                         else{
                                           final dados = snapshotPlanet.data;
                                           sistemaPlaneta.planeta.nome = dados["nome"];
                                           return Padding(
                                             padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                             child: Text(sistemaPlaneta.planeta.nome,
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
                  stream: db.collection("sistemas_estrelas").where("idSistema", isEqualTo: widget.arguments.sistemaPlanetario.id).snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading...");
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
                          padding: EdgeInsets.only(bottom: _diferencaCards),
                          child: Material(
                            color: Color.fromRGBO(64, 75, 96, 0.9),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                            child: GroovinExpansionTile(
                              title: Text("Estrelas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, position){
                                    SistemaEstrela sistemaEstrela = listaRelacoes[position];
                                    return StreamBuilder<DocumentSnapshot>(
                                        stream: db.collection("estrelas").document(sistemaEstrela.estrela.id).snapshots(),
                                        builder: (context, snapshotStar){
                                          if(!snapshotStar.hasData){
                                            return Text("");
                                          }
                                          else{
                                            final dados = snapshotStar.data;
                                            sistemaEstrela.estrela.nome = dados["nome"];
                                            return Padding(
                                              padding: EdgeInsetsDirectional.only(start: 20, bottom: 10, end: 10, top: 5),
                                              child: Text(sistemaEstrela.estrela.nome,
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
                )
              ],
            ),
          ),
        )
    );
  }
}