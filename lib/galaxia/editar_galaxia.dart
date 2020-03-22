import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/classes/Galaxia.dart';

import '../widgets/custom_text_field.dart';

class editar_galaxia extends StatefulWidget {

  Galaxia galaxia;

  editar_galaxia({this.galaxia});

  _editar_galaxiaState createState() => _editar_galaxiaState();
}

class _editar_galaxiaState extends State<editar_galaxia> {
  @override

  TextEditingController _controllerNome;
  TextEditingController _controllerDistancia;

  String _titulo="";

  double _diferencaCards=10;

  void initState(){
    super.initState();
    _titulo=widget.galaxia.nome;
    _controllerNome = new TextEditingController(text: widget.galaxia.nome);
    _controllerDistancia = new TextEditingController(text: widget.galaxia.distanciaTerra.toString());
  }

  void validarCampos(){
    String nome = _controllerNome.text;
    String distancia = _controllerDistancia.text;

    if(nome.isEmpty || distancia.isEmpty){
      Fluttertoast.showToast(
        msg: "Preencha todos os campos.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }else if(double.tryParse(distancia)==null){
      Fluttertoast.showToast(
        msg: "Certifique-se da distância ser um número.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
      widget.galaxia.nome=nome;
      widget.galaxia.distanciaTerra=double.tryParse(distancia);
      widget.galaxia.editarGalaxia();
      Fluttertoast.showToast(
        msg: "Galáxia editada com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.popUntil(context, ModalRoute.withName("/listar_galaxia"));
      Navigator.pushNamed(context, "/exibir_galaxia", arguments: widget.galaxia);
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
                          label: "Distância da Terra",
                          controller: _controllerDistancia,
                          textInputType: TextInputType.number,
                          isPassword: false,
                          suffix: "anos-luz",
                        ),
                      )
                  ),
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