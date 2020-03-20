import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/classes/SistemaEstrela.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/custom_icon_star_icons.dart';
import 'package:universo_bd/dialog_estrela.dart';


class cadastrar_sistema_estrela extends StatefulWidget {
  @override
  _cadastrar_sistema_estrelaState createState() => _cadastrar_sistema_estrelaState();
}

class _cadastrar_sistema_estrelaState extends State<cadastrar_sistema_estrela> {
  @override

  SistemaPlanetario selectedSystem, valueSystem;
  String hintSistema = "Sistemas Planetários";
  String hintEstrela = "Estrelas";
  Estrela selectedStar, valueStar;
  Firestore db = Firestore.instance;
  double _diferencaCards=10;

  List<String> _titulos = List();
  List<String> _nomeRotas = List();
  List<Icon> _icones = List();


  void validarCampos(){
    if(hintSistema == "Sistemas Planetários" || hintEstrela == "Estrelas"){
      Fluttertoast.showToast(
        msg: "Selecione um sistema e uma estrela.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
      SistemaEstrela sistemaEstrela = SistemaEstrela();
      sistemaEstrela.sistemaPlanetario = selectedSystem;
      sistemaEstrela.estrela = selectedStar;
      sistemaEstrela.adicionarSistemaEstrela();
      Fluttertoast.showToast(
        msg: "Entidades relacionadas com sucesso!",
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
                "Relacionar Sistema-Estrela"
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: db.collection("sistemas_planetarios").orderBy("nome").snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading");
                    }
                    else{
                      final sistemasDB = snapshot.data.documents;
                      List<DropdownMenuItem> itens = List();
                      List<SistemaPlanetario> listaSistemas = List();

                      for(DocumentSnapshot item in sistemasDB){
                        var dados = item.data;
                        Galaxia galaxia = Galaxia();
                        galaxia.id = dados["idGalaxia"];
                        SistemaPlanetario sistemaPlanetario = SistemaPlanetario();
                        sistemaPlanetario.id = item.documentID;
                        sistemaPlanetario.nome = dados["nome"];
                        sistemaPlanetario.idade = double.tryParse(dados["idade"].toString());
                        sistemaPlanetario.qtdEstrelas = int.tryParse(dados["qtdEstrelas"].toString());
                        sistemaPlanetario.qtdPlanetas = int.tryParse(dados["qtdPlanetas"].toString());
                        sistemaPlanetario.galaxia = galaxia;
                        listaSistemas.add(sistemaPlanetario);
                      }

                      for(SistemaPlanetario item in listaSistemas){
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
                                            hint: Text(hintSistema, style: TextStyle(color: Colors.white),),
                                            value: valueSystem,
                                            onChanged: (value){
                                              setState(() {
                                                hintSistema = value.nome;
                                                selectedSystem = value;
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
                                          Navigator.pushNamed(context, "/cadastrar_sistema_planetario");
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
