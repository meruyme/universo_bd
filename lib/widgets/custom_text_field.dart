import 'package:flutter/material.dart';

class custom_text_field extends StatefulWidget {

  String label;
  TextEditingController controller = TextEditingController();
  TextInputType textInputType;
  bool isPassword;

  custom_text_field({this.label, this.controller, this.textInputType, this.isPassword});

  @override
  _custom_text_fieldState createState() => _custom_text_fieldState();
}

class _custom_text_fieldState extends State<custom_text_field> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: new ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          hintColor: Colors.white
        ),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword,
          decoration: new InputDecoration(
            labelText: widget.label,

            //filled: true,
            fillColor: Colors.white,

            enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(
                  color: Colors.white
              ),
            ),

            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(
                color: Colors.white
              ),
            ),
            //fillColor: Colors.green
          ),
          /*validator: (val) {
            if(val.length==0) {
              return "Email cannot be empty";
            }else{
              return null;
            }
          },*/
          keyboardType: widget.textInputType,
          style: new TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
          ),
        )
    );
  }
}
