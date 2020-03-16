import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/custom_card.dart';
import 'package:universo_bd/custom_icons_icons.dart';
import 'package:universo_bd/navigation_drawer.dart';
import 'package:universo_bd/speed_dial_fab.dart';

class listar_galaxia extends StatefulWidget {

  @override
  _listar_galaxiaState createState() => _listar_galaxiaState();
}

class _listar_galaxiaState extends State<listar_galaxia> {

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
                  List<Galaxia> listaGalaxias = List();

                  for(DocumentSnapshot item in galaxiasDB){
                    var dados = item.data;
                    Galaxia galaxia = Galaxia();
                    galaxia.id = item.documentID;
                    galaxia.nome = dados["nome"];
                    galaxia.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                    galaxia.qtdSistemas = int.tryParse(dados["qtdSistemas"].toString());
                    listaGalaxias.add(galaxia);
                  }

                  return ListView.builder(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, position){
                        Galaxia galaxia = listaGalaxias[position];

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
