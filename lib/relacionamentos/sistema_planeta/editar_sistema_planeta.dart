import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/classes/SistemaPlaneta.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';

class editar_sistema_planeta extends StatefulWidget {

  SistemaPlaneta sistemaPlaneta;

  editar_sistema_planeta({this.sistemaPlaneta});

  @override
  _editar_sistema_planetaState createState() => _editar_sistema_planetaState();
}

class _editar_sistema_planetaState extends State<editar_sistema_planeta> {
  @override

  SistemaPlanetario selectedSystem, valueSystem;
  String hintSistema = "Sistemas Planetários";
  String hintPlaneta = "Planetas";
  Planeta selectedPlanet, valuePlanet;
  Firestore db = Firestore.instance;
  double _diferencaCards=10;

  void validarCampos() async{
    CollectionReference col = Firestore.instance.collection("sistemas_planetas");
    Query checar_planeta = await col.where("idPlaneta", isEqualTo: selectedPlanet.id);
    QuerySnapshot checar_sistema = await checar_planeta.where("idSistema", isEqualTo: selectedSystem.id).getDocuments();

    if(hintSistema == "Sistemas Planetários" || hintPlaneta == "Planetas"){
      Fluttertoast.showToast(
        msg: "Selecione um sistema e um planeta.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else if(checar_sistema.documents.length != 0 &&
        (selectedPlanet.id != widget.sistemaPlaneta.planeta.id || selectedSystem.id != widget.sistemaPlaneta.sistemaPlanetario.id)){
      Fluttertoast.showToast(
        msg: "Esse relacionamento já existe.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
      if(widget.sistemaPlaneta.sistemaPlanetario.id != selectedSystem.id){
        widget.sistemaPlaneta.sistemaPlanetario.qtdPlanetas -= 1;
        selectedSystem.qtdPlanetas += 1;
      }
      SistemaPlanetario sistemaAntigo = widget.sistemaPlaneta.sistemaPlanetario;
      await db.collection("galaxias").document(selectedSystem.galaxia.id).get().then((snapshot){
        var dados = snapshot.data;
        selectedSystem.galaxia.nome = dados["nome"];
        selectedSystem.galaxia.qtdSistemas = dados["qtdSistemas"];
        selectedSystem.galaxia.distanciaTerra = dados["distanciaTerra"];
        widget.sistemaPlaneta.sistemaPlanetario = selectedSystem;
        widget.sistemaPlaneta.planeta = selectedPlanet;
        widget.sistemaPlaneta.editarSistemaPlaneta(sistemaAntigo);
        Fluttertoast.showToast(
          msg: "Relacionamento editado com sucesso!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.popUntil(context, ModalRoute.withName("/listar_sistema_planeta"));
        Navigator.pushNamed(context, "/exibir_sistema_planeta", arguments: widget.sistemaPlaneta);
      });

    }
  }

  void initState(){
    super.initState();
    hintPlaneta = widget.sistemaPlaneta.planeta.nome;
    hintSistema = widget.sistemaPlaneta.sistemaPlanetario.nome;
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
                "Relacionar Sistema-Planeta"
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
                        if(item.id == widget.sistemaPlaneta.sistemaPlanetario.id && hintSistema == widget.sistemaPlaneta.sistemaPlanetario.nome){
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
                        if(item.id == widget.sistemaPlaneta.planeta.id && hintPlaneta == widget.sistemaPlaneta.planeta.nome){
                          selectedPlanet = item;
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
