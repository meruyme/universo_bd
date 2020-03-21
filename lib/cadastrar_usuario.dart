import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'classes/Usuario.dart';
import 'widgets/custom_text_field.dart';

class cadastrar_usuario extends StatefulWidget {
  @override
  _cadastrar_usuarioState createState() => _cadastrar_usuarioState();
}

class _cadastrar_usuarioState extends State<cadastrar_usuario> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerConfirmarSenha = TextEditingController();



  _validarCampos(){
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    String confirmar_senha = _controllerConfirmarSenha.text;

    if(email.isEmpty || senha.isEmpty || confirmar_senha.isEmpty){
      Fluttertoast.showToast(
        msg: "Preencha todos os campos.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    else{

      if(senha != confirmar_senha){
        Fluttertoast.showToast(
          msg: "Foram digitadas senhas diferentes.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
      else if(senha.length < 6){
        Fluttertoast.showToast(
          msg: "A senha deve possuir pelo menos 6 caracteres.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
      else {
        Usuario usuario = Usuario(email, senha);

        usuario.cadastrarUsuario(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/fundo_telas6.jpg"),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Cadastrar usuário"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:EdgeInsetsDirectional.only(top: 50 ,bottom: 50),
                child: Image.asset("images/astronaut.png",scale:4),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: 24, top: 16),
                child: custom_text_field(
                  label: "E-mail",
                  textInputType: TextInputType.emailAddress,
                  isPassword: false,
                  controller: _controllerEmail,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: 24),
                child: custom_text_field(
                  label: "Senha",
                  textInputType: TextInputType.text,
                  isPassword: true,
                  controller: _controllerSenha,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: 24),
                child: custom_text_field(
                  label: "Confirme a senha",
                  textInputType: TextInputType.text,
                  isPassword: true,
                  controller: _controllerConfirmarSenha,
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  //side: BorderSide(color: Colors.transparent)
                ),
                elevation: 4,
                child: Text("Salvar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: (){
                  _validarCampos();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
