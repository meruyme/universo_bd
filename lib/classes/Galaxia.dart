import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Galaxia{

  String _id;
  int _qtdSistemas;
  double _distanciaTerra;
  String _nome;

  Galaxia();

  String get nome => _nome;

  set nome(String value) {
    _nome = value.trim();
  }

  double get distanciaTerra => _distanciaTerra;

  set distanciaTerra(double value) {
    _distanciaTerra = value;
  }

  int get qtdSistemas => _qtdSistemas;

  set qtdSistemas(int value) {
    _qtdSistemas = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  void deletarGalaxia() async{
    Firestore db = Firestore.instance;
    db.collection("galaxias").document(id).delete();
    await db.collection("sistemas_planetarios").where("idGalaxia", isEqualTo: id).getDocuments().then((snapshot){
      for(DocumentSnapshot item in snapshot.documents){
        db.collection("sistemas_planetarios").document(item.documentID).delete();
      }
    });


    Fluttertoast.showToast(
      msg: "Galáxia deletada com sucesso!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void adicionarGalaxia(){
    Firestore db = Firestore.instance;
    db.collection("galaxias").add({
      "nome": nome,
      "qtdSistemas": 0,
      "distanciaTerra": distanciaTerra,
    });
  }

  void editarGalaxia(){
    Firestore db = Firestore.instance;
    db.collection("galaxias").document(id).setData({
      "nome": nome,
      "qtdSistemas": qtdSistemas,
      "distanciaTerra": distanciaTerra,
    });
  }
}
