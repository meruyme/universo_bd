import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/arguments/ArgumentsPlaneta.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/search_delegates/SearchDelegatePlaneta.dart';
import 'package:universo_bd/widgets/custom_card/custom_card.dart';
import 'package:universo_bd/custom_icons_icons.dart';
import 'package:universo_bd/widgets/navigation_drawer.dart';

class listar_planeta extends StatefulWidget {

  @override
  _listar_planetaState createState() => _listar_planetaState();
}

class _listar_planetaState extends State<listar_planeta> {

  Firestore db = Firestore.instance;
  List<Planeta> listaPlanetas = List();
  String query = "";

  List<Widget> actionsAppBar(){
    if(query == ""){
      setState(() {});
      return [IconButton(
        icon: Icon(Icons.search),
        onPressed: () async{
          final String selected = await showSearch(context: context, delegate: SearchDelegatePlaneta(listaPlanetas));
          setState(() {
            query = selected;
          });
        },
      )];
    }
    else{
      setState(() {});
      return [IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            setState(() {
              query = "";
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async{
            final String selected = await showSearch(context: context, delegate: SearchDelegatePlaneta(listaPlanetas));
            setState(() {
              query = selected;
            });
          },
        ),
      ];
    }
  }


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
          actions: actionsAppBar()
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
                listaPlanetas = List();

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

                List<Planeta> planetasProcurados = query.isEmpty ? listaPlanetas :
                    listaPlanetas.where((check) => check.nome.toLowerCase().contains(query.toLowerCase())).toList();

                return ListView.builder(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: planetasProcurados.length,
                    itemBuilder: (context, position){
                      Planeta planeta = planetasProcurados[position];
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/exibir_planeta", arguments: ArgumentsPlaneta(planeta, "exibir_planeta"));
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
        ),
      ),
    );
  }
}
