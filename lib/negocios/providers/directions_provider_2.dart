import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:google_maps_webservice/directions.dart';

class DirectionProviderApi extends ChangeNotifier {
  GoogleMapsDirections directionsApi =
      GoogleMapsDirections(apiKey: "AIzaSyCYR4k7DWQtRaQ8PE5UJJmrDYaUAaYYBos");

  Set<maps.Polyline> _route = Set();
  Set<maps.Polyline> get currentRoute => _route;
  String _distance;
  String get distance =>_distance;
  String _duration;
  String get duration => _duration;
  findDirections(maps.LatLng from, maps.LatLng to) async {
    var origin = Location(from.latitude, from.longitude);
    var destination = Location(to.latitude, to.longitude);

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

      leg.steps.forEach((step) {
        points.add(maps.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(maps.LatLng(step.endLocation.lat, step.endLocation.lng));
      });

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