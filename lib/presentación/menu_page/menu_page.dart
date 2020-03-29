import 'package:flutter/material.dart';



class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _ingresarLog(context),
            Divider(),
            _crearCuenta(),
          ],
        ),
      ),
    );
  }

  Widget _ingresarLog(context) {
    return FlatButton(
      child: Text('Iniciar sesión'),
      onPressed: () {
      Navigator.pushNamed(context, 'LoginPage');
      },
    );
  }

  Widget _crearCuenta() {
    return FlatButton(
      child: Text('Crear cuenta'),
      onPressed: () {
        Navigator.pushNamed(context, 'RegisterPage');
      },
    );
  }
}
