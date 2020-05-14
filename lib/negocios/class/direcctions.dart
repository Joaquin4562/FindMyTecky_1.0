import 'package:find_my_tecky_1_0/negocios/providers/direcctions_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Direcctions{

  String distancia;
  String duracion;
  LatLngBounds bounds;
  String polilyne;
  LatLng northeast;
  LatLng southwest;
  Direcctions(this.duracion,this.distancia);

  Direcctions.formJsonMap(json, DirectionsProvider provider){
    //Distancia y duracion
    double dis  = double.parse(json['routes'][0]['legs'][0]['distance']['value'].toString())/1000;
    distancia   = dis.toString()+"km";
    duracion    = json['routes'][0]['legs'][0]['duration']['text'].toString();
    //Bounds para enfocar el mapa
    double latN = double.parse(json['routes'][0]['bounds']['northeast']['lat'].toString());
    double lngN = double.parse(json['routes'][0]['bounds']['northeast']['lng'].toString());
    northeast   = LatLng(latN, lngN);
    double latS = double.parse(json['routes'][0]['bounds']['southwest']['lat'].toString());
    double lngS = double.parse(json['routes'][0]['bounds']['southwest']['lng'].toString());
    southwest   = LatLng(latS, lngS);
    bounds      = LatLngBounds(northeast: northeast, southwest: southwest);
    //Polilynes para trazar el mapa
    polilyne    = json['routes'][0]['overview_polyline']['points'].toString();
    //Mandar datos al provider
    provider.distancia = distancia;
    provider.duracion  = duracion;
    provider.polyline = polilyne;
    provider.latLngBounds = bounds;
    print('DISTANCIA:'+distancia);
    print('DURACION:'+duracion);
    print('POLILYNES:'+polilyne);
    print('LATN:'+latN.toString());
    print('LNTN:'+lngN.toString());
    print('LATS:'+latS.toString());
    print('LNTS:'+lngS.toString());
  }
}