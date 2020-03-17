import 'package:cloud_firestore/cloud_firestore.dart';

class SistemaEstrela{
  String _idEstrela;
  String _idSistema;

  String get idEstrela => _idEstrela;

  set idEstrela(String value) {
    _idEstrela = value;
  }

  String get idSistema => _idSistema;

  set idSistema(String value) {
    _idSistema = value;
  }

  void adicionarSistemaEstrela(){
    Firestore db = Firestore.instance;
    db.collection("sistemas_estrelas").add({
      "idEstrela": idEstrela,
      "idSistema": idSistema
    });
  }

}