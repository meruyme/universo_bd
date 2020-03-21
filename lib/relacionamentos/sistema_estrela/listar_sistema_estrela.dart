import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/classes/SistemaEstrela.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/widgets/custom_card/custom_card_relations.dart';
import 'package:universo_bd/relations_icons_icons.dart';

class listar_sistema_estrela extends StatefulWidget {

  @override
  _listar_sistema_estrelaState createState() => _listar_sistema_estrelaState();
}

class _listar_sistema_estrelaState extends State<listar_sistema_estrela> {

  Firestore db = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/fundo_telas6.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.pushNamed(context, "/cadastrar_sistema_estrela");
            },
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: Text("Relações Sistemas-Estrelas"),
          ),
          body: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection("sistemas_estrelas").snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Carregando relações",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          CircularProgressIndicator()
                        ],
                      ),
                    );
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

                    return ListView.builder(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
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
                                sistemaEstrela.sistemaPlanetario.id = dados.documentID;
                                sistemaEstrela.sistemaPlanetario.nome = dados["nome"];
                                sistemaEstrela.sistemaPlanetario.idade = double.tryParse(dados["idade"].toString());
                                sistemaEstrela.sistemaPlanetario.qtdEstrelas = int.tryParse(dados["qtdEstrelas"].toString());
                                sistemaEstrela.sistemaPlanetario.qtdPlanetas = int.tryParse(dados["qtdPlanetas"].toString());
                                Galaxia galaxia = Galaxia();
                                galaxia.id = dados["idGalaxia"];
                                sistemaEstrela.sistemaPlanetario.galaxia = galaxia;

                                return StreamBuilder<DocumentSnapshot>(
                                  stream: db.collection("galaxias").document(sistemaEstrela.sistemaPlanetario.galaxia.id).snapshots(),
                                  builder: (context, snapshotGalaxy){
                                    if(!snapshotGalaxy.hasData){
                                      return Text("");
                                    }
                                    else{
                                      final dados = snapshotGalaxy.data;
                                      sistemaEstrela.sistemaPlanetario.galaxia.nome = dados["nome"];
                                      sistemaEstrela.sistemaPlanetario.galaxia.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                                      sistemaEstrela.sistemaPlanetario.galaxia.qtdSistemas = int.tryParse(dados["qtdSistemas"].toString());

                                      return StreamBuilder<DocumentSnapshot>(
                                          stream: db.collection("estrelas").document(sistemaEstrela.estrela.id).snapshots(),
                                          builder: (context, snapshotPlanet){
                                            if(!snapshotPlanet.hasData){
                                              return Text("");
                                            }
                                            else{
                                              final dados = snapshotPlanet.data;
                                              if(dados["tipo"] != "Gigante Vermelha"){
                                                sistemaEstrela.estrela.nome = dados["nome"];
                                                sistemaEstrela.estrela.id = dados.documentID;
                                                sistemaEstrela.estrela.tamanho = double.tryParse(dados["tamanho"].toString());
                                                sistemaEstrela.estrela.idade = double.tryParse(dados["idade"].toString());
                                                sistemaEstrela.estrela.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                                                sistemaEstrela.estrela.tipo = dados["tipo"];
                                              }
                                              else{
                                                GiganteVermelha estrela = GiganteVermelha();
                                                estrela.nome = dados["nome"];
                                                estrela.id = dados.documentID;
                                                estrela.tamanho = double.tryParse(dados["tamanho"].toString());
                                                estrela.idade = double.tryParse(dados["idade"].toString());
                                                estrela.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                                                estrela.morta = dados["morta"];
                                                estrela.tipo = dados["tipo"];
                                                sistemaEstrela.estrela = estrela;
                                              }

                                              return GestureDetector(
                                                onTap: (){
                                                  Navigator.pushNamed(context, "/exibir_sistema_estrela", arguments: sistemaEstrela);
                                                },
                                                child: custom_card_relations(
                                                  icon: RelationsIcons.system_star,
                                                  title1: "Sistema Planetário: " + sistemaEstrela.sistemaPlanetario.nome,
                                                  title2: "Estrela: " + sistemaEstrela.estrela.nome,
                                                ),
                                              );
                                            }
                                          }
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          );
                        }
                    );
                  }
                },
              )
          ),
        )
    );
  }
}
