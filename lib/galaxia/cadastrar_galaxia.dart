import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/widgets/custom_text_field.dart';


class cadastrar_galaxia extends StatefulWidget {
  @override
  _cadastrar_galaxiaState createState() => _cadastrar_galaxiaState();
}

class _cadastrar_galaxiaState extends State<cadastrar_galaxia> {

  TextEditingController _controllerNome = new TextEditingController();
  TextEditingController _controllerDistancia = new TextEditingController();

  double _diferencaCards=10;

  void validarCampos(){
    String nome = _controllerNome.text;
    String distancia = _controllerDistancia.text;

    if(nome.isEmpty || distancia.isEmpty){
      Fluttertoast.showToast(
        msg: "Preencha todos os campos.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      /*key.currentState.showSnackBar(
        SnackBar(
          content: Text("Preencha todos os campos."),
        )
    );*/
    }else if(double.tryParse(distancia)==null){
      Fluttertoast.showToast(
        msg: "Certifique-se da distância ser um número.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
      Galaxia galaxia = new Galaxia();
      galaxia.nome=_controllerNome.text;
      galaxia.distanciaTerra=double.tryParse(_controllerDistancia.text);
      galaxia.adicionarGalaxia();
      Fluttertoast.showToast(
        msg: "Galáxia cadastrada com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
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
                "Cadastrar Galáxia"
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
                        child: custom_text_field(
                          label: "Distância da Terra (anos-luz)",
                          controller: _controllerDistancia,
                          textInputType: TextInputType.number,
                          isPassword: false,
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