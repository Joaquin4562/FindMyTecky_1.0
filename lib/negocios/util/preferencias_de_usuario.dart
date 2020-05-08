
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
}