import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/custom_card.dart';
import 'package:universo_bd/custom_icons_icons.dart';
import 'package:universo_bd/navigation_drawer.dart';
import 'package:universo_bd/speed_dial_fab.dart';

class listar_estrela extends StatefulWidget {

  @override
  _listar_estrelaState createState() => _listar_estrelaState();
}

class _listar_estrelaState extends State<listar_estrela> {

  Firestore db = Firestore.instance;
  final key = new GlobalKey<ScaffoldState>();
  ScrollController scrollController;


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
  void initState() {

    /*new Future<Null>.delayed(Duration.zero, () {
        key.currentState.showSnackBar(
            SnackBar(content: Text("Usuário validado com sucesso!"))
        );
      });*/

    // TODO: implement initState
    super.initState();
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
        key: key,
        drawer: navigation_drawer(tela: "listar_estrela"),
        floatingActionButton: speed_dial_fab(scrollController: scrollController),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Estrelas"),
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
                  List<Estrela> listaEstrelas = List();

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

                  return ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, position){
                        //List<Planeta> listaItens = snapshot.data;
                        Estrela estrela = listaEstrelas[position];

                        return GestureDetector(
                          onTap: (){
                            if(estrela.tipo != "Gigante Vermelha"){
                              Navigator.pushNamed(context, "/exibir_estrela", arguments: estrela);
                            }
                            else{
                              Navigator.pushNamed(context, "/exibir_gigante_vermelha", arguments: estrela);
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
