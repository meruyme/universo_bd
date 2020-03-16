import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/planeta/cadastrar_planeta.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/custom_card.dart';
import 'package:universo_bd/custom_icons_icons.dart';
import 'package:universo_bd/planeta/exibir_planeta.dart';
import 'package:universo_bd/navigation_drawer.dart';

class listar_planeta extends StatefulWidget {

  @override
  _listar_planetaState createState() => _listar_planetaState();
}

class _listar_planetaState extends State<listar_planeta> {

  Firestore db = Firestore.instance;


  /*Future<List<Planeta>> _recuperarPlanetas() async{

    Firestore db = Firestore.instance;
    QuerySnapshot querySnapshot = await db.collection("planetas")
      .getDocuments();

    List<Planeta> listaPlanetas = List();
    for(DocumentSnapshot item in querySnapshot.documents){
      var dados = item.data;
      Planeta planeta = Planeta();
      planeta.id = item.documentID;
      planeta.nome = dados["nome"];
      planeta.massa = double.tryParse(dados["massa"].toString());
      planeta.tamanho = double.tryParse(dados["tamanho"].toString());
      listaPlanetas.add(planeta);

    }

    return listaPlanetas;

  }*/


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
        drawer: navigation_drawer(tela: "listar_planeta"),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, "/cadastrar_planeta");
          },
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Planetas"),
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: db.collection("planetas").orderBy("nome").snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Carregando planetas",
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
                final planetasDB = snapshot.data.documents;
                List<Planeta> listaPlanetas = List();

                for(DocumentSnapshot item in planetasDB){
                  var dados = item.data;
                  Planeta planeta = Planeta();
                  planeta.id = item.documentID;
                  planeta.nome = dados["nome"];
                  planeta.massa = double.tryParse(dados["massa"].toString());
                  planeta.tamanho = double.tryParse(dados["tamanho"].toString());
                  planeta.velocidadeRotacao = double.tryParse(dados["velocidadeRotacao"].toString());
                  List<dynamic> auxDyn = dados["componentes"];
                  planeta.componentes = List<String>.from(auxDyn);
                  listaPlanetas.add(planeta);
                }

                return ListView.builder(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, position){
                      //List<Planeta> listaItens = snapshot.data;
                      Planeta planeta = listaPlanetas[position];
                      //planeta.exibirPlaneta();
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/exibir_planeta", arguments: planeta);

                          /*Navigator.push(
                              context,
                            MaterialPageRoute(
                                builder: (context) => exibir_planeta(planeta: planeta,)
                            )
                          );*/
                        },
                        child: custom_card(
                            icon: CustomIcons.planet,
                            title: planeta.nome,
                            subtitle1: "Tamanho: " + planeta.tamanho.toString() + " km",
                            subtitle2: "Massa: " + planeta.massa.toString() + " kg"
                        ),
                      );
                    }
                );
              }

            },
          )

          /*FutureBuilder<List<Planeta>>(
            future: _recuperarPlanetas(),
            builder: (context, snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Carregando planetas",
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
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 16),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, position){
                        List<Planeta> listaItens = snapshot.data;
                        Planeta planeta = listaItens[position];

                        return GestureDetector(
                          onTap: (){
                            print(planeta.nome);
                          },
                          child: custom_card(
                              icon: Icons.brightness_7,
                              title: planeta.nome,
                              subtitle1: "Tamanho: " + planeta.tamanho.toString() + "km",
                              subtitle2: "Massa: " + planeta.massa.toString() + "kg"
                          ),
                        );
                      }
                  );
                  break;
              }
            },
          )*/
        ),
      ),
    );
  }
}
