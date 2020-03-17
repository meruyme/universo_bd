import 'package:flutter/material.dart';
import 'package:universo_bd/estrela/cadastrar_gigante_vermelha.dart';
import 'package:universo_bd/estrela/editar_estrela.dart';
import 'package:universo_bd/estrela/editar_gigante_vermelha.dart';
import 'package:universo_bd/estrela/exibir_estrela.dart';
import 'package:universo_bd/estrela/exibir_gigante_vermelha.dart';
import 'package:universo_bd/galaxia/cadastrar_galaxia.dart';
import 'package:universo_bd/galaxia/editar_galaxia.dart';
import 'package:universo_bd/galaxia/exibir_galaxia.dart';
import 'package:universo_bd/galaxia/listar_galaxia.dart';
import 'package:universo_bd/planeta/cadastrar_planeta.dart';
import 'package:universo_bd/estrela/cadastrar_estrela.dart';
import 'package:universo_bd/estrela/listar_estrela.dart';
import 'package:universo_bd/planeta/editar_planeta.dart';
import 'package:universo_bd/planeta/exibir_planeta.dart';
import 'package:universo_bd/planeta/listar_planeta.dart';
import 'package:universo_bd/login.dart';
import 'package:universo_bd/relacionamentos/sistema_estrela/cadastrar_sistema_estrela.dart';
import 'package:universo_bd/relacionamentos/sistema_planeta/cadastrar_sistema_planeta.dart';
import 'package:universo_bd/satelite_natural/cadastrar_satelite_natural.dart';
import 'package:universo_bd/satelite_natural/editar_satelite_natural.dart';
import 'package:universo_bd/satelite_natural/exibir_satelite_natural.dart';
import 'package:universo_bd/satelite_natural/listar_satelite_natural.dart';
import 'package:universo_bd/sistema_planetario/cadastrar_sistema_planetario.dart';
import 'package:universo_bd/sistema_planetario/editar_sistema_planetario.dart';
import 'package:universo_bd/sistema_planetario/exibir_sistema_planetario.dart';
import 'package:universo_bd/sistema_planetario/listar_sistema_planetario.dart';

void main(){

  runApp(
      MaterialApp(
        initialRoute: "/",
        routes: {
          "/login" : (context) => login(),
          "/cadastrar_planeta" : (context) => cadastrar_planeta(),
          "/editar_planeta" : (context) => editar_planeta(planeta: ModalRoute.of(context).settings.arguments),
          "/listar_planeta" : (context) => listar_planeta(),
          "/exibir_planeta" : (context) => exibir_planeta(planeta: ModalRoute.of(context).settings.arguments),
          "/cadastrar_estrela" : (context) => cadastrar_estrela(tipo_estrela: ModalRoute.of(context).settings.arguments),
          "/listar_estrela" : (context) => listar_estrela(),
          "/editar_estrela" : (context) => editar_estrela(estrela: ModalRoute.of(context).settings.arguments),
          "/exibir_estrela" : (context) => exibir_estrela(estrela: ModalRoute.of(context).settings.arguments),
          "/cadastrar_gigante_vermelha" : (context) => cadastrar_gigante_vermelha(),
          "/exibir_gigante_vermelha" : (context) => exibir_gigante_vermelha(estrela: ModalRoute.of(context).settings.arguments),
          "/editar_gigante_vermelha" : (context) => editar_gigante_vermelha(estrela: ModalRoute.of(context).settings.arguments),
          "/listar_galaxia" : (context) => listar_galaxia(),
          "/cadastrar_galaxia" : (context) => cadastrar_galaxia(),
          "/exibir_galaxia" : (context) => exibir_galaxia(galaxia: ModalRoute.of(context).settings.arguments),
          "/editar_galaxia" : (context) => editar_galaxia(galaxia: ModalRoute.of(context).settings.arguments),
          "/cadastrar_satelite_natural" : (context) => cadastrar_satelite_natural(),
          "/listar_satelite_natural" : (context) => listar_satelite_natural(),
          "/exibir_satelite_natural" : (context) => exibir_satelite_natural(sateliteNatural: ModalRoute.of(context).settings.arguments),
          "/editar_satelite_natural" : (context) => editar_satelite_natural(sateliteNatural: ModalRoute.of(context).settings.arguments),
          "/cadastrar_sistema_planetario" : (context) => cadastrar_sistema_planetario(),
          "/listar_sistema_planetario" : (context) => listar_sistema_planetario(),
          "/exibir_sistema_planetario" : (context) => exibir_sistema_planetario(arguments: ModalRoute.of(context).settings.arguments),
          "/editar_sistema_planetario" : (context) => editar_sistema_planetario(arguments: ModalRoute.of(context).settings.arguments),
          "/cadastrar_sistema_estrela" : (context) => cadastrar_sistema_estrela(),
          "cadastrar_sistema_planeta" : (context) => cadastrar_sistema_planeta()
        },
        home: login(),
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            accentColor: Colors.deepPurpleAccent,
            fontFamily: "Poppins",
            textTheme: TextTheme(
                body1: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal
                )
            ),
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.deepPurpleAccent,
                textTheme: ButtonTextTheme.primary
            )
        ),
      )
  );





  /*DocumentReference ref = await db.collection("planetas")
    .add(
      {
        "nome": "Marte",
        "tamanho": 40000,
        "massa": 900000
      }
  );
    print("item salvo: "+ref.documentID);

  */

 /* db.collection("planetas")
    .document("WqfJvKglwoAx6vnxGeJ7")
    .setData(
      {
        "nome": "Saturno",
        "tamanho": 35000,
        "massa": 1000000
      }
  );*/



  /*db.collection("usuarios")
    .document("002")
    .setData({
      "nome": "Eduardo",
      "idade": "19"
    }
  );*/


}



