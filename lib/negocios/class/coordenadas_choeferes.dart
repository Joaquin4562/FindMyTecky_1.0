import 'package:find_my_tecky_1_0/negocios/providers/coordenadas_chofer_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoordenadasChoferes{
  double _latitud;
  double _longitud;
  CoordenadasChoferes(this._latitud,this._longitud);

  get latitud{
    return _latitud;
  }
  get longitud{
    return _longitud;
  }
  CoordenadasChoferes.formJsonMap(Map<dynamic,dynamic> json, CoordenadasChoferProvider provider){
    _latitud   = double.parse(json['latitud']);
    _longitud  = double.parse(json['longitud']);
    provider.coordenadas = LatLng(_latitud, _longitud);
    print(provider.coordenadas);
  }
}