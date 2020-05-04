import 'dart:async';
import 'dart:math';

import 'package:find_my_tecky_1_0/negocios/util/admob_utils.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/login_page/login_page.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);
  final LatLng estudianteUsuario = LatLng (22.7552224, -98.9742958);
  final LatLng choferTecky = LatLng(22.7523476, -98.9709782);
  final LatLng locationMante = LatLng(22.7433, -98.9747);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  InterstitialAd newTripAd;
  

  GoogleMapController _mapController;
  Location _locationTracker = Location();
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  Marker marker;
  Circle circle;
  StreamSubscription _locationSubscription;
  BitmapDescriptor markerUsuarioIcon;

  @override
  void initState() { 
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    newTripAd= getNewTripInterstitialAd()..load();
  }
  
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {

      floatingActionButton:  FloatingActionButton (
              child: Icon(Icons.nature),
              elevation: 30,
              onPressed: () {
                _centerView();
                }
              );

    return Scaffold(
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
                    newTripAd..load()
                    ..show(
                      anchorOffset: 0.0,
                      anchorType: AnchorType.bottom,
                      horizontalCenterOffset: 0.0
                    );
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
                  onTap: () {},
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
                  onTap: () {},
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
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition : CameraPosition(
            target: widget.locationMante,
            zoom: 5, 
            ), 
            markers: _markersUsuarioChofer(), 
            onMapCreated: _onMapaCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              title: Text(
                'Find My Tecky',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              elevation: 0,
            ),
          )
        ],
      ),
    );
  }

              void iconoMarker() async {
                markerUsuarioIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 3.0), 'assets/iconCR.png');
              }

              Set<Marker> _markersUsuarioChofer ()  {
              var temporal = Set<Marker>();

              temporal.add(
              Marker(
              markerId: MarkerId("PuntoEstudiante"),
              icon: markerUsuarioIcon,
              position: widget.estudianteUsuario,
              infoWindow: InfoWindow(title: "Posición Actual")
              ));

               temporal.add(Marker(
                markerId: MarkerId("puntoTecky"),
                position: widget.choferTecky,
              infoWindow: InfoWindow(title: "TECKY")
              ));
              return temporal;
             
      }

              void _onMapaCreated (GoogleMapController controller){
              setState(() {
                _mapController = controller;
                
                _centerView();
              });
            }

//Método que se ajusta para que se vean los 2 puntos
            _centerView () async{
              await _mapController.getVisibleRegion();
//Cálculo los 4 puntos cardinales
            var posicionIzquierda = min(widget.estudianteUsuario.latitude, widget.choferTecky.latitude);
            var posicionDerecha = max(widget.estudianteUsuario.latitude, widget.choferTecky.latitude);
            var posicionArriba = max(widget.estudianteUsuario.longitude, widget.choferTecky.longitude);
            var posicionAbajo = min(widget.estudianteUsuario.longitude, widget.choferTecky.longitude);
            
            var bounds = LatLngBounds(
              southwest: LatLng(posicionIzquierda, posicionAbajo),
              northeast: LatLng(posicionDerecha, posicionArriba)
              );
            var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
              _mapController.animateCamera(cameraUpdate);
            }


  
}
