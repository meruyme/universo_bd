import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universo_bd/relations_icons_icons.dart';
import 'custom_icons_icons.dart';

class navigation_drawer extends StatefulWidget {

  String tela;

  navigation_drawer({this.tela});

  @override
  _navigation_drawerState createState() => _navigation_drawerState();
}

class _navigation_drawerState extends State<navigation_drawer> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(""),
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/210.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ListTile(
              leading: Icon(CustomIcons.planet, color: Color.fromRGBO(64, 75, 96, 0.9),),
              title: Text(
                'Planetas',
                style: TextStyle(
                  color: Color.fromRGBO(64, 75, 96, 0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if(widget.tela != "listar_planeta"){
                  Navigator.of(context).pushNamed("/listar_planeta");
                }
              },
            ),
            ListTile(
              leading: Icon(CustomIcons.satellite, color: Color.fromRGBO(64, 75, 96, 0.9),),
              title: Text(
                'Satélites',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(64, 75, 96, 0.9)
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if(widget.tela != "listar_satelite_natural"){
                  Navigator.of(context).pushNamed("/listar_satelite_natural");
                }
              },
            ),
            ListTile(
              leading: Icon(CustomIcons.constellation, color: Color.fromRGBO(64, 75, 96, 0.9),),
              title: Text(
                'Estrelas',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(64, 75, 96, 0.9)
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if(widget.tela != "listar_estrela"){
                  Navigator.of(context).pushNamed("/listar_estrela");
                }
              },
            ),
            ListTile(
              leading: Icon(CustomIcons.solar_system, color: Color.fromRGBO(64, 75, 96, 0.9),),
              title: Text(
                'Sistemas Planetários',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(64, 75, 96, 0.9)
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if(widget.tela != "listar_sistema_planetario"){
                  Navigator.of(context).pushNamed("/listar_sistema_planetario");
                }
              },
            ),
            ListTile(
              leading: Icon(CustomIcons.black_hole, color: Color.fromRGBO(64, 75, 96, 0.9),),
              title: Text(
                'Galáxias',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(64, 75, 96, 0.9)
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if(widget.tela != "listar_galaxia"){
                  Navigator.of(context).pushNamed("/listar_galaxia");
                }
              },
            ),
            ListTile(
              leading: Icon(RelationsIcons.space, color: Color.fromRGBO(64, 75, 96, 0.9),),
              title: Text(
                'Relacionamentos',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(64, 75, 96, 0.9)
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                if(widget.tela != "menu_relacoes"){
                  Navigator.of(context).pushNamed("/menu_relacoes");
                }
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Color.fromRGBO(64, 75, 96, 0.9),),
              title: Text(
                'Sair',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(64, 75, 96, 0.9)
                ),
              ),
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();
                Navigator.pushNamedAndRemoveUntil(context,
                    "/login",
                        (_) => false
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}