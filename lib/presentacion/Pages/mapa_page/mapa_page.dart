import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_my_tecky_1_0/negocios/providers/coordenadas_chofer_provider.dart';
import 'package:find_my_tecky_1_0/negocios/providers/directions_provider_2.dart';
import 'package:find_my_tecky_1_0/negocios/util/preferencias_de_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:find_my_tecky_1_0/negocios/util/admob_utils.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/login_page/login_page.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  InterstitialAd newTripAd;
  ///Variable que guarda el metodo preferencias de usuario
  final prefs = PreferenciasUsuario();
  ///Variable instancia la Referencia de la base de datos
  final databaseReference = Firestore.instance;
  ///Localización del Mante
  LatLng locationMante = LatLng(22.7433, -98.9747);
  ///Variable de GoogleMapController
  GoogleMapController _mapController;
  ///Variable de Location
  Location location = new Location();
  TextEditingController _controllerTime = TextEditingController();
  ///Tiempo
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _picker;
  bool _addMarkerEnabled = false;
  ///Variable de las markerss
  var _markers = Set<Marker>();
  ///Latitud y longitud del Usuario
  LatLng estudianteUsuario = LatLng(22.726189, -98.968277);
  ///Latitud y Longitud del Chofer
  LatLng choferTecky;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    newTripAd = getNewTripInterstitialAd()..load();
  }

  @override
  Widget build(BuildContext context) {
    final coordenadasChoferProvider =
        Provider.of<CoordenadasChoferProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.adjust,size: 35,),
          elevation: 10,
          backgroundColor: Colors.black54,
          onPressed: () {
            _centerView(choferTecky, estudianteUsuario);
          }),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black45,
        title: _title(prefs.rutaActual),
        elevation: 5,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.alarm_add),
            onPressed: (){
              showDialog(
                        context: _scaffoldKey.currentContext,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    //TODO: CALCULAR NOTIFICACIÓN
                                  },
                                  child: Text('Aceptar'))
                            ],
                            title: Text('IMPORTANTE'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Seleccione una hora'),
                                TextField(
                                  controller: _controllerTime,
                                  autofocus: false,
                                  onTap: (){
                                    selectedTime(context);
                                  },
                                )
                              ],
                            )
                          );
                        });
            }
          )
        ],
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
                _listTile(
                    "Rotaria", coordenadasChoferProvider),
                Divider(
                  color: Colors.white,
                ),
                _listTile(
                    'Centro', coordenadasChoferProvider),
                Divider(
                  color: Colors.white,
                ),
                _listTile(
                    'Linares', coordenadasChoferProvider),
                Divider(
                  color: Colors.white,
                ),
                ListTile(
                  title: Text(
                    'Añadir Parada',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onTap: () {
                    newTripAd = getNewTripInterstitialAd()..load();
                    showInterstitialAd(newTripAd);
                    _addMarkerEnabled = true;
                    showDialog(
                        context: _scaffoldKey.currentContext,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Aceptar'))
                            ],
                            title: Text('AVISO'),
                            content: Text(
                                'Para añadir una parada selecciona un lugar en el mapa'),
                          );
                        });
                  },
                  trailing: Icon(
                    Icons.add_location,
                    color: Colors.amber,
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
                        prefs.isLogged = false;
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
      body: StreamBuilder(
          stream: databaseReference.collection('Transportes').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: SpinKitDoubleBounce(color: Colors.red,));
            return ListView(
                itemExtent: MediaQuery.of(context).size.height * 1.2,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          onTap: _addMarker,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: locationMante,
                            zoom: 6,
                          ),
                          ///Markers
                          markers: _markersUsuarioChofer(
                              snapshot.data.documents[prefs.rutaActual]),
                          myLocationEnabled: true,
                          onMapCreated: _onMapaCreated,
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>[
                            new Factory<OneSequenceGestureRecognizer>(
                              () => new EagerGestureRecognizer(),
                            ),
                          ].toSet(),
                        ),
                      ),
                    ],
                  )
                ]);
          }),
    );
  }
  ///Metodo para el Marker
  Set<Marker> _markersUsuarioChofer(snapshot) {
    final choferTeckyCoordenadas =
        Provider.of<CoordenadasChoferProvider>(context);
    final posicionTeky = LatLng(
        double.parse(snapshot['latitud']), double.parse(snapshot['longitud']));
    choferTeckyCoordenadas.coordenadas = posicionTeky;
    choferTecky = posicionTeky;
    final markers = Set<Marker>();
    markers.add(Marker(
        markerId: MarkerId("PuntoEstudiante"),
        position: estudianteUsuario,
        infoWindow: InfoWindow(title: "Posición Actual")));

    markers.add(Marker(
        markerId: MarkerId("puntoTecky"),
        position: posicionTeky,
        onTap: mostrarBottomSheet,
        infoWindow: InfoWindow(title: "TECKY")));
    if (prefs.latitudP != 0.0) {
      markers.add(Marker(
          markerId: MarkerId('parada'),
          position: LatLng(prefs.latitudP, prefs.longitudP),
          infoWindow: InfoWindow(title: 'PARADA')));
      _addMarkerEnabled = false;
    }
    _markers = markers;
    return markers;
  }

