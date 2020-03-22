import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/widgets/custom_text_field.dart';

class cadastrar_planeta extends StatefulWidget {
  @override
  _cadastrar_planetaState createState() => _cadastrar_planetaState();
}

class _cadastrar_planetaState extends State<cadastrar_planeta> {
  ScrollController scrollController = ScrollController();
  bool isExpanded = false;
  List<String> componentes = List();
  int selectedIndex = -1;
  TextEditingController _nomeComponenteController = new TextEditingController();
  TextEditingController _porcentagemComponenteController = new TextEditingController();
  TextEditingController _nomeController = new TextEditingController();
  TextEditingController _tamanhoController = new TextEditingController();
  TextEditingController _massaController = new TextEditingController();
  TextEditingController _velocidadeController = new TextEditingController();

  void validarComponentes(){
    if(_nomeComponenteController.text.isEmpty || _porcentagemComponenteController.text.isEmpty){
      Fluttertoast.showToast(
        msg: "Preencha todos os campos.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else if(double.tryParse(_porcentagemComponenteController.text) == null){
      Fluttertoast.showToast(
        msg: "A porcentagem deve ser um número real.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
    componentes.add(_nomeComponenteController.text.trim()+"-"+_porcentagemComponenteController.text.trim());
    _nomeComponenteController.clear();
    _porcentagemComponenteController.clear();
    setState(() {});
    Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void validarCampos(){
    String nome = _nomeController.text;
    String tamanho = _tamanhoController.text;
    String velocidade = _velocidadeController.text;
    String massa = _massaController.text;
    if(nome.isEmpty || tamanho.isEmpty || velocidade.isEmpty || massa.isEmpty || componentes.length == 0){
      Fluttertoast.showToast(
        msg: "Preencha todos os campos.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else if(double.tryParse(tamanho) == null || double.tryParse(massa) == null || double.tryParse(velocidade) == null){
      Fluttertoast.showToast(
        msg: "Massa, tamanho e velocidade recebem apenas números reais.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{
      Planeta planeta = Planeta();
      planeta.nome = _nomeController.text;
      planeta.tamanho = double.tryParse(_tamanhoController.text);
      planeta.massa = double.tryParse(_massaController.text);
      planeta.velocidadeRotacao = double.tryParse(_velocidadeController.text);
      planeta.componentes = componentes;
      planeta.adicionarPlaneta();
      Fluttertoast.showToast(
        msg: "Planeta cadastrado com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/fundo_telas6.jpg"),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Cadastrar planeta"),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 24, top: 16),
                  child: custom_text_field(
                    label: "Nome",
                    controller: _nomeController,
                    textInputType: TextInputType.text,
                    isPassword: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 24),
                  child: custom_text_field(
                    label: "Tamanho",
                    controller: _tamanhoController,
                    textInputType: TextInputType.number,
                    isPassword: false,
                    suffix: "km",
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 24),
                  child: custom_text_field(
                    label: "Massa",
                    controller: _massaController,
                    textInputType: TextInputType.number,
                    isPassword: false,
                    suffix: "kg",
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 24),
                  child: custom_text_field(
                    label: "Velocidade de rotação",
                    controller: _velocidadeController,
                    textInputType: TextInputType.number,
                    isPassword: false,
                    suffix: "km/h",
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                                padding: EdgeInsetsDirectional.only(end: 16),
                                child: Material(
                                    color: Color.fromRGBO(64, 75, 96, 0.9),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                    child: GroovinExpansionTile(
                                      title: Text("Componentes gasosos", style: TextStyle(color: Colors.white)),
                                      onExpansionChanged: (value) {
                                        setState(() {
                                          isExpanded = value;
                                          if(isExpanded == false){
                                            selectedIndex = -1;
                                          }
                                        });
                                      },
                                      inkwellRadius: !isExpanded
                                          ? BorderRadius.all(Radius.circular(16.0))
                                          : BorderRadius.only(
                                        topRight: Radius.circular(16.0),
                                        topLeft: Radius.circular(16.0),
                                      ),
                                      children: <Widget>[
                                        ListView.builder(
                                          shrinkWrap: true,
                                          controller: scrollController,
                                          itemCount: componentes.length,
                                          itemBuilder: (context, position){
                                            List aux = componentes[position].split("-");
                                            return Material(
                                              color: selectedIndex != -1 && selectedIndex == position ? Color.fromRGBO(45, 52, 67, 0.9): Colors.transparent,
                                              shape: componentes.length-1 == position ?
                                              RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(16.0),
                                                  bottomRight: Radius.circular(16.0))) :
                                              RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                              child: GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      if(selectedIndex != position){
                                                        selectedIndex = position;
                                                      }
                                                      else{
                                                        selectedIndex = -1;
                                                      }
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 10, bottom: 10, end: 10, top: 5),
                                                    child: Text("Gás: " + aux[0] +
                                                        " - Porcentagem: " + aux[1] + "%",
                                                        style: TextStyle(fontSize: 16)),
                                                  )
                                              ),
                                            );

                                          },
                                        ),
                                      ],
                                    ),
                                  )

                            )
                        ),
                        Column(

                          children: <Widget>[
                            Padding(
                              padding: EdgeInsetsDirectional.only(bottom: 10),
                              child: ButtonTheme(
                                buttonColor: Colors.deepPurpleAccent,
                                minWidth: 10,
                                height: 20,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(18.0),
                                    //side: BorderSide(color: Colors.transparent)
                                  ),
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  child: Icon(Icons.add, color: Colors.white,),
                                  onPressed: (){
                                    showDialog(
                                        context: context,
                                        child: SimpleDialog(
                                          title: Text("Cadastrar componentes"),
                                          children: <Widget>[
                                            SingleChildScrollView(
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsetsDirectional.only(bottom: 16),
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          labelText: "Nome do componente"
                                                      ),
                                                      controller: _nomeComponenteController,
                                                      keyboardType: TextInputType.text,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsetsDirectional.only(bottom: 25),
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          labelText: "Porcentagem (%)"
                                                      ),
                                                      controller: _porcentagemComponenteController,
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                  RaisedButton(
                                                    child: Text("Adicionar"),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: new BorderRadius.circular(18.0),
                                                      //side: BorderSide(color: Colors.transparent)
                                                    ),
                                                    onPressed: (){
                                                      validarComponentes();
                                                    },
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                    );
                                  },
                                ),
                              ),
                            ),
                            ButtonTheme(
                              buttonColor: Colors.deepPurpleAccent,
                              minWidth: 10,
                              height: 20,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  //side: BorderSide(color: Colors.transparent)
                                ),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                child: Icon(Icons.remove, color: Colors.white,),
                                onPressed: (){
                                  setState(() {
                                    if(selectedIndex != -1){
                                      componentes.removeAt(selectedIndex);
                                      selectedIndex = -1;
                                      Fluttertoast.showToast(
                                        msg: "Componente deletado com sucesso!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }
                                    else{
                                      Fluttertoast.showToast(
                                        msg: "Selecione um componente antes de continuar.",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                ),
                RaisedButton(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    //side: BorderSide(color: Colors.transparent)
                  ),
                  child: Text("Salvar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  onPressed: (){
                    validarCampos();
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
