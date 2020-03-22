import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/search_delegates/SearchDelegateGalaxia.dart';
import 'package:universo_bd/widgets/custom_card/custom_card.dart';
import 'package:universo_bd/custom_icons_icons.dart';
import 'package:universo_bd/widgets/navigation_drawer.dart';

class listar_galaxia extends StatefulWidget {

  @override
  _listar_galaxiaState createState() => _listar_galaxiaState();
}

class _listar_galaxiaState extends State<listar_galaxia> {

  Firestore db = Firestore.instance;
  String query = "";
  List<Galaxia> listaGalaxias = List();

  List<Widget> actionsAppBar(){
    if(query == ""){
      setState(() {});
      return [IconButton(
        icon: Icon(Icons.search),
        onPressed: () async{
          final String selected = await showSearch(context: context, delegate: SearchDelegateGalaxia(listaGalaxias));
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
            final String selected = await showSearch(context: context, delegate: SearchDelegateGalaxia(listaGalaxias));
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
        drawer: navigation_drawer(tela: "listar_galaxia"),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, "/cadastrar_galaxia");
          },
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Galáxias"),
          actions: actionsAppBar(),
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection("galaxias").orderBy("nome").snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Carregando galáxias",
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
                  final galaxiasDB = snapshot.data.documents;
                  listaGalaxias = List();

                  for(DocumentSnapshot item in galaxiasDB){
                    var dados = item.data;
                    Galaxia galaxia = Galaxia();
                    galaxia.id = item.documentID;
                    galaxia.nome = dados["nome"];
                    galaxia.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                    galaxia.qtdSistemas = int.tryParse(dados["qtdSistemas"].toString());
                    listaGalaxias.add(galaxia);
                  }

                  List<Galaxia> galaxiasProcuradas = query.isEmpty ? listaGalaxias :
                  listaGalaxias.where((check) => check.nome.toLowerCase().contains(query.toLowerCase())).toList();

                  return ListView.builder(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: galaxiasProcuradas.length,
                      itemBuilder: (context, position){
                        Galaxia galaxia = galaxiasProcuradas[position];

                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "/exibir_galaxia", arguments: galaxia);
                          },
                          child: custom_card(
                              icon: CustomIcons.black_hole,
                              title: galaxia.nome,
                              subtitle1: "Distância da Terra: " + galaxia.distanciaTerra.toString() + " anos-luz",
                              subtitle2: "Qtd. de sistemas: " + galaxia.qtdSistemas.toString()
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
