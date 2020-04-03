import 'package:find_my_tecky_1_0/negocios/class/simple_animation.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black87,
        image: DecorationImage(
            image: AssetImage("assets/fondo.png"), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 10, right: 10),
            child: FadeAnimation(
                1,
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/logo.png"))),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Find My Tecky',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: FadeAnimation(
                1,
                Container(
                  height: MediaQuery.of(context).size.height - 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Bienvenido a Find My Tecky!',
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                      Column(
                        children: <Widget>[
                          _ingresarLog(context),
                          Divider(
                            height: 30,
                            thickness: 2,
                            color: Colors.white,
                            indent: 20,
                            endIndent: 20,
                          ),
                          _crearCuenta()
                        ],
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    ));
  }

  Widget _ingresarLog(context) {
    return Container(
      height: 60,
      width: 400,
      child: FlatButton(
        child: Text(
          'Iniciar sesión',
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'LoginPage');
        },
      ),
    );
  }

  Widget _crearCuenta() {
    return Container(
      height: 60,
      width: 400,
      child: FlatButton(
        child: Text(
          'Crear cuenta',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'RegisterPage');
        },
      ),
    );
  }
}
