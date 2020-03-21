import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/classes/Orbitantes.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/classes/SateliteNatural.dart';
import 'package:universo_bd/custom_icon_star_icons.dart';
import 'package:universo_bd/dialog_estrela.dart';


class cadastrar_orbitantes extends StatefulWidget {
  @override
  _cadastrar_orbitantesState createState() => _cadastrar_orbitantesState();
}

class _cadastrar_orbitantesState extends State<cadastrar_orbitantes> {
  @override

  Planeta selectedPlanet, valuePlanet;
  SateliteNatural selectedSatellite, valueSatellite;
  String hintPlaneta = "Planeta";
  String hintSatelite = "Satélites Naturais";
  String hintEstrela = "Estrelas";
  Estrela selectedStar, valueStar;
  Firestore db = Firestore.instance;
  double _diferencaCards=10;

  List<String> _titulos = List();
  List<String> _nomeRotas = List();
  List<Icon> _icones = List();


  void validarCampos() async{
    CollectionReference col = Firestore.instance.collection("orbitantes");
    Query checar_estrela = await col.where("idEstrela", isEqualTo: selectedStar.id);
    Query checar_planeta = await checar_estrela.where("idPlaneta", isEqualTo: selectedPlanet.id);
    QuerySnapshot checar_satelite = await checar_planeta.where("idSatelite", isEqualTo: selectedSatellite.id).getDocuments();

    if((hintSatelite == "Satélites Naturais" && hintEstrela == "Estrelas") ||
        (hintEstrela == "Estrelas" && hintPlaneta == "Planetas") ||
        (hintPlaneta == "Planetas" && hintSatelite == "Satélites Naturais")){
      Fluttertoast.showToast(
        msg: "Selecione, pelo menos, dois corpos celestes.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else if(checar_satelite.documents.length != 0){
      Fluttertoast.showToast(
        msg: "Esse relacionamento já existe.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
      Orbitantes orbitantes = Orbitantes();
      orbitantes.planeta = selectedPlanet;
      orbitantes.estrela = selectedStar;
      orbitantes.sateliteNatural = selectedSatellite;
      orbitantes.adicionarOrbitantes();
      Fluttertoast.showToast(
        msg: "Orbitantes relacionados com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
    }
  }

  @override
  void initState(){
    super.initState;
    _titulos.add(" Anã Vermelha ");
    _titulos.add(" Anã Branca  ");
    _titulos.add("Estrela Binária");
    _titulos.add("Gigante Azul");
    _titulos.add("Gigante Vermelha");
    _nomeRotas.add("/cadastrar_estrela");
    _nomeRotas.add("/cadastrar_estrela");
    _nomeRotas.add("/cadastrar_estrela");
    _nomeRotas.add("/cadastrar_estrela");
    _nomeRotas.add("/cadastrar_gigante_vermelha");
    _icones.add(Icon(CustomIconStar.stars1, size: 60));
    _icones.add(Icon(CustomIconStar.stars2, size: 60));
    _icones.add(Icon(CustomIconStar.stars3, size: 60));
    _icones.add(Icon(CustomIconStar.stars4, size: 60));
    _icones.add(Icon(CustomIconStar.stars5, size: 60));

    Planeta auxP = Planeta();
    auxP.nome = "Planetas";
    auxP.id = "-";
    selectedPlanet = auxP;
    Estrela auxE = Estrela();
    auxE.nome = "Estrelas";
    auxE.id = "-";
    selectedStar = auxE;
    SateliteNatural auxS = SateliteNatural();
    auxS.nome = "Satélites Naturais";
    auxS.id = "-";
    selectedSatellite = auxS;
  }

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/fundo_telas6.jpg"),
              fit: BoxFit.cover,
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
                "Relacionar Orbitantes"
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: db.collection("planetas").orderBy("nome").snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading");
                    }
                    else{
                      final planetasDB = snapshot.data.documents;
                      List<DropdownMenuItem> itens = List();
                      List<Planeta> listaPlanetas = List();
                      Planeta aux = Planeta();
                      aux.id = "-";
                      aux.nome = "Planetas";
                      itens.add(
                          DropdownMenuItem(
                              value: aux,
                              child: Container(
                                child: Text(aux.nome, style: TextStyle(color: Colors.white),),
                              )
                          )
                      );

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

                      for(Planeta item in listaPlanetas){
                        itens.add(
                            DropdownMenuItem(
                                value: item,
                                child: Container(
                                  child: Text(item.nome, style: TextStyle(color: Colors.white),),
                                )
                            )
                        );
                      }

                      return Padding(
                          padding: EdgeInsets.only(top: 10, bottom: _diferencaCards),
                          child: Padding(
                              padding: EdgeInsets.only(bottom: _diferencaCards),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsetsDirectional.only(end: 20),
                                        height: 70,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              canvasColor: Color.fromRGBO(64, 75, 96, 0.9)
                                          ),
                                          child: OutlineDropdownButton(
                                            inputDecoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(18.0))
                                                ),
                                                filled: true,
                                                fillColor: Color.fromRGBO(64, 75, 96, 0.9)
                                            ),
                                            items: itens,
                                            isExpanded: true,
                                            hint: Text(hintPlaneta, style: TextStyle(color: Colors.white),),
                                            value: valuePlanet,
                                            onChanged: (value){
                                              setState(() {
                                                hintPlaneta = value.nome;
                                                selectedPlanet = value;
                                              });
                                            },
                                          ),
                                        )
                                    ),
                                  ),
                                  ClipOval(
                                    child: Material(
                                      color: Colors.deepPurpleAccent, // button color
                                      child: InkWell(
                                        splashColor: Colors.deepPurple, // inkwell color
                                        child: SizedBox(width: 45, height: 45, child: Icon(Icons.add, color: Colors.white,)),
                                        onTap: () {
                                          Navigator.pushNamed(context, "/cadastrar_planeta");
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                          )
                      );
                    }
                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: db.collection("estrelas").orderBy("nome").snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading");
                    }
                    else{
                      final estrelasDB = snapshot.data.documents;
                      List<Estrela> listaEstrelas = List();
                      List<DropdownMenuItem> itens = List();
                      Estrela aux = Estrela();
                      aux.nome = "Estrelas";
                      aux.id = "-";
                      itens.add(
                          DropdownMenuItem(
                              value: aux,
                              child: Container(
                                child: Text(aux.nome, style: TextStyle(color: Colors.white),),
                              )
                          )
                      );
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

                      for(Estrela item in listaEstrelas){
                        itens.add(
                            DropdownMenuItem(
                                value: item,
                                child: Container(
                                  child: Text(item.nome, style: TextStyle(color: Colors.white),),
                                )
                            )
                        );
                      }

                      return Padding(
                          padding: EdgeInsets.only(top: 10, bottom: _diferencaCards),
                          child: Padding(
                              padding: EdgeInsets.only(bottom: _diferencaCards),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsetsDirectional.only(end: 20),
                                        height: 70,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              canvasColor: Color.fromRGBO(64, 75, 96, 0.9)
                                          ),
                                          child: OutlineDropdownButton(
                                            inputDecoration: InputDecoration(
                                              /*enabledBorder: OutlineInputBorder(
                                     borderSide: BorderSide(color: Colors.white, width: 2)
                                   ),*/
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(18.0))
                                                ),
                                                filled: true,
                                                fillColor: Color.fromRGBO(64, 75, 96, 0.9)
                                            ),
                                            items: itens,
                                            isExpanded: true,
                                            hint: Text(hintEstrela, style: TextStyle(color: Colors.white),),
                                            value: valueStar,
                                            onChanged: (value){
                                              setState(() {
                                                hintEstrela = value.nome;
                                                selectedStar = value;
                                              });
                                            },
                                          ),
                                        )
                                    ),
                                  ),
                                  ClipOval(
                                    child: Material(
                                      color: Colors.deepPurpleAccent, // button color
                                      child: InkWell(
                                        splashColor: Colors.deepPurple, // inkwell color
                                        child: SizedBox(width: 45, height: 45, child: Icon(Icons.add, color: Colors.white,)),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            child: dialog_estrela(),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                          )
                      );
                    }
                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: db.collection("satelites_naturais").orderBy("nome").snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading");
                    }
                    else{
                      final satelitesDB = snapshot.data.documents;
                      List<DropdownMenuItem> itens = List();
                      List<SateliteNatural> listaSatelites = List();
                      SateliteNatural aux = SateliteNatural();
                      aux.nome = "Satélites Naturais";
                      aux.id = "-";
                      itens.add(
                          DropdownMenuItem(
                              value: aux,
                              child: Container(
                                child: Text(aux.nome, style: TextStyle(color: Colors.white),),
                              )
                          )
                      );

                      for(DocumentSnapshot item in satelitesDB){
                        var dados = item.data;
                        SateliteNatural sateliteNatural = SateliteNatural();
                        sateliteNatural.id = item.documentID;
                        sateliteNatural.nome = dados["nome"];
                        sateliteNatural.massa = double.tryParse(dados["massa"].toString());
                        sateliteNatural.tamanho = double.tryParse(dados["tamanho"].toString());
                        List<dynamic> auxDyn = dados["componentes"];
                        sateliteNatural.componentes = List<String>.from(auxDyn);
                        listaSatelites.add(sateliteNatural);
                      }

                      for(SateliteNatural item in listaSatelites){
                        itens.add(
                            DropdownMenuItem(
                                value: item,
                                child: Container(
                                  child: Text(item.nome, style: TextStyle(color: Colors.white),),
                                )
                            )
                        );
                      }

                      return Padding(
                          padding: EdgeInsets.only(top: 10, bottom: _diferencaCards),
                          child: Padding(
                              padding: EdgeInsets.only(bottom: _diferencaCards),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsetsDirectional.only(end: 20),
                                        height: 70,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              canvasColor: Color.fromRGBO(64, 75, 96, 0.9)
                                          ),
                                          child: OutlineDropdownButton(
                                            inputDecoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(18.0))
                                                ),
                                                filled: true,
                                                fillColor: Color.fromRGBO(64, 75, 96, 0.9)
                                            ),
                                            items: itens,
                                            isExpanded: true,
                                            hint: Text(hintSatelite, style: TextStyle(color: Colors.white),),
                                            value: valueSatellite,
                                            onChanged: (value){
                                              setState(() {
                                                hintSatelite = value.nome;
                                                selectedSatellite = value;
                                              });
                                            },
                                          ),
                                        )
                                    ),
                                  ),
                                  ClipOval(
                                    child: Material(
                                      color: Colors.deepPurpleAccent, // button color
                                      child: InkWell(
                                        splashColor: Colors.deepPurple, // inkwell color
                                        child: SizedBox(width: 45, height: 45, child: Icon(Icons.add, color: Colors.white,)),
                                        onTap: () {
                                          Navigator.pushNamed(context, "/cadastrar_satelite_natural");
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                          )
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top:30) ,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      //side: BorderSide(color: Colors.transparent)
                    ),
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: (){
                      validarCampos();
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
