import 'package:dio/dio.dart';
import 'package:find_my_tecky_1_0/negocios/class/direcctions.dart';
import 'package:find_my_tecky_1_0/negocios/providers/direcctions_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//Direcctions
String https = 'https://maps.googleapis.com/maps/api/directions/json?';
String apiKey = "AIzaSyCYR4k7DWQtRaQ8PE5UJJmrDYaUAaYYBos";
getDistance(LatLng origen, LatLng destino, DirectionsProvider provider) async {
  Dio dio = Dio();
  Response res = await dio.get(
    https +
      "origin=" +origen.latitude.toString() +"," +origen.longitude.toString() +
      "&destination=" +destino.latitude.toString() +"," +destino.longitude.toString() +
      "&key="+apiKey);
    Direcctions.formJsonMap(res.data, provider);
}
