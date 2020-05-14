import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsProvider with ChangeNotifier{
  String _distancia;
  String _duracion;
  LatLngBounds _latLngBounds;
  String _polyline;
    get distancia{
      return _distancia;
    }
    set distancia(String distancia){
      this._distancia = distancia;
    }
    get duracion{
      return _duracion;
    }
    set duracion(String duracion){
      this._duracion = duracion;
    }
    get latLngBounds{
      return _latLngBounds;
    }
    set latLngBounds(LatLngBounds latLngBounds){
      this._latLngBounds = latLngBounds;
    }
    get polyline{
      return _polyline;
    }
    set polyline(String polilyne){
      this._polyline = polilyne;
    }
    
}