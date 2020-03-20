import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/classes/Galaxia.dart';

class SistemaPlanetario{

  String _id;
  String _nome;
  double _idade;
  int _qtdPlanetas;
  int _qtdEstrelas;
  Galaxia _galaxia;

  SistemaPlanetario();


  Galaxia get galaxia => _galaxia;

  set galaxia(Galaxia value) {
    _galaxia = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


  String get nome => _nome;

  set nome(String value) {
    _nome = value.trim();
  }

  double get idade => _idade;

  set idade(double value) {
    _idade = value;
  }

  int get qtdPlanetas => _qtdPlanetas;

  set qtdPlanetas(int value) {
    _qtdPlanetas = value;
  }

  int get qtdEstrelas => _qtdEstrelas;

  set qtdEstrelas(int value) {
    _qtdEstrelas = value;
  }

  void deletarSistemaPlanetario() async{
    Firestore db = Firestore.instance;
    db.collection("sistemas_planetarios").document(id).delete();
    await db.collection("sistemas_planetas").where("idSistema", isEqualTo: id).getDocuments().then((snapshot){
      for(DocumentSnapshot item in snapshot.documents){
        db.collection("sistemas_planetas").document(item.documentID).delete();
      }
    });
    await db.collection("sistemas_estrelas").where("idSistema", isEqualTo: id).getDocuments().then((snapshot){
      for(DocumentSnapshot item in snapshot.documents){
        db.collection("sistemas_estrelas").document(item.documentID).delete();
      }
    });
    galaxia.qtdSistemas--;
    galaxia.editarGalaxia();
    Fluttertoast.showToast(
      msg: "Sistema Planetário deletado com sucesso!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void adicionarSistemaPlanetario(){
    Firestore db = Firestore.instance;
    db.collection("sistemas_planetarios").add({
      "nome": nome,
      "idade": idade,
      "idGalaxia": galaxia.id,
      "qtdPlanetas": 0,
      "qtdEstrelas": 0,
    });
    galaxia.editarGalaxia();
  }

  void editarSistemaPlanetario(Galaxia galaxiaAntiga){
    Firestore db = Firestore.instance;
    db.collection("sistemas_planetarios").document(id).setData({
      "nome": nome,
      "idade": idade,
      "idGalaxia": galaxia.id,
      "qtdPlanetas": qtdPlanetas,
      "qtdEstrelas": qtdEstrelas,
    });
    if(galaxiaAntiga.id != galaxia.id){
      galaxiaAntiga.editarGalaxia();
      galaxia.editarGalaxia();
    }
  }
}