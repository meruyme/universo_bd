import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Galaxia.dart';
import 'SistemaPlanetario.dart';

class Estrela{

  String _id;
  String _nome;
  double _tamanho;
  double _distanciaTerra;
  double _idade;
  String _tipo;

  Estrela();


  String get id => _id;

  set id(String value) {
    _id = value;
  }


  String get nome => _nome;

  set nome(String value) {
    _nome = value.trim();
  }

  double get tamanho => _tamanho;

  set tamanho(double value) {
    _tamanho = value;
  }


  double get distanciaTerra => _distanciaTerra;

  set distanciaTerra(double value) {
    _distanciaTerra = value;
  }

  double get idade => _idade;

  set idade(double value) {
    _idade = value;
  }


  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
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

  void adicionarEstrela() {
    Firestore db = Firestore.instance;
    db.collection("estrelas").add({
      "nome": nome,
      "tamanho": tamanho,
      "idade": idade,
      "distanciaTerra": distanciaTerra,
      "tipo": tipo,
    });
  }

  void editarEstrela() {
    Firestore db = Firestore.instance;
    db.collection("estrelas").document(id).setData({
      "nome": nome,
      "tamanho": tamanho,
      "idade": idade,
      "distanciaTerra": distanciaTerra,
      "tipo": tipo,
    });
  }

}