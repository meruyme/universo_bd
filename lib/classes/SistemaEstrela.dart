import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universo_bd/classes/Estrela.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';

class SistemaEstrela{
  String _id;
  Estrela _estrela;
  SistemaPlanetario _sistemaPlanetario;


  Estrela get estrela => _estrela;

  set estrela(Estrela value) {
    _estrela = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  SistemaPlanetario get sistemaPlanetario => _sistemaPlanetario;

  set sistemaPlanetario(SistemaPlanetario value) {
    _sistemaPlanetario = value;
  }

  void adicionarSistemaEstrela(){
    Firestore db = Firestore.instance;
    db.collection("sistemas_estrelas").add({
      "idEstrela": estrela.id,
      "idSistema": sistemaPlanetario.id
    });
  }

}