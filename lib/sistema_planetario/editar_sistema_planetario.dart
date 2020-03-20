import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_widgets/outline_dropdown_button.dart';
import 'package:universo_bd/arguments/ArgumentsSistema.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';
import 'package:universo_bd/custom_text_field.dart';

class editar_sistema_planetario extends StatefulWidget {

  SistemaPlanetario sistemaPlanetario;

  editar_sistema_planetario({this.sistemaPlanetario});

  _editar_sistema_planetarioState createState() => _editar_sistema_planetarioState();
}

class _editar_sistema_planetarioState extends State<editar_sistema_planetario> {
  @override

  Galaxia selectedGalaxy;
  String hint = "Galáxias";
  Galaxia value;
  Firestore db = Firestore.instance;
  TextEditingController _controllerNome;
  TextEditingController _controllerIdade;

  String _titulo="";

  double _diferencaCards=10;

  void initState(){
    super.initState();
    hint = widget.sistemaPlanetario.galaxia.nome;
    _titulo=widget.sistemaPlanetario.nome;
    _controllerNome = new TextEditingController(text: widget.sistemaPlanetario.nome);
    _controllerIdade = new TextEditingController(text: widget.sistemaPlanetario.idade.toString());
  }

  void validarCampos(){
    String nome = _controllerNome.text;
    String idade = _controllerIdade.text;

    if(nome.isEmpty || idade.isEmpty){
      Fluttertoast.showToast(
        msg: "Preencha todos os campos.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }else if(double.tryParse(idade)==null){
      Fluttertoast.showToast(
        msg: "Certifique-se da idade ser um número.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
      if(selectedGalaxy.id != widget.sistemaPlanetario.galaxia.id){
        selectedGalaxy.qtdSistemas += 1;
        widget.sistemaPlanetario.galaxia.qtdSistemas -= 1;
      }
      widget.sistemaPlanetario.nome=nome;
      widget.sistemaPlanetario.idade=double.tryParse(idade);
      Galaxia galaxiaAntiga = widget.sistemaPlanetario.galaxia;
      widget.sistemaPlanetario.galaxia = selectedGalaxy;

      widget.sistemaPlanetario.editarSistemaPlanetario(galaxiaAntiga);
      Fluttertoast.showToast(
        msg: "Sistema Planetário editado com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.popUntil(context, ModalRoute.withName("/listar_sistema_planetario"));
      Navigator.pushNamed(context, "/exibir_sistema_planetario",
          arguments: ArgumentsSistema(widget.sistemaPlanetario, "exibir_sistema_planetario"));
    }
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
                "Editando $_titulo"
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:32,bottom: _diferencaCards),
                  child: Padding(
                      padding: EdgeInsets.only(bottom: _diferencaCards),
                      child:Container(
                        height: 55,
                        child: custom_text_field(
                          label: "Nome",
                          controller: _controllerNome,
                          textInputType: TextInputType.text,
                          isPassword: false,
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: _diferencaCards),
                  child: Padding(
                      padding: EdgeInsets.only(bottom: _diferencaCards),
                      child:Container(
                        height: 55,
                        child:  custom_text_field(
                          label: "Idade (bilhões de anos)",
                          controller: _controllerIdade,
                          textInputType: TextInputType.number,
                          isPassword: false,
                        ),
                      )
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: db.collection("galaxias").orderBy("nome").snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading");
                    }
                    else{
                      final galaxiasDB = snapshot.data.documents;
                      List<DropdownMenuItem> itens = List();
                      List<Galaxia> listaGalaxias = List();
                      Galaxia aux = Galaxia();
                      aux.nome = "Galáxias";
                      itens.add(
                          DropdownMenuItem(
                              value: aux,
                              child: Container(
                                child: Text(aux.nome, style: TextStyle(color: Colors.white),),
                              )
                          )
                      );
                      for(DocumentSnapshot item in galaxiasDB) {
                        var dados = item.data;
                        Galaxia galaxia = Galaxia();

                        galaxia.id = item.documentID;
                        galaxia.nome = dados["nome"];
                        galaxia.distanciaTerra = double.tryParse(dados["distanciaTerra"].toString());
                        galaxia.qtdSistemas = int.tryParse(dados["qtdSistemas"].toString());
                        listaGalaxias.add(galaxia);
                      }

                      for(Galaxia item in listaGalaxias){
                        if(item.id == widget.sistemaPlanetario.galaxia.id && hint == widget.sistemaPlanetario.galaxia.nome){
                          selectedGalaxy = item;
                        }
                        itens.add(
                            DropdownMenuItem(
                                value: item,
                                child: Container(
                                  height: 20,
                                  child: Text(item.nome, style: TextStyle(color: Colors.white),),
                                )
                            )
                        );
                      }

                      return Padding(
                          padding: EdgeInsets.only(bottom: _diferencaCards),
                          child: Padding(
                              padding: EdgeInsets.only(bottom: _diferencaCards),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsetsDirectional.only(end: 20),
                                        height: 55,
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
                                            hint: Text(hint, style: TextStyle(color: Colors.white),),
                                            value: value,
                                            onChanged: (value){
                                              setState(() {
                                                hint = value.nome;
                                                selectedGalaxy = value;
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
                                          Navigator.pushNamed(context, "/cadastrar_galaxia");
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