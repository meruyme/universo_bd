import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/classes/Galaxia.dart';
import 'package:universo_bd/classes/SistemaPlanetario.dart';

class Planeta{

  String _id;
  String _nome;
  double _tamanho;
  double _massa;
  double _velocidadeRotacao;
  List<String> _componentes;

  Planeta();

  double get velocidadeRotacao => _velocidadeRotacao;

  set velocidadeRotacao(double value) {
    _velocidadeRotacao = value;
  }

  List<String> get componentes => _componentes;

  set componentes(List<String> value) {
    _componentes = value;
  }

  double get massa => _massa;

  set massa(double value) {
    _massa = value;
  }

  double get tamanho => _tamanho;

  set tamanho(double value) {
    _tamanho = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value.trim();
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  void deletarPlaneta() async{
    Firestore db = Firestore.instance;
    db.collection("planetas").document(id).delete();
    await db.collection("sistemas_planetas").where("idPlaneta", isEqualTo: id).getDocuments().then((snapshot){
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
          sp.qtdPlanetas--;
          sp.editarSistemaPlanetario(sp.galaxia);
        });
        db.collection("sistemas_planetas").document(item.documentID).delete();
      }
    });
    await db.collection("orbitantes").where("idPlaneta", isEqualTo: id).getDocuments().then((snapshot){
      for(DocumentSnapshot item in snapshot.documents){
        db.collection("orbitantes").document(item.documentID).delete();
      }
    });
    Fluttertoast.showToast(
      msg: "Planeta deletado com sucesso!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void editarPlaneta(){
    Firestore db = Firestore.instance;
    db.collection("planetas").document(id).setData({
      "nome": nome,
      "tamanho": tamanho,
      "massa": massa,
      "velocidadeRotacao": velocidadeRotacao,
      "componentes": componentes
    });
  }

  void adicionarPlaneta(){
    Firestore db = Firestore.instance;
    db.collection("planetas").add({
      "nome": nome,
      "tamanho": tamanho,
      "massa": massa,
      "velocidadeRotacao": velocidadeRotacao,
      "componentes": componentes
    });
  }

}