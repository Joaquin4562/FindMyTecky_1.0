import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoordenadasChoferProvider with ChangeNotifier{
  LatLng _coordenadas;
  set coordenadas(LatLng coordenadas){
    this._coordenadas = LatLng(coordenadas.latitude, coordenadas.longitude);
    notifyListeners();
  }
  get coordenadas{
    return _coordenadas;
  }

}