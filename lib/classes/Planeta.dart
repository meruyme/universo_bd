import 'package:cloud_firestore/cloud_firestore.dart';

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