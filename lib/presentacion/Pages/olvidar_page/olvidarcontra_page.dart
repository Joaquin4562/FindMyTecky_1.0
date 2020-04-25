import 'package:find_my_tecky_1_0/negocios/class/usuario.dart';
import 'package:find_my_tecky_1_0/negocios/util/pass_recover_utils.dart';
import 'package:find_my_tecky_1_0/negocios/util/user_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OlvidarcontraPage extends StatefulWidget {
  @override
  _OlvidarcontraPageState createState() => _OlvidarcontraPageState();
}

class _OlvidarcontraPageState extends State<OlvidarcontraPage> {
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black87,
        image: DecorationImage(
            image: AssetImage("assets/fondo.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 320),
          child: FloatingActionButton(
            onPressed: recoverPass,
            backgroundColor: Colors.blue,
            child: Center(
              child: Icon(Icons.send),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.grey.withOpacity(0.3),
              height: 200,
              width: 360,
              child: Padding(
                padding: const EdgeInsets.only(top: 45, left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: email,
                      autofocus: true,
                      cursorWidth: 2,
                      showCursor: true,
                      cursorColor: Colors.amber,
                      cursorRadius: Radius.circular(12),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Ingrese su correo electrónico',
                        labelText: 'Correo:',
                        helperStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        helperText:
                            'Solo usar correos con extensión @itsmante.edu.mx',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _evaluarCorreo(String correo) {
    RegExp exp = new RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");
    return exp.hasMatch(correo);
  }

  recoverPass() async {
    Usuario user = compareEmail(email.text);
    if (user != null && _evaluarCorreo(email.text) == true) {
      constructEmail("${user.nombre} ${user.apellidos}", user.correo);
      Fluttertoast.showToast(
        msg: "Se envio un Correo",
        backgroundColor: Colors.white,
        fontSize: 20,
        gravity: ToastGravity.TOP,
        textColor: Colors.black,
      );
      Navigator.pushReplacementNamed(context, "LoginPage");
    }
    else if(_evaluarCorreo(email.text) == false)
    {
      Fluttertoast.showToast(
        msg: "Formato de correo invalido",
        backgroundColor: Colors.white,
        fontSize: 20,
        gravity: ToastGravity.TOP,
        textColor: Colors.black,
      );
    } 
    else {
      Fluttertoast.showToast(
        msg: "Correo invalido",
        backgroundColor: Colors.white,
        fontSize: 20,
        gravity: ToastGravity.TOP,
        textColor: Colors.black,
      );
    }
    //validar email
  }
}
