import 'package:cloud_firestore/cloud_firestore.dart';

class SateliteNatural{

  String _id;
  String _nome;
  double _tamanho;
  double _massa;
  List<String> _componentes;

  SateliteNatural();

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

  void editarSateliteNatural(){
    Firestore db = Firestore.instance;
    db.collection("satelites_naturais").document(id).setData({
      "nome": nome,
      "tamanho": tamanho,
      "massa": massa,
      "componentes": componentes
    });
  }

  void adicionarSateliteNatural(){
    Firestore db = Firestore.instance;
    db.collection("satelites_naturais").add({
      "nome": nome,
      "tamanho": tamanho,
      "massa": massa,
      "componentes": componentes
    });
  }

}