import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/SistemaPlaneta.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/custom_card_relations.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/custom_icons_icons.dart';

class listar_sistema_planeta extends StatefulWidget {

  @override
  _listar_sistema_planetaState createState() => _listar_sistema_planetaState();
}

class _listar_sistema_planetaState extends State<listar_sistema_planeta> {

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
            Navigator.pushNamed(context, "/cadastrar_sistema_planeta");
          },
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Relações Sistemas-Planetas"),
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection("sistemas_planetas").snapshots(),
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

                return ListView.builder(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, position){
                    SistemaPlaneta sistemaPlaneta = listaRelacoes[position];
                    return StreamBuilder<DocumentSnapshot>(
                      stream: db.collection("sistemas_planetarios").document(sistemaPlaneta.sistemaPlanetario.id).snapshots(),
                      builder: (context, snapshotSystem){
                        if(!snapshotSystem.hasData){
                          return Text("");
                        }
                        else{
                          final dados = snapshotSystem.data;
                          sistemaPlaneta.sistemaPlanetario.id = dados.documentID;
                          sistemaPlaneta.sistemaPlanetario.nome = dados["nome"];
                          sistemaPlaneta.sistemaPlanetario.idade = double.tryParse(dados["idade"].toString());
                          sistemaPlaneta.sistemaPlanetario.qtdEstrelas = int.tryParse(dados["qtdEstrelas"].toString());
                          sistemaPlaneta.sistemaPlanetario.qtdPlanetas = int.tryParse(dados["qtdPlanetas"].toString());
                          Galaxia galaxia = Galaxia();
                          galaxia.id = dados["idGalaxia"];
                          sistemaPlaneta.sistemaPlanetario.galaxia = galaxia;

                          return StreamBuilder<DocumentSnapshot>(
                            stream: db.collection("galaxias").document(sistemaPlaneta.sistemaPlanetario.galaxia.id).snapshots(),
                            builder: (context, snapshotGalaxy){
                              if(!snapshotGalaxy.hasData){
                                return Text("");
                              }
                              else{
                                final dados = snapshotGalaxy.data;
                                sistemaPlaneta.sistemaPlanetario.galaxia.id = dados.documentID;
                                sistemaPlaneta.sistemaPlanetario.galaxia.nome = dados["nome"];
                                sistemaPlaneta.sistemaPlanetario.galaxia.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                                sistemaPlaneta.sistemaPlanetario.galaxia.qtdSistemas = int.tryParse(dados["qtdSistemas"].toString());

                                return StreamBuilder<DocumentSnapshot>(
                                  stream: db.collection("planetas").document(sistemaPlaneta.planeta.id).snapshots(),
                                  builder: (context, snapshotPlanet){
                                    if(!snapshotPlanet.hasData){
                                      return Text("");
                                    }
                                    else{
                                      final dados = snapshotPlanet.data;
                                      sistemaPlaneta.planeta.nome = dados["nome"];
                                      sistemaPlaneta.planeta.massa = double.tryParse(dados["massa"].toString());
                                      sistemaPlaneta.planeta.tamanho = double.tryParse(dados["tamanho"].toString());
                                      sistemaPlaneta.planeta.velocidadeRotacao = double.tryParse(dados["velocidadeRotacao"].toString());
                                      List<dynamic> auxDyn = dados["componentes"];
                                      sistemaPlaneta.planeta.componentes = List<String>.from(auxDyn);

                                      return GestureDetector(
                                        onTap: (){
                                          //Navigator.pushNamed(context, "/exibir_planeta", arguments: planeta);
                                        },
                                        child: custom_card_relations(
                                          icon: CustomIcons.solar_system,
                                          title1: "Sistema Planetário: " + sistemaPlaneta.sistemaPlanetario.nome,
                                          title2: "Planeta: " + sistemaPlaneta.planeta.nome,
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