///Crea el controller de GoogleMapController
  void _onMapaCreated(GoogleMapController controller) {
    _mapController = controller;
    _centerView(choferTecky, estudianteUsuario);
  }

  ///Método que se ajusta para que se vean los 2 puntos
  _centerView(chofer, estudiante) async {
    final api = Provider.of<DirectionProviderApi>(context);
    await _mapController.getVisibleRegion();
    ///Cálculo los 4 puntos cardinales
    await api.findDirections(chofer, estudiante);

    double posicionIzquierda = min(estudiante.latitude, chofer.latitude);
    double posicionDerecha = max(estudiante.latitude, chofer.latitude);
    double posicionArriba = max(estudiante.longitude, chofer.longitude);
    double posicionAbajo = min(estudiante.longitude, chofer.longitude);
    var bounds = LatLngBounds(
        southwest: LatLng(posicionIzquierda, posicionAbajo),
        northeast: LatLng(posicionDerecha, posicionArriba));
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 80);
    _mapController.animateCamera(cameraUpdate);
  }

///Manda la parada nueva
  void _mandarParada(LatLng latLngParada) async {
    final documentID = prefs.documentUserID;
    prefs.latitudP = latLngParada.latitude;
    prefs.longitudP = latLngParada.longitude;
    await databaseReference
        .collection("Usuarios")
        .document(documentID)
        .updateData({
      'Parada': {
        'latitud': latLngParada.latitude,
        'longitud': latLngParada.longitude
      }
    });
  }

///Añade el parker con la parada que agregaste
  void _addMarker(LatLng latLngParada) {
    if (_addMarkerEnabled) {
      LatLng _parada = latLngParada;
      ///manda cordenadas de la parada a firestore
      _mandarParada(latLngParada);
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('parada'),
            position: _parada,
            infoWindow: InfoWindow(title: 'PARADA')));
        _addMarkerEnabled = false;
        ///Reactiva la publicidad
        newTripAd = getNewTripInterstitialAd()..load();
      });
    }
  }

  Widget _listTile(
      String ruta,
      CoordenadasChoferProvider coordenadasChoferProvider ) {
    return ListTile(
      title: Text(
        ruta,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      onTap: () async {
        if (ruta == "Centro") {
          prefs.rutaActual = 0;
        } else if (ruta == "Rotaria") {
          prefs.rutaActual = 2;
        } else {
          prefs.rutaActual = 1;
        }
        newTripAd = getNewTripInterstitialAd()..load();
        Navigator.pushReplacementNamed(context, 'MapaPage');
      },
      trailing: Icon(
        Icons.location_on,
        color: Colors.white,
      ),
    );
  }

  void mostrarBottomSheet() {
    final api = Provider.of<DirectionProviderApi>(context);
    String distancia;
    String duracion;
    if (api.distance == null) {
      distancia = "unknow";
      duracion = "unknow";
    } else {
      distancia = api.distance;
      duracion = api.duration;
    }
    _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            ListTile(
              dense: true,
              title: Text(
                'Distancia: ' + distancia,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              dense: true,
              title: Text(
                'Tiempo: ' + duracion,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _title(rutaActual) {
    String title;
    if (rutaActual == 0) {
      title = "CENTRO";
    } else if (rutaActual == 1) {
      title = "LINARES";
    } else {
      title = "ROTARIA";
    }
    return Text(
      '$title',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
  ///Selecciona el tiempo
  Future<Null> selectedTime(BuildContext context) async{
    _picker = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if(_picker != null){
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formatedTime = localizations.formatTimeOfDay(_picker,alwaysUse24HourFormat: false);
      setState(() {
        _controllerTime.text = formatedTime;
      });
    }
  }
}
