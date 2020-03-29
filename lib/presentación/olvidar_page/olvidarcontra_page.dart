import 'package:flutter/material.dart';

class OlvidarcontraPage extends StatefulWidget {
  @override
  _OlvidarcontraPageState createState() => _OlvidarcontraPageState();
}

class _OlvidarcontraPageState extends State<OlvidarcontraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Container(
            child: Text('¿Haz perdido tu contraseña?'),
            alignment: Alignment.center,
          ),
          Column(
            children: <Widget>[
              _corre(),
              _validar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _corre() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Ingrese su correo',
        labelText: 'Correo',
      ),
    );
  }

  Widget _validar() {
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(0, 91, 160, 100),
      child: Icon(Icons.send),
      onPressed: () {
        
      },
    );
  }
}
