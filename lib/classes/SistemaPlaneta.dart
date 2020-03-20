import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    sistemaPlanetario.qtdPlanetas += 1;
    sistemaPlanetario.editarSistemaPlanetario(sistemaPlanetario.galaxia);
  }

  void deletarSistemaPlaneta(){
    Firestore db = Firestore.instance;
    sistemaPlanetario.qtdPlanetas -= 1;
    sistemaPlanetario.editarSistemaPlanetario(sistemaPlanetario.galaxia);
    db.collection("sistemas_planetas").document(id).delete();
    Fluttertoast.showToast(
      msg: "Relacionamento deletado com sucesso!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void editarSistemaPlaneta(SistemaPlanetario sistemaAntigo){
    Firestore db = Firestore.instance;
    db.collection("sistemas_planetas").document(id).setData({
      "idPlaneta": planeta.id,
      "idSistema": sistemaPlanetario.id
    });
    if(sistemaPlanetario.id != sistemaAntigo.id){
      sistemaPlanetario.editarSistemaPlanetario(sistemaPlanetario.galaxia);
      sistemaAntigo.editarSistemaPlanetario(sistemaAntigo.galaxia);
    }
  }


}