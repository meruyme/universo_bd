import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universo_bd/classes/Planeta.dart';

class PlanetaBanco{

  PlanetaBanco();

  Future<Planeta> exibirPlaneta(Planeta p) async{
    Firestore db = Firestore.instance;
    db.collection("planetas").document(p.id).snapshots().listen(
            (snapshot){
          var dado = snapshot.data;
          p.nome = dado["nome"];
          p.tamanho = double.tryParse(dado["tamanho"].toString());
          p.massa = double.tryParse(dado["massa"].toString());
          //List<dynamic> aux = dado["componentes"];
          //componentes = dado["componentes"].Cast<String>().ToList();
         // print(p.nome);
          return p;
            }
    );
    //return p;
  }

}