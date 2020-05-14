import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_my_tecky_1_0/negocios/class/coordenadas_choeferes.dart';
import 'package:find_my_tecky_1_0/negocios/providers/coordenadas_chofer_provider.dart';

Firestore db = Firestore.instance;
CoordenadasChoferes coordenadasChoferes;

obtenerCoordenadasChofer(String ruta, CoordenadasChoferProvider coordenadasChoferProvider) async{
  await db.collection('Transportes').document(ruta).get().then((value){
    coordenadasChoferes = CoordenadasChoferes.formJsonMap(value.data, coordenadasChoferProvider);
  });
}
