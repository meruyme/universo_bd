import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/custom_card.dart';
import 'package:universo_bd/custom_icons_icons.dart';
import 'package:universo_bd/navigation_drawer.dart';

class listar_sistema_planetario extends StatefulWidget {

  @override
  _listar_sistema_planetarioState createState() => _listar_sistema_planetarioState();
}


class _listar_sistema_planetarioState extends State<listar_sistema_planetario> {

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
        drawer: navigation_drawer(tela: "listar_sistema_planetario"),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, "/cadastrar_sistema_planetario");
          },
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Sistemas Planetários"),
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection("sistemas_planetarios").orderBy("nome").snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Carregando sistemas planetários",
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
                  final sistemasDB = snapshot.data.documents;
                  List<SistemaPlanetario> listaSistemas = List();

                  for(DocumentSnapshot item in sistemasDB){
                    var dados = item.data;
                    SistemaPlanetario sistemaPlanetario = SistemaPlanetario();
                    Galaxia galaxia = Galaxia();
                    galaxia.id = dados["idGalaxia"];
                    sistemaPlanetario.id = item.documentID;
                    sistemaPlanetario.nome = dados["nome"];
                    sistemaPlanetario.idade = double.tryParse(dados["idade"].toString());
                    sistemaPlanetario.qtdEstrelas = int.tryParse(dados["qtdEstrelas"].toString());
                    sistemaPlanetario.qtdPlanetas = int.tryParse(dados["qtdPlanetas"].toString());
                    sistemaPlanetario.galaxia = galaxia;
                    listaSistemas.add(sistemaPlanetario);
                  }

                  return ListView.builder(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, position){
                        SistemaPlanetario sistemaPlanetario = listaSistemas[position];
                        return StreamBuilder<DocumentSnapshot>(
                          stream: db.collection("galaxias").document(sistemaPlanetario.galaxia.id).snapshots(),
                          builder: (context, snapshotGalaxy){
                            if(!snapshotGalaxy.hasData){
                              return Text("");
                            }
                            else{
                              final dados = snapshotGalaxy.data;
                              sistemaPlanetario.galaxia.nome = dados["nome"];
                              sistemaPlanetario.galaxia.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                              sistemaPlanetario.galaxia.qtdSistemas = int.tryParse(dados["qtdSistemas"].toString());

                              return GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, "/exibir_sistema_planetario",
                                      arguments: sistemaPlanetario);
                                },
                                child: custom_card(
                                    icon: CustomIcons.solar_system,
                                    title: sistemaPlanetario.nome,
                                    subtitle1: "Idade: " + sistemaPlanetario.idade.toString() + " bilhões de anos",
                                    subtitle2: "Galáxia: " + sistemaPlanetario.galaxia.nome
                                ),
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
      ),
    );
  }
}
