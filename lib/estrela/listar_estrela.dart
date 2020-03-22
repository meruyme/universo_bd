import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/arguments/ArgumentsEstrela.dart';
import 'package:universo_bd/arguments/ArgumentsGiganteVermelha.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/search_delegates/SearchDelegateEstrela.dart';
import 'package:universo_bd/widgets/custom_card/custom_card.dart';
import 'package:universo_bd/custom_icons_icons.dart';
import 'package:universo_bd/widgets/navigation_drawer.dart';
import 'package:universo_bd/widgets/speed_dial_fab.dart';

class listar_estrela extends StatefulWidget {

  @override
  _listar_estrelaState createState() => _listar_estrelaState();
}

class _listar_estrelaState extends State<listar_estrela> {

  Firestore db = Firestore.instance;
  ScrollController scrollController;
  List<Estrela> listaEstrelas = List();
  String query = "";

  List<Widget> actionsAppBar(){
    if(query == ""){
      setState(() {});
      return [IconButton(
        icon: Icon(Icons.search),
        onPressed: () async{
          final String selected = await showSearch(context: context, delegate: SearchDelegateEstrela(listaEstrelas));
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
            final String selected = await showSearch(context: context, delegate: SearchDelegateEstrela(listaEstrelas));
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
        drawer: navigation_drawer(tela: "listar_estrela"),
        floatingActionButton: speed_dial_fab(scrollController: scrollController),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Estrelas"),
          actions: actionsAppBar()
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection("estrelas").orderBy("nome").snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Carregando estrelas",
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
                  final estrelasDB = snapshot.data.documents;
                  listaEstrelas = List();

                  for(DocumentSnapshot item in estrelasDB){
                    var dados = item.data;
                    Estrela estrela;
                    if(dados["tipo"] != "Gigante Vermelha"){
                      estrela = Estrela();
                      estrela.nome = dados["nome"];
                      estrela.id = item.documentID;
                      estrela.tamanho = double.tryParse(dados["tamanho"].toString());
                      estrela.idade = double.tryParse(dados["idade"].toString());
                      estrela.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                      estrela.tipo = dados["tipo"];
                      listaEstrelas.add(estrela);
                    }
                    else{
                      GiganteVermelha estrela = GiganteVermelha();
                      estrela.nome = dados["nome"];
                      estrela.id = item.documentID;
                      estrela.tamanho = double.tryParse(dados["tamanho"].toString());
                      estrela.idade = double.tryParse(dados["idade"].toString());
                      estrela.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                      estrela.morta = dados["morta"];
                      estrela.tipo = dados["tipo"];
                      listaEstrelas.add(estrela);
                    }
                  }

                  List<Estrela> estrelasProcuradas = query.isEmpty ? listaEstrelas :
                  listaEstrelas.where((check) => check.nome.toLowerCase().contains(query.toLowerCase())).toList();

                  return ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: estrelasProcuradas.length,
                      itemBuilder: (context, position){
                        Estrela estrela = estrelasProcuradas[position];

                        return GestureDetector(
                          onTap: (){
                            query = "";
                            if(estrela.tipo != "Gigante Vermelha"){
                              Navigator.pushNamed(context, "/exibir_estrela", arguments: ArgumentsEstrela(estrela, "exibir_estrela"));
                            }
                            else{
                              Navigator.pushNamed(context, "/exibir_gigante_vermelha", arguments: ArgumentsGiganteVermelha(estrela, "exibir_gigante_vermelha"));
                            }
                          },
                          child: custom_card(
                              icon: CustomIcons.constellation,
                              title: estrela.nome,
                              subtitle1: "Tamanho: " + estrela.tamanho.toString() + " km",
                              subtitle2: "Tipo: " + estrela.tipo.toString()
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
