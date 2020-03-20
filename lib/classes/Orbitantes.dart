import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/Planeta.dart';
import 'package:universo_bd/classes/SateliteNatural.dart';

class Orbitantes{

  String _id;
  SateliteNatural _sateliteNatural;
  Planeta _planeta;
  Estrela _estrela;


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  SateliteNatural get sateliteNatural => _sateliteNatural;

  set sateliteNatural(SateliteNatural value) {
    _sateliteNatural = value;
  }

  Planeta get planeta => _planeta;

  set planeta(Planeta value) {
    _planeta = value;
  }

  Estrela get estrela => _estrela;

  set estrela(Estrela value) {
    _estrela = value;
  }

  void adicionarOrbitantes(){
    Firestore db = Firestore.instance;
    db.collection("orbitantes").add({
      "idSatelite": sateliteNatural.id,
      "idPlaneta": planeta.id,
      "idEstrela": estrela.id
    });
  }

  void editarOrbitantes(){
    Firestore db = Firestore.instance;
    db.collection("orbitantes").document(id).setData({
      "idSatelite": sateliteNatural.id,
      "idPlaneta": planeta.id,
      "idEstrela": estrela.id
    });
  }

}

