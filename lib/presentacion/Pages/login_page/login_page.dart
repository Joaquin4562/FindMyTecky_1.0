import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //String  _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _inputCorreo(),
          Divider(),
          _inputContrasena(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _olvidarcontrasena(),
              
              _iniciarsesion(),
              _iniciargoogle(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputCorreo() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Ingrese su correo electronico',
        labelText: 'Correo:',
        helperText: 'Solo usar correos con extension @itsmante.edu.mx',
        icon: Icon(Icons.account_circle),
      ),
    );
  }

  Widget _inputContrasena() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Ingrese su Contraseña',
          labelText: 'Contraseña:',
          icon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.remove_red_eye)),
    );
  }

  Widget _iniciarsesion() {
    return RaisedButton(
      child: Text('Iniciar Sesión'),
      elevation: (10),
      color: Colors.blue,
      textColor: Colors.white,
      shape: StadiumBorder(),
      onPressed: () {
        print('hola');
      },
    );
  }

 Widget _iniciargoogle() {
    return RaisedButton(
      child: Text('Iniciar Sesión con Google'),
      elevation: (10),
      color: Colors.blue,
      textColor: Colors.white,
      shape: StadiumBorder(),
      onPressed: () {
        print('hola');
      },
    );
  }

  Widget _olvidarcontrasena() {
    return FlatButton(
      child: Text('¿Olvidaste tu contraseña?'),
      textColor: Color.fromRGBO(0, 91, 160, 1),
      onPressed: () {

        Navigator.pushNamed(context, 'OlvidarcontraPage');

      },
    );
  }
}
