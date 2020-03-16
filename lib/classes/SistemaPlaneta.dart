import 'package:cloud_firestore/cloud_firestore.dart';

class SistemaPlaneta{
  String _idPlaneta;
  String _idSistema;

  SistemaPlaneta();

  String get idSistema => _idSistema;

  set idSistema(String value) {
    _idSistema = value;
  }

  String get idPlaneta => _idPlaneta;

  set idPlaneta(String value) {
    _idPlaneta = value;
  }

  void cadastrarSistemaPlaneta(){
    Firestore db = Firestore.instance;
    db.collection("sistemas_planetas").add({
      "idPlaneta": idPlaneta,
      "idSistema": idSistema
    });
  }


}