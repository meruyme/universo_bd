import 'package:flutter/material.dart';

import '../custom_icon_star_icons.dart';

class dialog_estrela extends StatefulWidget {
  @override
  _dialog_estrelaState createState() => _dialog_estrelaState();
}

class _dialog_estrelaState extends State<dialog_estrela> {
  @override


  List<String> _titulos = List();
  List<String> _nomeRotas = List();
  List<Icon> _icones = List();

  void initState(){
    super.initState;
    _titulos.add(" Anã Vermelha ");
    _titulos.add(" Anã Branca  ");
    _titulos.add("Estrela Binária");
    _titulos.add("Gigante Azul");
    _titulos.add("Gigante Vermelha");
    _nomeRotas.add("/cadastrar_estrela");
    _nomeRotas.add("/cadastrar_estrela");
    _nomeRotas.add("/cadastrar_estrela");
    _nomeRotas.add("/cadastrar_estrela");
    _nomeRotas.add("/cadastrar_gigante_vermelha");
    _icones.add(Icon(CustomIconStar.stars1, size: 60));
    _icones.add(Icon(CustomIconStar.stars2, size: 60));
    _icones.add(Icon(CustomIconStar.stars3, size: 60));
    _icones.add(Icon(CustomIconStar.stars4, size: 60));
    _icones.add(Icon(CustomIconStar.stars5, size: 60));
  }

  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text("Selecione o tipo da estrela"),
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 0,right: 10),
                            child: Container(
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: RaisedButton(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10,top:10),
                                        child: _icones[0],
                                      ),
                                      Text(
                                        _titulos[0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "AmaticSC",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: (){
                                    Navigator.of(context, rootNavigator: true).pop();
                                    Navigator.pushNamed(context, _nomeRotas[0],arguments: "Anã Vermelha");
                                  },
                                ),
                              ),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Container(
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: RaisedButton(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10,top:10),
                                        child: _icones[1],
                                      ),
                                      Text(
                                        _titulos[1],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "AmaticSC",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: (){
                                    Navigator.of(context, rootNavigator: true).pop();
                                    Navigator.pushNamed(context, _nomeRotas[1],arguments: "Anã Branca");
                                  },
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0,),
                    child: Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10,right:10),

                            child: Container(
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: RaisedButton(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10,top:10),
                                        child: _icones[2],
                                      ),
                                      Text(
                                        _titulos[2],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "AmaticSC",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: (){
                                    Navigator.of(context, rootNavigator: true).pop();
                                    Navigator.pushNamed(context, _nomeRotas[2],arguments: "Estrela Binária");
                                  },
                                ),
                              ),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),

                            child: Container(
                              child: FittedBox(
                                fit: BoxFit.fill ,
                                child: RaisedButton(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10,top:10),
                                        child: _icones[3],
                                      ),
                                      Text(
                                        _titulos[3],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "AmaticSC",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: (){
                                    Navigator.of(context, rootNavigator: true).pop();
                                    Navigator.pushNamed(context, _nomeRotas[3],arguments: "Gigante Azul");
                                  },
                                ),
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 0),

                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: RaisedButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10,top:10),
                                  child: _icones[4],
                                ),
                                Text(
                                  _titulos[4],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "AmaticSC",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                  ),
                                ),
                              ],
                            ),
                            onPressed: (){
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.pushNamed(context, _nomeRotas[4]);
                            },
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          )
        ]
    );
  }
}
