import 'package:find_my_tecky_1_0/negocios/util/preferencias_de_usuario.dart';
import 'package:find_my_tecky_1_0/presentacion/utilities/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({Key key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}
///Crea el OnBoarding que ve el usuario al inicio
class _OnBoardingState extends State<OnBoarding> {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location location = new Location();
  @override
  void initState() { 
    super.initState();
    calcularUbicacion();
  }
  ///Da el número de páginas para el OnBoarding
  final int _numPages = 3;
  ///Inicializa la página
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }
  ///Da el tiempo y todo sobre el OnBoarding
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF000000),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF373630),
                Color(0xFF373630),
                Color(0xFF71706C),
                Color(0xFF71706C),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      final prefs = PreferenciasUsuario();
                      prefs.isFristUser = false;
                      Navigator.pushReplacementNamed(context, 'MenuPage');
                    },
                    child: Text(
                      'Saltar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height < 600 ? 400:550,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/marker.png',
                                ),
                                height: height < 600 ? 100:250,
                                width: height < 600 ? 100:250,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              '¿Dónde se encuentra?',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Con FindMyTecky podrás estar al tanto de la ubicación de tu transporte Escolar',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/not.png',
                                ),
                                height: height < 600 ? 100:240,
                                width: height < 600 ? 100:250,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'No te lo pierdas\nnosotros te avisamos',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Serán las notificaciones las que harán que te enteres si tu transporte se encuentra cerca de tu parada',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/bus.png',
                                ),
                                height: height < 600 ? 100:250,
                                width: height < 600 ? 100:250,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Una nueva experiencia\npara tomar el transporte',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: height < 600 ? 5.0:15.0),
                            Text(
                              'Marca tus paradas de transporte para recibir las notificaciones antes mencionadas',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Siguiente',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: height < 600 ? 70:80,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  final prefs = PreferenciasUsuario();
                  prefs.isFristUser = false;
                  Navigator.pushReplacementNamed(context, 'MenuPage');
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Comencemos',
                      style: TextStyle(
                        color: Color(0xFF005BA0),
                        fontSize: height < 600 ? 20:25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }

  void calcularUbicacion() async{
    final prefs = PreferenciasUsuario();
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        return;
      }
    }
    _permissionGranted = await location.hasPermission();

    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }
    location.getLocation().then((userLocation){
      prefs.latitudUser = userLocation.latitude;
      prefs.longitudUser = userLocation.longitude;
    });
  }
}
