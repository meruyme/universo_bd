import 'package:flutter/material.dart';
import 'package:universo_bd/help_icon_icons.dart';
import 'package:universo_bd/widgets/navigation_drawer.dart';
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  String corposCelestes;
  String relacionamentos;
  String funcionalidades;

  void initState() {
    super.initState();
    funcionalidades= " Sair: Desloga o usuário vigente.\n\n- Início: Volta para a tela inicial do aplicativo, que contém a descrição do app e essa ajudinha bacana para ser lida novamente em caso de dúvida =)";
    relacionamentos= "Relacionamentos: Contém tipos de relacionamentos que podem ser feitos entre os corpos celestes. Ao clicar em qualquer um dos tipos de relacionamento é exibida um lista com todos os relacionamentos daquele tipo. Ao clicar no +, canto inferior esquerdo, é possível adicionar um novo relacionamento do mesmo tipo.\n Ao tentar formar um novo relacionamento é possível criar novos elementos dos tipos que estão se relacionando, para tal basta clicar no + ao lado do tipo desejado.";
    corposCelestes = " Todos os corpos celestes presentes nesse app: Planetas, Satélites, Estrelas, Sistemas Planetários e Galáxias. Ao clicar em qualquer um deles é exibida uma lista que contém todos os elementos cadastrados daquele tipo. Se clicar na lupa, canto superior direito, é possível fazer uma busca por um elemento específico utilizando seu nome (Ao clicar no X após feita a busca é cancelado o filtro por nome).\n Se clicar no botão com um + você pode adicionar um novo elemento (Sempre que houver um + ao lado de um atributo é sinal que ao clicar pode criar um novo atributo, mesmo que seja um novo corpo celeste. De maneira similar, o - significa remover).\n Ao clicar em algum elemento da lista, é mostrada a descrição dele, contendo todos os seus atributos. Clicando nos dois icones no canto superior direito é possível editar esse elemento (no ícone que se assemelha a um lápis) ou deletar esse elemento (no ícone que se assemelha a uma lixeira).";
  }

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
          drawer: navigation_drawer(tela: "home",),
          appBar: AppBar(
            title: Text("YOUniverse"),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom:50,left:50,right:50,top:40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Padding do Icone
                  Padding(
                    padding:EdgeInsetsDirectional.only(bottom: 50),
                    child: Image.asset("images/telescope.png",scale:3.5),
                  ),
                  Padding(
                        padding: EdgeInsetsDirectional.only(bottom: 32),
                        child: Text(
                          "YOUniverse é um aplicativo onde você pode manter um cadastro dos corpos celestes do nosso universo. Nele, você e outros usuários podem contribuir cadastrando novos corpos ou relacionando-os.\n Se quiser saber como utilizar esse aplicativo clique na interrogação abaixo.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily:"AmaticSC",
                              fontSize: 20
                          ),
                      )
                  ),

                  //Padding da Senha
                  Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 32),
                    child:  ClipOval(
                      child: Material(
                        color: Colors.deepPurple, // button color
                        child: InkWell(
                          splashColor: Colors.white, // inkwell color
                            child: SizedBox(width: 35, height: 35, child: Icon(HelpIcon.question_sign, color: Colors.white, size: 20,)),
                          onTap: () {
                            showDialog(
                                context: context,
                                 child: SimpleDialog(
                                      title: Text("Como utilizar"),
                                      children: <Widget>[
                                        SingleChildScrollView(
                                            padding: EdgeInsets.all(16),
                                            child: Text(
                                                    "Ao clicar no canto superior direito, três barras horizontais, é aberto um menu com as funcionalidades do aplicativo, que são:\n\n"
                                                   +"- "+corposCelestes+"\n\n"
                                                   +"- "+relacionamentos+"\n\n"
                                                   +"- "+funcionalidades+"\n",
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      //fontFamily:"AmaticSC",
                                                      fontSize: 15
                                                  ),
                                            ),
                                        ),
                                      ],
                                  )
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
