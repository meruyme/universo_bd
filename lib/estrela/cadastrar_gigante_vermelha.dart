import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/classes/GiganteVermelha.dart';
import 'package:universo_bd/custom_text_field.dart';

class cadastrar_gigante_vermelha extends StatefulWidget {
  @override
  _cadastrar_gigante_vermelhaState createState() => _cadastrar_gigante_vermelhaState();
}

class _cadastrar_gigante_vermelhaState extends State<cadastrar_gigante_vermelha> {
  @override

  TextEditingController _controllerNome = new TextEditingController();
  TextEditingController _controllerTamanho = new TextEditingController();
  TextEditingController _controllerIdade = new TextEditingController();
  TextEditingController _controllerDistancia = new TextEditingController();

  double _diferencaCards=10;

  bool _morte=false;

  void validarCampos(){
    String nome = _controllerNome.text;
    String tamanho = _controllerTamanho.text;
    String idade = _controllerIdade.text;
    String distanciaTerra = _controllerDistancia.text;

    if(nome.isEmpty || tamanho.isEmpty || idade.isEmpty || distanciaTerra.isEmpty){
      Fluttertoast.showToast(
        msg: "Preencha todos os campos.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else if(double.tryParse(tamanho) == null || double.tryParse(idade) == null || double.tryParse(distanciaTerra) == null){
      Fluttertoast.showToast(
        msg: "Distância da Terra, tamanho e idade recebem apenas números.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
        GiganteVermelha gigantevermelha = GiganteVermelha();
        gigantevermelha.tamanho = double.tryParse(_controllerTamanho.text);
        gigantevermelha.nome = _controllerNome.text;
        gigantevermelha.morta = _morte;
        gigantevermelha.idade = double.tryParse(_controllerIdade.text);
        gigantevermelha.distanciaTerra = double.tryParse(_controllerDistancia.text);
        gigantevermelha.tipo = "Gigante Vermelha";
        gigantevermelha.adicionarEstrela();

      Fluttertoast.showToast(
        msg: "Estrela cadastrada com sucesso!",
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
                "Cadastrar Gigante Vermelha"
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
                          label: "Tamanho (km)",
                          controller: _controllerTamanho,
                          textInputType: TextInputType.number,
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
                ),Padding(
                  padding: EdgeInsets.only(bottom: _diferencaCards),
                  child: Padding(
                      padding: EdgeInsets.only(bottom: _diferencaCards),
                      child:Container(
                        height: 55,
                        child: custom_text_field(
                          label: "Idade (bilhões de anos)",
                          controller: _controllerIdade,
                          textInputType: TextInputType.number,
                          isPassword: false,
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:0),
                  child: SwitchListTile(
                    title: Text("Ela está morta?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    value: _morte,
                    onChanged: (bool valor){
                      setState(() {
                        _morte=valor;
                      });
                    },
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