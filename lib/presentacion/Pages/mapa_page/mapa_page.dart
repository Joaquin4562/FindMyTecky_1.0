import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:find_my_tecky_1_0/negocios/util/admob_utils.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/login_page/login_page.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);
  final LatLng estudianteUsuario = LatLng(22.7552224, -98.9742958);
  final LatLng choferTecky = LatLng(22.7523476, -98.9709782);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  InterstitialAd newTripAd;
  LatLng locationMante = LatLng(22.7433, -98.9747);
  GoogleMapController _mapController;
  Location location = new Location();
  Marker marker;
  Circle circle;
  BitmapDescriptor markerUsuarioIcon;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    newTripAd = getNewTripInterstitialAd()..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.nature),
          elevation: 30,
          onPressed: () {
            _centerView();
          }),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black45,
        title: Text(
          'Find My Tecky',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        elevation: 10,
        child: Container(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black87,
                image: DecorationImage(
                    image: AssetImage('assets/fondo.png'), fit: BoxFit.cover)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                DrawerHeader(
                  child: Container(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.cover)),
                ),
                ListTile(
                  title: Text(
                    'Rotaria',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onTap: () {
                    newTripAd
                      ..load()
                      ..show(
                          anchorOffset: 0.0,
                          anchorType: AnchorType.bottom,
                          horizontalCenterOffset: 0.0);
                  },
                  trailing: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                ListTile(
                  title: Text(
                    'Centro',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onTap: () {
                    newTripAd
                      ..load()
                      ..show(
                          anchorOffset: 0.0,
                          anchorType: AnchorType.bottom,
                          horizontalCenterOffset: 0.0);
                  },
                  trailing: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                ListTile(
                  title: Text(
                    'Linares',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onTap: () {
                    newTripAd
                      ..load()
                      ..show(
                          anchorOffset: 0.0,
                          anchorType: AnchorType.bottom,
                          horizontalCenterOffset: 0.0);
                  },
                  trailing: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ListTile(
                      title: Text(
                        'Cerrar sesión',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onTap: () {
                        signOutGoogle();
                        Navigator.pushReplacementNamed(context, 'LoginPage');
                      },
                      trailing: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView(
          itemExtent: MediaQuery.of(context).size.height * 1.2,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: locationMante,
                      zoom: 6,
                    ),
                    markers: _markersUsuarioChofer(),
                    onMapCreated: _onMapaCreated,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(
                        () => new EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                  ),
                ),
              ],
            )
          ]),
    );
  }

  void iconoMarker() async {
    markerUsuarioIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.0), 'assets/iconCR.png');
  }

  Set<Marker> _markersUsuarioChofer() {
    var temporal = Set<Marker>();

    temporal.add(Marker(
        markerId: MarkerId("PuntoEstudiante"),
        icon: markerUsuarioIcon,
        position: widget.estudianteUsuario,
        infoWindow: InfoWindow(title: "Posición Actual")));

    temporal.add(Marker(
        markerId: MarkerId("puntoTecky"),
        position: widget.choferTecky,
        infoWindow: InfoWindow(title: "TECKY")));
    return temporal;
  }

  void _onMapaCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _centerView();
    });
  }

//Método que se ajusta para que se vean los 2 puntos
  _centerView() async {
    await _mapController.getVisibleRegion();
//Cálculo los 4 puntos cardinales
    var posicionIzquierda =
        min(widget.estudianteUsuario.latitude, widget.choferTecky.latitude);
    var posicionDerecha =
        max(widget.estudianteUsuario.latitude, widget.choferTecky.latitude);
    var posicionArriba =
        max(widget.estudianteUsuario.longitude, widget.choferTecky.longitude);
    var posicionAbajo =
        min(widget.estudianteUsuario.longitude, widget.choferTecky.longitude);

    var bounds = LatLngBounds(
        southwest: LatLng(posicionIzquierda, posicionAbajo),
        northeast: LatLng(posicionDerecha, posicionArriba));
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
  }
}
