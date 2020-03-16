import 'package:cloud_firestore/cloud_firestore.dart';

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