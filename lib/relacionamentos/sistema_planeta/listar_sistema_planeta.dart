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
                    sistemaPlaneta.id = item.documentID;
                    sistemaPlaneta.idPlaneta = dados["idPlaneta"];
                    sistemaPlaneta.idSistema = dados["idSistema"];
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
                      stream: db.collection("sistemas_planetarios").document(sistemaPlaneta.idSistema).snapshots(),
                      builder: (context, snapshotSystem){
                        if(!snapshotSystem.hasData){
                          return Text("");
                        }
                        else{
                          final dados = snapshotSystem.data;
                          SistemaPlanetario sistemaPlanetario = SistemaPlanetario();
                          sistemaPlanetario.id = dados.documentID;
                          sistemaPlanetario.nome = dados["nome"];
                          sistemaPlanetario.idade = double.tryParse(dados["idade"].toString());
                          sistemaPlanetario.qtdEstrelas = int.tryParse(dados["qtdEstrelas"].toString());
                          sistemaPlanetario.qtdPlanetas = int.tryParse(dados["qtdPlanetas"].toString());
                          sistemaPlanetario.idGalaxia = dados["idGalaxia"];

                          return StreamBuilder<DocumentSnapshot>(
                            stream: db.collection("galaxias").document(sistemaPlanetario.idGalaxia).snapshots(),
                            builder: (context, snapshotGalaxy){
                              if(!snapshotGalaxy.hasData){
                                return Text("");
                              }
                              else{
                                final dados = snapshotGalaxy.data;
                                Galaxia galaxia = Galaxia();
                                galaxia.id = dados.documentID;
                                galaxia.nome = dados["nome"];
                                galaxia.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                                galaxia.qtdSistemas = int.tryParse(dados["qtdSistemas"].toString());

                                return StreamBuilder<DocumentSnapshot>(
                                  stream: db.collection("planetas").document(sistemaPlaneta.idPlaneta).snapshots(),
                                  builder: (context, snapshotPlanet){
                                    if(!snapshotPlanet.hasData){
                                      return Text("");
                                    }
                                    else{
                                      final dados = snapshotPlanet.data;
                                      Planeta planeta = Planeta();
                                      planeta.id = dados.documentID;
                                      planeta.nome = dados["nome"];
                                      planeta.massa = double.tryParse(dados["massa"].toString());
                                      planeta.tamanho = double.tryParse(dados["tamanho"].toString());
                                      planeta.velocidadeRotacao = double.tryParse(dados["velocidadeRotacao"].toString());
                                      List<dynamic> auxDyn = dados["componentes"];
                                      planeta.componentes = List<String>.from(auxDyn);

                                      return GestureDetector(
                                        onTap: (){
                                          //Navigator.pushNamed(context, "/exibir_planeta", arguments: planeta);
                                        },
                                        child: custom_card_relations(
                                          icon: CustomIcons.solar_system,
                                          title1: "Sistema Planetário: " + sistemaPlanetario.nome,
                                          title2: "Planeta: " + planeta.nome,
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
