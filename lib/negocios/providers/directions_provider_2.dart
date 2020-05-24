
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:google_maps_webservice/directions.dart';

class DirectionProviderApi extends ChangeNotifier {
  ///Direccion del API de google maps
  GoogleMapsDirections directionsApi =
      GoogleMapsDirections(apiKey: "AIzaSyCYR4k7DWQtRaQ8PE5UJJmrDYaUAaYYBos");

  ///variable de tipo Polyne maps
  Set<maps.Polyline> _route = Set();
  ///optiene la ruta actual
  Set<maps.Polyline> get currentRoute => _route;
  ///Variable que optiene la disancia
  String _distance;
  ///Le da el valor de la distancia a la variable
  String get distance =>_distance;
  ///Variable que guarda la duración
  String _duration;
  ///Le da el valor de la duración a la variable 
  String get duration => _duration;
  ///método para buscar las direcciones 
  findDirections(maps.LatLng from, maps.LatLng to) async {
    ///En una variable guarda la dirección original
    var origin = Location(from.latitude, from.longitude);
    ///En una variable que guarda la dirección de destino 
    var destination = Location(to.latitude, to.longitude);
    ///En la variable guarda las direcciones de origen y destino y traza un linea con el tiempo
    var result = await directionsApi.directionsWithLocation(
      origin,
      destination,
      travelMode: TravelMode.driving,
    );

    Set<maps.Polyline> newRoute = Set();
    if (result.isOkay) {
      var route = result.routes[0];
      var leg = route.legs[0];
      this._distance = leg.distance.text;
      this._duration = leg.duration.text;
      List<maps.LatLng> points = [];

      ///Añade los puntos al mapa 
      leg.steps.forEach((step) {
        points.add(maps.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(maps.LatLng(step.endLocation.lat, step.endLocation.lng));
      });

      ///Añade la línea con los puntos, da el color y el ancho
      var line = maps.Polyline(
        points: points,
        polylineId: maps.PolylineId("mejor ruta"),
        color: Colors.red,
        width: 4,
      );
      newRoute.add(line);


      _route = newRoute;
      notifyListeners();
    } else {
      print("ERRROR !!! ${result.status}");
    }
  }
}