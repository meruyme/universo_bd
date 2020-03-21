import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import 'package:universo_bd/widgets/navigation_drawer.dart';
import 'package:universo_bd/relations_icons_icons.dart';

class menu_relacoes extends StatefulWidget {
  @override
  _menu_relacoesState createState() => _menu_relacoesState();
}

class _menu_relacoesState extends State<menu_relacoes> {

  List<String> _titulos = List();
  List<String> _nomeRotas = List();
  List<Icon> _icones = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titulos.add("Sistemas\nPlanetas");
    _titulos.add("Planetas\nEstrelas\nSatélites");
    _titulos.add("Sistemas\nEstrelas");
    _nomeRotas.add("/listar_sistema_planeta");
    _nomeRotas.add("/listar_orbitantes");
    _nomeRotas.add("/listar_sistema_estrela");
    _icones.add(Icon(RelationsIcons.system_planet, size: 60));
    _icones.add(Icon(RelationsIcons.orbit, size: 60));
    _icones.add(Icon(RelationsIcons.system_star, size: 60));
  }

  @override
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
        drawer: navigation_drawer(tela: "menu_relacoes"),
        appBar: AppBar(
          title: Text("Relações"),
        ),
        body: new StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(top:20, left: 20, right: 20, bottom: 20),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            crossAxisCount: 2,
            itemCount: 3,
            itemBuilder:(BuildContext context, int index) => new Container(
                color: Color.fromRGBO(64, 75, 96, 0.9),
                //fit: BoxFit.fill,
                child: new Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: RaisedButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: _icones[index],
                            ),
                            Text(
                              _titulos[index],
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
                          Navigator.pushNamed(context, _nomeRotas[index]);
                        },
                      ),
                    ),
                )),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(1, (index.isEven) ? 1.4245 : 2.849)
        ),
      ),

    );
  }
}