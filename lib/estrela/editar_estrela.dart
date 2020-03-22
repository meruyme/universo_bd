import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/arguments/ArgumentsEstrela.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/widgets/custom_text_field.dart';

class editar_estrela extends StatefulWidget {

  Estrela estrela;

  editar_estrela({this.estrela});

  _editar_estrelaState createState() => _editar_estrelaState();
}

class _editar_estrelaState extends State<editar_estrela> {
  @override

  TextEditingController _controllerNome;
  TextEditingController _controllerTamanho;
  TextEditingController _controllerIdade;
  TextEditingController _controllerDistancia;

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
      widget.estrela.tamanho = double.tryParse(_controllerTamanho.text);
      widget.estrela.nome = _controllerNome.text;
      widget.estrela.idade = double.tryParse(_controllerIdade.text);
      widget.estrela.distanciaTerra = double.tryParse(_controllerDistancia.text);
      widget.estrela.editarEstrela();
      Fluttertoast.showToast(
        msg: "Estrela editada com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.popUntil(context, ModalRoute.withName("/listar_estrela"));
      Navigator.pushNamed(context, "/exibir_estrela", arguments: ArgumentsEstrela(widget.estrela, "exibir_estrela"));
    }
  }

  void initState() {
    super.initState();
    _titulo=widget.estrela.nome;
    _controllerNome= new TextEditingController(text: widget.estrela.nome);
    _controllerIdade= new TextEditingController(text: widget.estrela.idade.toString());
    _controllerTamanho= new TextEditingController(text: widget.estrela.tamanho.toString());
    _controllerDistancia= new TextEditingController(text: widget.estrela.distanciaTerra.toString());
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
                        child: custom_text_field(
                          label: "Tamanho",
                          controller: _controllerTamanho,
                          textInputType: TextInputType.number,
                          isPassword: false,
                          suffix: "km",
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
                          label: "Idade",
                          controller: _controllerIdade,
                          textInputType: TextInputType.number,
                          isPassword: false,
                          suffix: "bilhões de anos",
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