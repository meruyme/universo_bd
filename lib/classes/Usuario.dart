import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Usuario{

  String _email;
  String _senha;

  Usuario(String email, String senha){
    this._email = email.trim();
    this._senha = senha;
  }

  String get email{
    return this._email;
  }

  set email(String email){
    this._email = email.trim();
  }

  String get senha{
    return this._senha;
  }

  set senha(String senha){
    this._senha = senha;
  }

  void logarUsuario(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: email, password: senha
    ).then((firebaseUser){
      Fluttertoast.showToast(
        msg: "Usuário logado com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pushNamedAndRemoveUntil(context,
          "/listar_planeta",
              (_) => false
      );
    }).catchError((error){
      String mensagem;
      if(error.message == "The password is invalid or the user does not have a password."){
        mensagem = "A senha está incorreta.";
      }
      else if(error.message == "There is no user record corresponding to this identifier. The user may have been deleted."){
        mensagem = "O usuário não existe no sistema.";
      }
      else if(error.message == "The email address is badly formatted."){
        mensagem = "O endereço de e-mail está mal formatado.";
      }
      else{
        mensagem = "Ocorreu um erro.";
      }
      Fluttertoast.showToast(
        msg: mensagem,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

    });
  }

  void cadastrarUsuario(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: email,
        password: senha
    ).then((firebaseUser){
      Fluttertoast.showToast(
        msg: "Usuário cadastrado com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pushNamedAndRemoveUntil(context,
          "/listar_planeta",
              (_) => false
      );
    }).catchError((error){
      String mensagem;
      if(error.message == "The email address is already in use by another account."){
        mensagem = "O endereço de e-mail já está em uso.";
      }
      else if(error.message == "The email address is badly formatted."){
        mensagem = "O endereço de e-mail está mal formatado.";
      }
      else{
        mensagem = "Ocorreu um erro.";
      }
      Fluttertoast.showToast(
        msg: mensagem,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    });
  }

}