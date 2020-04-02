import 'package:find_my_tecky_1_0/presentacion/Pages/login_page/login_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/menu_page/menu_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/olvidar_page/olvidarcontra_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/register_page/register_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //CONEXION DE PANTALLAS
      routes: <String, WidgetBuilder>{
        'LoginPage': (BuildContext context) => LoginPage(),
        'RegisterPage': (BuildContext context) => RegisterPage(),
        'RecuperarPage': (BuildContext context) => OlvidarcontraPage(),
        'MenuPage': (BuildContext context) => MenuPage(),
      },
      title: 'FindMyTecky!',
      home: SplashScreen(),
    );
  }
}
