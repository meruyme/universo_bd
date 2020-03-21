import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/widgets/custom_text_field.dart';

class cadastrar_estrela extends StatefulWidget {
  @override

  String tipo_estrela;

  cadastrar_estrela({this.tipo_estrela});


  _cadastrar_estrelaState createState() => _cadastrar_estrelaState();
}

class _cadastrar_estrelaState extends State<cadastrar_estrela> {

  TextEditingController _controllerNome = new TextEditingController();
  TextEditingController _controllerTamanho = new TextEditingController();
  TextEditingController _controllerIdade = new TextEditingController();
  TextEditingController _controllerDistancia = new TextEditingController();


  //essa variavel vai receber o valor inicial que vem na _varNomeAntigo só; ta recebendo na init
  String _titulo="";

  double _diferencaCards=10;

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
      Estrela estrela = Estrela();
      estrela.tamanho = double.tryParse(_controllerTamanho.text);
      estrela.nome = _controllerNome.text;
      estrela.idade = double.tryParse(_controllerIdade.text);
      estrela.distanciaTerra = double.tryParse(_controllerDistancia.text);
      estrela.tipo = widget.tipo_estrela;
      estrela.adicionarEstrela();

      Fluttertoast.showToast(
      msg: "Estrela cadastrada com sucesso!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
    }
  }

  void initState() {
    super.initState();
    _titulo = widget.tipo_estrela;
    print(widget.tipo_estrela);
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
                "Cadastrar $_titulo"
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