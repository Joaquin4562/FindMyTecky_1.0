import 'package:find_my_tecky_1_0/negocios/providers/coordenadas_chofer_provider.dart';
import 'package:find_my_tecky_1_0/negocios/util/preferencias_de_usuario.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/login_page/login_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/mapa_page/mapa_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/menu_page/menu_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/olvidar_page/olvidarcontra_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/onboarding/onboarding.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/register_page/register_page.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'negocios/providers/direcctions_provider.dart';
import 'negocios/providers/directions_provider_2.dart';


void main() async {
  final prefs = PreferenciasUsuario();
  WidgetsFlutterBinding.ensureInitialized();
  await prefs.initPrefs();
  prefs.rutaActual = 'Centro';
  print('Frist user?'+prefs.isFristUser.toString());
  print('Logged?'+prefs.isLogged.toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => CoordenadasChoferProvider(),),
        ChangeNotifierProvider(builder: (context) => DirectionsProvider(),),
        ChangeNotifierProvider(builder:(context) => DirectionProviderApi()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        //CONEXION DE PANTALLAS
        routes: <String, WidgetBuilder>{
          'LoginPage': (BuildContext context) => LoginPage(),
          'RegisterPage': (BuildContext context) => RegisterPage(),
          'RecuperarPage': (BuildContext context) => OlvidarcontraPage(),
          'MenuPage': (BuildContext context) => MenuPage(),
          'OnBoarding': (BuildContext context) => OnBoarding(),
          'MapaPage': (context) => MapaPage()
        },
        title: 'FindMyTecky!',
        home: SplashScreen(),
      ),
    );
  }
}
