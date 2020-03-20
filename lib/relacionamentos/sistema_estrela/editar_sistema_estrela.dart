import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/classes/SistemaEstrela.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/dialog_estrela.dart';

class editar_sistema_estrela extends StatefulWidget {

  SistemaEstrela sistemaEstrela;

  editar_sistema_estrela({this.sistemaEstrela});

  @override
  _editar_sistema_estrelaState createState() => _editar_sistema_estrelaState();
}

class _editar_sistema_estrelaState extends State<editar_sistema_estrela> {
  @override

  SistemaPlanetario selectedSystem, valueSystem;
  String hintSistema = "Sistemas Planetários";
  String hintEstrela = "Estrelas";
  Estrela selectedStar, valueStar;
  Firestore db = Firestore.instance;
  double _diferencaCards=10;

  void validarCampos(){
    if(hintSistema == "Sistemas Planetários" || hintEstrela == "Estrelas"){
      Fluttertoast.showToast(
        msg: "Selecione um sistema e uma estrela.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }

    else{
      if(widget.sistemaEstrela.sistemaPlanetario.id != selectedSystem.id){
        widget.sistemaEstrela.sistemaPlanetario.qtdEstrelas -= 1;
        selectedSystem.qtdEstrelas += 1;
      }
      SistemaPlanetario sistemaAntigo = widget.sistemaEstrela.sistemaPlanetario;
      widget.sistemaEstrela.sistemaPlanetario = selectedSystem;
      widget.sistemaEstrela.estrela = selectedStar;
      widget.sistemaEstrela.editarSistemaEstrela(sistemaAntigo);
      Fluttertoast.showToast(
        msg: "Relacionamento editado com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.popUntil(context, ModalRoute.withName("/listar_sistema_estrela"));
    }
  }

  void initState(){
    super.initState();
    hintEstrela = widget.sistemaEstrela.estrela.nome;
    hintSistema = widget.sistemaEstrela.sistemaPlanetario.nome;
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
                "Editar Sistema-Estrela"
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
                      SistemaPlanetario aux = SistemaPlanetario();
                      aux.nome = "Sistemas Planetários";
                      itens.add(
                          DropdownMenuItem(
                              value: aux,
                              child: Container(
                                child: Text(aux.nome, style: TextStyle(color: Colors.white),),
                              )
                          )
                      );
                      for(DocumentSnapshot item in sistemasDB){
                        var dados = item.data;
                        Galaxia galaxia = Galaxia();
                        SistemaPlanetario sistemaPlanetario = SistemaPlanetario();
                        sistemaPlanetario.id = item.documentID;
                        sistemaPlanetario.nome = dados["nome"];
                        sistemaPlanetario.idade = double.tryParse(dados["idade"].toString());
                        sistemaPlanetario.qtdEstrelas = int.tryParse(dados["qtdEstrelas"].toString());
                        sistemaPlanetario.qtdPlanetas = int.tryParse(dados["qtdPlanetas"].toString());
                        galaxia.id = dados["idGalaxia"];
                        sistemaPlanetario.galaxia = galaxia;
                        listaSistemas.add(sistemaPlanetario);
                      }

                      for(SistemaPlanetario item in listaSistemas){
                        if(item.id == widget.sistemaEstrela.sistemaPlanetario.id && hintSistema == widget.sistemaEstrela.sistemaPlanetario.nome){
                          selectedSystem = item;
                        }
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
                                            hint: Text(hintSistema, style: TextStyle(color: Colors.white)),
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
                      Estrela aux = Estrela();
                      aux.nome = "Estrelas";
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
                        if(item.id == widget.sistemaEstrela.estrela.id && hintEstrela == widget.sistemaEstrela.estrela.nome){
                          selectedStar = item;
                        }
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
