import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/classes/Estrela.dart';

import 'Galaxia.dart';
import 'SistemaPlanetario.dart';

class GiganteVermelha extends Estrela{

  bool _morta;

  GiganteVermelha();

  bool get morta => _morta;

  set morta(bool value) {
    _morta = value;
  }

  void deletarEstrela() async{
    Firestore db = Firestore.instance;
    db.collection("planetas").document(id).delete();
    await db.collection("sistemas_estrelas").where("idEstrela", isEqualTo: id).getDocuments().then((snapshot){
      for(DocumentSnapshot item in snapshot.documents){
        db.collection("sistemas_planetarios").document(item.data["idSistema"]).get().then((snapshotSP){
          SistemaPlanetario sp = SistemaPlanetario();
          var dados = snapshotSP.data;
          Galaxia galaxia = Galaxia();
          galaxia.id = dados["idGalaxia"];
          sp.id=item.data["idSistema"];
          sp.idade=dados["idade"];
          sp.qtdPlanetas=dados["qtdPlanetas"];
          sp.qtdEstrelas=dados["qtdEstrelas"];
          sp.nome = dados["nome"];
          sp.galaxia = galaxia;
          sp.qtdEstrelas--;
          sp.editarSistemaPlanetario(sp.galaxia);
        });
        db.collection("sistemas_estrelas").document(item.documentID).delete();
      }
    });
    await db.collection("orbitantes").where("idEstrela", isEqualTo: id).getDocuments().then((snapshot){
      for(DocumentSnapshot item in snapshot.documents){
        db.collection("orbitantes").document(item.documentID).delete();
      }
    });
    Fluttertoast.showToast(
      msg: "Estrela deletada com sucesso!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void adicionarEstrela() {
    Firestore db = Firestore.instance;
    db.collection("estrelas").add({
      "nome": nome,
      "tamanho": tamanho,
      "idade": idade,
      "distanciaTerra": distanciaTerra,
      "tipo": tipo,
      "morta": morta,
    });
  }

  void editarEstrela() {
    // TODO: implement editarEstrela
    Firestore db = Firestore.instance;
    db.collection("estrelas").document(id).setData({
      "nome": nome,
      "tamanho": tamanho,
      "idade": idade,
      "distanciaTerra": distanciaTerra,
      "tipo": tipo,
      "morta": morta,
    });
  }

}