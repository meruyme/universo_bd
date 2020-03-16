import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universo_bd/classes/Estrela.dart';

class GiganteVermelha extends Estrela{

  bool _morta;

  GiganteVermelha();

  bool get morta => _morta;

  set morta(bool value) {
    _morta = value;
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