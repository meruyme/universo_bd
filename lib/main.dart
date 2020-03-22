import 'package:flutter/material.dart';
import 'package:universo_bd/cadastrar_usuario.dart';
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
import 'package:universo_bd/relacionamentos/menu_relacoes.dart';
import 'package:universo_bd/relacionamentos/orbitantes/cadastrar_orbitantes.dart';
import 'package:universo_bd/relacionamentos/orbitantes/editar_orbitantes.dart';
import 'package:universo_bd/relacionamentos/orbitantes/exibir_orbitantes.dart';
import 'package:universo_bd/relacionamentos/orbitantes/listar_orbitantes.dart';
import 'package:universo_bd/relacionamentos/sistema_estrela/cadastrar_sistema_estrela.dart';
import 'package:universo_bd/relacionamentos/sistema_estrela/editar_sistema_estrela.dart';
import 'package:universo_bd/relacionamentos/sistema_estrela/exibir_sistema_estrela.dart';
import 'package:universo_bd/relacionamentos/sistema_estrela/listar_sistema_estrela.dart';
import 'package:universo_bd/relacionamentos/sistema_planeta/cadastrar_sistema_planeta.dart';
import 'package:universo_bd/relacionamentos/sistema_planeta/editar_sistema_planeta.dart';
import 'package:universo_bd/relacionamentos/sistema_planeta/exibir_sistema_planeta.dart';
import 'package:universo_bd/relacionamentos/sistema_planeta/listar_sistema_planeta.dart';
import 'package:universo_bd/satelite_natural/cadastrar_satelite_natural.dart';
import 'package:universo_bd/satelite_natural/editar_satelite_natural.dart';
import 'package:universo_bd/satelite_natural/exibir_satelite_natural.dart';
import 'package:universo_bd/satelite_natural/listar_satelite_natural.dart';
import 'package:universo_bd/sistema_planetario/cadastrar_sistema_planetario.dart';
import 'package:universo_bd/sistema_planetario/editar_sistema_planetario.dart';
import 'package:universo_bd/sistema_planetario/exibir_sistema_planetario.dart';
import 'package:universo_bd/sistema_planetario/listar_sistema_planetario.dart';

import 'home.dart';

void main(){

  runApp(
      MaterialApp(
        initialRoute: "/",
        routes: {
          "/login" : (context) => login(),
          "/home" : (context) => home(),
          //"/dialog_home" : (context) => dialog_home(),
          "/cadastrar_usuario" : (context) => cadastrar_usuario(),
          "/cadastrar_planeta" : (context) => cadastrar_planeta(),
          "/editar_planeta" : (context) => editar_planeta(planeta: ModalRoute.of(context).settings.arguments),
          "/listar_planeta" : (context) => listar_planeta(),
          "/exibir_planeta" : (context) => exibir_planeta(arguments: ModalRoute.of(context).settings.arguments),
          "/cadastrar_estrela" : (context) => cadastrar_estrela(tipo_estrela: ModalRoute.of(context).settings.arguments),
          "/listar_estrela" : (context) => listar_estrela(),
          "/editar_estrela" : (context) => editar_estrela(estrela: ModalRoute.of(context).settings.arguments),
          "/exibir_estrela" : (context) => exibir_estrela(arguments: ModalRoute.of(context).settings.arguments),
          "/cadastrar_gigante_vermelha" : (context) => cadastrar_gigante_vermelha(),
          "/exibir_gigante_vermelha" : (context) => exibir_gigante_vermelha(arguments: ModalRoute.of(context).settings.arguments),
          "/editar_gigante_vermelha" : (context) => editar_gigante_vermelha(estrela: ModalRoute.of(context).settings.arguments),
          "/listar_galaxia" : (context) => listar_galaxia(),
          "/cadastrar_galaxia" : (context) => cadastrar_galaxia(),
          "/exibir_galaxia" : (context) => exibir_galaxia(galaxia: ModalRoute.of(context).settings.arguments),
          "/editar_galaxia" : (context) => editar_galaxia(galaxia: ModalRoute.of(context).settings.arguments),
          "/cadastrar_satelite_natural" : (context) => cadastrar_satelite_natural(),
          "/listar_satelite_natural" : (context) => listar_satelite_natural(),
          "/exibir_satelite_natural" : (context) => exibir_satelite_natural(arguments: ModalRoute.of(context).settings.arguments),
          "/editar_satelite_natural" : (context) => editar_satelite_natural(sateliteNatural: ModalRoute.of(context).settings.arguments),
          "/cadastrar_sistema_planetario" : (context) => cadastrar_sistema_planetario(),
          "/listar_sistema_planetario" : (context) => listar_sistema_planetario(),
          "/exibir_sistema_planetario" : (context) => exibir_sistema_planetario(arguments: ModalRoute.of(context).settings.arguments),
          "/editar_sistema_planetario" : (context) => editar_sistema_planetario(sistemaPlanetario: ModalRoute.of(context).settings.arguments),
          "/cadastrar_sistema_estrela" : (context) => cadastrar_sistema_estrela(),
          "/listar_sistema_estrela" : (context) => listar_sistema_estrela(),
          "/exibir_sistema_estrela" : (context) => exibir_sistema_estrela(sistemaEstrela: ModalRoute.of(context).settings.arguments),
          "/editar_sistema_estrela" : (context) => editar_sistema_estrela(sistemaEstrela: ModalRoute.of(context).settings.arguments),
          "/cadastrar_sistema_planeta" : (context) => cadastrar_sistema_planeta(),
          "/editar_sistema_planeta" : (context) => editar_sistema_planeta(sistemaPlaneta: ModalRoute.of(context).settings.arguments),
          "/listar_sistema_planeta" : (context) => listar_sistema_planeta(),
          "/exibir_sistema_planeta" : (context) => exibir_sistema_planeta(sistemaPlaneta: ModalRoute.of(context).settings.arguments),
          "/cadastrar_orbitantes" : (context) => cadastrar_orbitantes(),
          "/listar_orbitantes" : (context) => listar_orbitantes(),
          "/exibir_orbitantes" : (context) => exibir_orbitantes(orbitante: ModalRoute.of(context).settings.arguments),
          "/editar_orbitantes" : (context) => editar_orbitantes(orbitante: ModalRoute.of(context).settings.arguments),
          "/menu_relacoes" : (context) => menu_relacoes(),
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


}



