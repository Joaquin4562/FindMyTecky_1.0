import 'dart:async';

import 'package:find_my_tecky_1_0/negocios/util/admob_utils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  InterstitialAd newTripAd;
  @override
  void initState() { 
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    newTripAd= getNewTripInterstitialAd()..load();
      
    
  }
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(22.7433, -98.9747 ),
      zoom: 12 );
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: null),
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
                      onTap: () {},
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
            initialCameraPosition: _initialPosition,
            onMapCreated: _onMapCreated,
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

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
}
