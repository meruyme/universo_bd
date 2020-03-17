import 'package:cloud_firestore/cloud_firestore.dart';

class Orbitantes{

  String _idPlaneta;
  String _idSatelite;
  String _idEstrela;

  String get idPlaneta => _idPlaneta;

  set idPlaneta(String value) {
    _idPlaneta = value;
  }

  String get idSatelite => _idSatelite;

  String get idEstrela => _idEstrela;

  set idEstrela(String value) {
    _idEstrela = value;
  }

  set idSatelite(String value) {
    _idSatelite = value;
  }

  void adicionarOrbitantes(){
    Firestore db = Firestore.instance;
    db.collection("orbitantes").add({
      "idSatelite": idSatelite,
      "idPlaneta": idPlaneta,
      "idEstrela": idEstrela
    });
  }


}