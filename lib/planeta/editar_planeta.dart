import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_widgets/groovin_expansion_tile.dart';
import 'package:universo_bd/arguments/ArgumentsPlaneta.dart';
import '../classes/Planeta.dart';
import '../widgets/custom_text_field.dart';

class editar_planeta extends StatefulWidget {
  @override
  Planeta planeta;

  editar_planeta({this.planeta});


  _editar_planetaState createState() => _editar_planetaState();
}

class _editar_planetaState extends State<editar_planeta> {
  @override

  ScrollController scrollController = ScrollController();
  TextEditingController _controllerNome;
  TextEditingController _controllerTamanho;
  TextEditingController _controllerMassa;
  TextEditingController _controllerVelocidade;
  TextEditingController _nomeComponenteController = TextEditingController();
  TextEditingController _porcentagemComponenteController = TextEditingController();
  //essa variavel vai receber o valor inicial que vem na _varNomeAntigo só; ta recebendo na init
  String _titulo="";
  bool isExpanded = false;
  int selectedIndex = -1;
  double _diferencaCards=10;

  void validarCampos(){
    String nome = _controllerNome.text;
    String tamanho = _controllerTamanho.text;
    String velocidade = _controllerVelocidade.text;
    String massa = _controllerMassa.text;
    if(nome.isEmpty || tamanho.isEmpty || velocidade.isEmpty || massa.isEmpty || widget.planeta.componentes.length == 0){
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
      widget.planeta.nome = _controllerNome.text;
      widget.planeta.tamanho = double.tryParse(_controllerTamanho.text);
      widget.planeta.massa = double.tryParse(_controllerMassa.text);
      widget.planeta.velocidadeRotacao = double.tryParse(_controllerVelocidade.text);
      widget.planeta.editarPlaneta();
      Fluttertoast.showToast(
        msg: "Planeta editado com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.popUntil(context, ModalRoute.withName("/listar_planeta"));
      Navigator.pushNamed(context, "/exibir_planeta", arguments: ArgumentsPlaneta(widget.planeta, "exibir_planeta"));
    }
  }

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
      widget.planeta.componentes.add(_nomeComponenteController.text.trim()+"-"+_porcentagemComponenteController.text.trim());
      _nomeComponenteController.clear();
      _porcentagemComponenteController.clear();
      setState(() {});
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void initState() {
    super.initState();
    _titulo=widget.planeta.nome;
    _controllerVelocidade = new TextEditingController(text: widget.planeta.velocidadeRotacao.toString());
    _controllerNome= new TextEditingController(text: widget.planeta.nome);
    _controllerMassa= new TextEditingController(text: widget.planeta.massa.toString());
    _controllerTamanho= new TextEditingController(text: widget.planeta.tamanho.toString());
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
                          label: "Tamanho",
                          controller: _controllerTamanho,
                          textInputType: TextInputType.number,
                          isPassword: false,
                          suffix: "anos-luz",
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
                          label: "Massa",
                          controller: _controllerMassa,
                          textInputType: TextInputType.number,
                          isPassword: false,
                          suffix: "kg",
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 24),
                  child: custom_text_field(
                    label: "Velocidade de rotação",
                    controller: _controllerVelocidade,
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
                                        itemCount: widget.planeta.componentes.length,
                                        itemBuilder: (context, position){
                                          List aux = widget.planeta.componentes[position].split("-");
                                          return Material(
                                            color: selectedIndex != -1 && selectedIndex == position ? Color.fromRGBO(45, 52, 67, 0.9): Colors.transparent,
                                            shape: widget.planeta.componentes.length-1 == position ?
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
                                      widget.planeta.componentes.removeAt(selectedIndex);
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
