import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Container(
            child: Text('CREA TU CUENTA'),
            alignment: Alignment.center,
          ),
          Column(
            children: <Widget>[
              _textfieldNombre(),
              _textfieldApellido(),
              _textfieldCorreo(),
              _textfieldContrasena(),
              _textfieldConfirma(),
              _crearcuentaGoogle(),
              _crearcuenta(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textfieldNombre() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Ingrese su nombre',
        labelText: 'Nombre:',
      ),
    );
  }

  Widget _textfieldApellido() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Ingrese su apellido',
        labelText: 'Apellido:',
      ),
    );
  }

  Widget _textfieldCorreo() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'Ingrese su correo electronico',
        labelText: 'Correo:',
        helperText: 'Solo usar correos con extension @itsmante.edu.mx',
      ),
    );
  }

  Widget _textfieldContrasena() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Ingrese su Contraseña',
          labelText: 'Contraseña:',
          suffixIcon: Icon(Icons.remove_red_eye)),
    );
  }

  Widget _textfieldConfirma() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Ingrese su Contraseña',
          labelText: 'Contraseña:',
          suffixIcon: Icon(Icons.remove_red_eye)),
    );
  }

  _crearcuentaGoogle() {
    return RaisedButton(
      child: Text('Crea sesión con Google'),
      elevation: (10),
      color: Colors.blue,
      textColor: Colors.white,
      shape: StadiumBorder(),
      onPressed: () {
        print('hola');
      },
    );
  }

  _crearcuenta() {

return RaisedButton(
      child: Text('Crea sesión'),
      elevation: (10),
      color: Colors.blue,
      textColor: Colors.white,
      shape: StadiumBorder(),
      onPressed: () {
        print('hola');
      },
    );

  }
}
