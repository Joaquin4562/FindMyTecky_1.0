import 'dart:async';
import 'package:find_my_tecky_1_0/negocios/util/preferencias_de_usuario.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ///Duración del tiempo 
    var _duration = new Duration(seconds: 3);
    ///Tiempo y duración en el cambio de pantalla
    Timer(_duration, _cambiarPantalla);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage("assets/fondo.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width - 160,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Find My Tecky",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
  ///Opcion para cambiar de pantalla entre el OnBoarding y el Menú
  void _cambiarPantalla(){
    final prefs = PreferenciasUsuario();
    if (prefs.isFristUser) {
      Navigator.of(context).pushReplacementNamed('OnBoarding');
    } else {
      if (!prefs.isLogged){
        Navigator.of(context).pushReplacementNamed('MenuPage');
      } else{
        Navigator.of(context).pushReplacementNamed('MapaPage');
      }
    }
  }
}
