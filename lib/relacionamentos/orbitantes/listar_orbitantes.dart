import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/classes/Orbitantes.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/classes/SateliteNatural.dart';
import 'package:universo_bd/custom_card_orbitantes.dart';
import 'package:universo_bd/relations_icons_icons.dart';

class listar_orbitantes extends StatefulWidget {

  @override
  _listar_orbitantesState createState() => _listar_orbitantesState();
}

class _listar_orbitantesState extends State<listar_orbitantes> {

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
              Navigator.pushNamed(context, "/cadastrar_orbitantes");
            },
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: Text("Orbitantes"),
          ),
          body: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection("orbitantes").snapshots(),
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
                    List<Orbitantes> listaRelacoes = List();

                    for(DocumentSnapshot item in relacoesDB){
                      var dados = item.data;
                      Orbitantes orbitantes = Orbitantes();
                      Estrela estrela = Estrela();
                      Planeta planeta = Planeta();
                      SateliteNatural sateliteNatural = SateliteNatural();
                      orbitantes.id = item.documentID;
                      planeta.id = dados["idPlaneta"];
                      estrela.id = dados["idEstrela"];
                      sateliteNatural.id = dados["idSatelite"];
                      orbitantes.estrela = estrela;
                      orbitantes.planeta = planeta;
                      orbitantes.sateliteNatural = sateliteNatural;
                      listaRelacoes.add(orbitantes);
                    }

                    return ListView.builder(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
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
                                if(orbitantes.planeta.id == "-"){
                                  orbitantes.planeta.nome = "—";
                                }
                                else{
                                  orbitantes.planeta.nome = dados["nome"];
                                  orbitantes.planeta.massa = double.tryParse(dados["massa"].toString());
                                  orbitantes.planeta.tamanho = double.tryParse(dados["tamanho"].toString());
                                  orbitantes.planeta.velocidadeRotacao = double.tryParse(dados["velocidadeRotacao"].toString());
                                  List<dynamic> auxDyn = dados["componentes"];
                                  orbitantes.planeta.componentes = List<String>.from(auxDyn);
                                }

                                return StreamBuilder<DocumentSnapshot>(
                                  stream: db.collection("satelites_naturais").document(orbitantes.sateliteNatural.id).snapshots(),
                                  builder: (context, snapshotSatellite){
                                    if(!snapshotSatellite.hasData){
                                      return Text("");
                                    }
                                    else{
                                      final dados = snapshotSatellite.data;
                                      if(orbitantes.sateliteNatural.id == "-"){
                                        orbitantes.sateliteNatural.nome = "—";
                                      }
                                      else{
                                        orbitantes.sateliteNatural.nome = dados["nome"];
                                        orbitantes.sateliteNatural.massa = double.tryParse(dados["massa"].toString());
                                        orbitantes.sateliteNatural.tamanho = double.tryParse(dados["tamanho"].toString());
                                        List<dynamic> auxDyn = dados["componentes"];
                                        orbitantes.sateliteNatural.componentes = List<String>.from(auxDyn);
                                      }

                                      return StreamBuilder<DocumentSnapshot>(
                                          stream: db.collection("estrelas").document(orbitantes.estrela.id).snapshots(),
                                          builder: (context, snapshotPlanet){
                                            if(!snapshotPlanet.hasData){
                                              return Text("");
                                            }
                                            else{
                                              final dados = snapshotPlanet.data;
                                              if(orbitantes.estrela.id == "-"){
                                                orbitantes.estrela.nome = "—";
                                              }else{
                                                if(dados["tipo"] != "Gigante Vermelha"){
                                                  orbitantes.estrela.nome = dados["nome"];
                                                  orbitantes.estrela.id = dados.documentID;
                                                  orbitantes.estrela.tamanho = double.tryParse(dados["tamanho"].toString());
                                                  orbitantes.estrela.idade = double.tryParse(dados["idade"].toString());
                                                  orbitantes.estrela.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                                                  orbitantes.estrela.tipo = dados["tipo"];
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
                                                  orbitantes.estrela = estrela;
                                                }
                                              }

                                              return GestureDetector(
                                                onTap: (){
                                                  Navigator.pushNamed(context, "/exibir_orbitantes", arguments: orbitantes);
                                                },
                                                child: custom_card_orbitantes(
                                                  icon: RelationsIcons.orbit,
                                                  title1: "Planeta: " + orbitantes.planeta.nome,
                                                  title2: "Estrela: " + orbitantes.estrela.nome,
                                                  title3: "Satélite Natural: " + orbitantes.sateliteNatural.nome,
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
