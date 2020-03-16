import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universo_bd/classes/Usuario.dart';
import 'package:universo_bd/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universo_bd/planeta/listar_planeta.dart';

import 'cadastrar_usuario.dart';


class login extends StatefulWidget {

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  //String _mensagemErro = "";
  //bool _logou = false;
  //Criando usuário com e-mail e senha
  /*void cadastroUsuario() async{

    FirebaseAuth auth = FirebaseAuth.instance;

    String email = "atenas503@gmail.com";
    String senha = "123456";

    /*auth.createUserWithEmailAndPassword(
        email: email, 
        password: senha
    ).then((firebaseUser){
      print("email novo usuario: " + firebaseUser.user.email);
    }).catchError((erro){
      print("erro " + erro.toString());
    }
    );*/

    //auth.signOut();

  /*  auth.signInWithEmailAndPassword(
        email: email,
        password: senha
    ).then((firebaseUser){
      print("Logar usuario: " + firebaseUser.user.email);
    }).catchError((erro){
      print("Logar usuario erro " + erro.toString());
    });
*/

    /*FirebaseUser usuarioAtual = await auth.currentUser();

    if(usuarioAtual != null){//logado
      print("usuario atual email: " + usuarioAtual.email);
    }else{//deslogado
      print("ta deslogado");
    }*/

  }*/


  validarCampos(){
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isEmpty || senha.isEmpty){
      Fluttertoast.showToast(
          msg: "Preencha todos os campos.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
      );
    }
    else{
      Usuario usuario = Usuario(email, senha);

      usuario.logarUsuario(context);
    }
  }

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  Future _estaLogado() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    if(usuarioLogado != null) {
      Navigator.pushNamedAndRemoveUntil(context,
          "/listar_planeta",
              (_) => false
      );
    }
  }

  @override
  void initState() {
   /* FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();*/
    _estaLogado();
    // TODO: implement initState
    super.initState();
  }

  final key = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/login.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Scaffold(
          key: key,
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Padding do Icone
                  Padding(
                    padding:EdgeInsetsDirectional.only(bottom: 50),
                    child: Image.asset("images/icon_planet.png",scale:3.5),
                  ),
                  //Padding do Email
                  Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 16),
                    child: custom_text_field(
                      label: "E-mail",
                      controller: _controllerEmail,
                      textInputType: TextInputType.emailAddress,
                      isPassword: false,
                    ),
                  ),

                  //Padding da Senha
                  Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 32),
                    child: custom_text_field(
                      label: "Senha",
                      controller: _controllerSenha,
                      textInputType: TextInputType.text,
                      isPassword: true,
                    ),
                  ),

                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        //side: BorderSide(color: Colors.transparent)
                      ),
                    elevation: 4,
                    child: Text("Entrar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: (){

                      validarCampos();
                    }
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => cadastrar_usuario()
                            )
                        );
                      },
                      child: Text(
                        "Não possui conta? Cadastre-se!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white
                        ),
                      ),
                    )
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
