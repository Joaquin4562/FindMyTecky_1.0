
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }
  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs()async{
    this._prefs = await SharedPreferences.getInstance();
  }

  get isLogged{
    return _prefs.getBool('isLogged') ?? false;
  }
  set isLogged(bool value){
    _prefs.setBool('isLogged', value);
  }
  get isFristUser{
    return _prefs.getBool('isFristUser') ?? true;
  }
  set isFristUser(bool value){
    _prefs.setBool('isFristUser', value);
  }
  get documentUserID{
    return _prefs.getString('documentID') ?? '';
  }
  set documentUserID(String id){
    _prefs.setString('documentID', id);
  }
  get latitudP{
    return _prefs.getDouble('latitud') ?? 0.0;
  }
  set latitudP(double latitud){
    _prefs.setDouble('latitud', latitud);
  }
  get longitudP{
    return _prefs.getDouble('longitud') ?? 0.0;
  }
  set longitudP(double longitud){
    _prefs.setDouble('longitud', longitud);
  }

}