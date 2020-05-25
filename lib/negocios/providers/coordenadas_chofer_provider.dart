import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoordenadasChoferProvider with ChangeNotifier{
  ///creo una variable de tipo Latitud y Longitud
  LatLng _coordenadas;
  ///Set de la variable Coordenadas dando los valores de latitud y longitud
  set coordenadas(LatLng coordenadas){
    ///Manda llamar la variable coordenadas de aqui para otorgarle la latitude y longitud
    this._coordenadas = LatLng(coordenadas.latitude, coordenadas.longitude);
    notifyListeners();
  }
  ///Get de la variable coordenadas
  get coordenadas{
    return _coordenadas;
  }

}