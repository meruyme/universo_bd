import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';

class SistemaPlaneta{
  String _id;
  Planeta _planeta;
  SistemaPlanetario _sistemaPlanetario;

  SistemaPlaneta();


  Planeta get planeta => _planeta;

  set planeta(Planeta value) {
    _planeta = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  SistemaPlanetario get sistemaPlanetario => _sistemaPlanetario;

  set sistemaPlanetario(SistemaPlanetario value) {
    _sistemaPlanetario = value;
  }

  void adicionarSistemaPlaneta(){
    Firestore db = Firestore.instance;
    db.collection("sistemas_planetas").add({
      "idPlaneta": planeta.id,
      "idSistema": sistemaPlanetario.id
    });
  }


}