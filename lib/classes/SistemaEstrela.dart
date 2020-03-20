import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    sistemaPlanetario.qtdEstrelas += 1;
    sistemaPlanetario.editarSistemaPlanetario(sistemaPlanetario.galaxia);
  }

  void deletarSistemaEstrela(){
    Firestore db = Firestore.instance;
    sistemaPlanetario.qtdEstrelas -= 1;
    sistemaPlanetario.editarSistemaPlanetario(sistemaPlanetario.galaxia);
    db.collection("sistemas_estrelas").document(id).delete();
    Fluttertoast.showToast(
      msg: "Relacionamento deletado com sucesso!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void editarSistemaEstrela(SistemaPlanetario sistemaAntigo){
    Firestore db = Firestore.instance;
    db.collection("sistemas_estrelas").document(id).setData({
      "idEstrela": estrela.id,
      "idSistema": sistemaPlanetario.id
    });
    if(sistemaPlanetario.id != sistemaAntigo.id){
      sistemaPlanetario.editarSistemaPlanetario(sistemaPlanetario.galaxia);
      sistemaAntigo.editarSistemaPlanetario(sistemaAntigo.galaxia);
    }
  }

}