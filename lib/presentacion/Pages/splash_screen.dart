import 'dart:async';

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
    var _duration = new Duration(seconds: 5);
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
                  width: width-160,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), 
                    image: DecorationImage(
                      image: AssetImage("assets/logo.png"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(height: 50,),
            Text(
              "Find My Tecky",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),
              )
          ],
        ),
      ),
    );
  }

  void _cambiarPantalla() {
    Navigator.of(context).pushReplacementNamed('MenuPage');
  }
}
