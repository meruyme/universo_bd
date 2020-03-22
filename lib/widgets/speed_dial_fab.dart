import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:universo_bd/custom_icon_star_icons.dart';

class speed_dial_fab extends StatefulWidget {

  ScrollController scrollController;

  speed_dial_fab({this.scrollController});

  @override
  _speed_dial_fabState createState() => _speed_dial_fabState();
}

class _speed_dial_fabState extends State<speed_dial_fab> {

  bool dialVisible = true;

  void setDialVisible(bool value){
    setState(() {
      dialVisible = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.scrollController = ScrollController()..addListener((){
      setDialVisible(widget.scrollController.position.userScrollDirection == ScrollDirection.forward);
    });

  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          visible: dialVisible,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          children: [
            SpeedDialChild(
              child: Icon(CustomIconStar.stars1, color: Colors.white,),
              label: "Cadastrar anã vermelha",
              labelBackgroundColor: Color.fromRGBO(64, 75, 96, 0.9),
              onTap: (){
                Navigator.pushNamed(context, "/cadastrar_estrela", arguments: "Anã Vermelha");
              }
            ),
            SpeedDialChild(
                child: Icon(CustomIconStar.stars2, color: Colors.white,),
                label: "Cadastrar anã branca",
                labelBackgroundColor: Color.fromRGBO(64, 75, 96, 0.9),
                onTap: (){
                  Navigator.pushNamed(context, "/cadastrar_estrela", arguments: "Anã Branca");
                }
            ),
            SpeedDialChild(
                child: Icon(CustomIconStar.stars3, color: Colors.white,),
                label: "Cadastrar estrela binária",
                labelBackgroundColor: Color.fromRGBO(64, 75, 96, 0.9),
                onTap: (){
                  Navigator.pushNamed(context, "/cadastrar_estrela", arguments: "Estrela binária");
                }
            ),
            SpeedDialChild(
                child: Icon(CustomIconStar.stars4, color: Colors.white,),
                label: "Cadastrar gigante azul",
                labelBackgroundColor: Color.fromRGBO(64, 75, 96, 0.9),
                onTap: (){
                  Navigator.pushNamed(context, "/cadastrar_estrela", arguments: "Gigante Azul");
                }
            ),
            SpeedDialChild(
                child: Icon(CustomIconStar.stars5, color: Colors.white,),
                label: "Cadastrar gigante vermelha",
                labelBackgroundColor: Color.fromRGBO(64, 75, 96, 0.9),
                onTap: (){
                  Navigator.pushNamed(context, "/cadastrar_gigante_vermelha");
                }
            )
          ],
        );
  }
}
