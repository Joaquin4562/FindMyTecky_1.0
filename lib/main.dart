import 'package:find_my_tecky_1_0/presentaci%C3%B3n/menu_page/menu_page.dart';
import 'package:find_my_tecky_1_0/presentaci%C3%B3n/olvidar_page/olvidarcontra_page.dart';
import 'package:flutter/material.dart';

import 'presentación/login_page/login_page.dart';
import 'presentación/register_page/register_page.dart';
  
 void main() => runApp(MyApp());
  
 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       //CONEXION DE PANTALLAS 
       routes: <String,WidgetBuilder>{
         'LoginPage':(BuildContext context)=> LoginPage(),
        'RegisterPage':(BuildContext context)=> RegisterPage(),
        'OlvidarcontraPage': (BuildContext context)=> OlvidarcontraPage(),
       },
       title: 'FindMyTecky!',
       home: MenuPage(),
     );
   }
 }