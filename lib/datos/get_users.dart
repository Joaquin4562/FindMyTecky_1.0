import 'package:cloud_firestore/cloud_firestore.dart';

// fetchUsers() {
//   try {
//     final databaseReference = Firestore.instance;
//     databaseReference.collection('Usuarios').getDocuments().then((QuerySnapshot snapshot){
//       snapshot.documents.forEach((snapshot) {
//         print(snapshot.data);
//       });
//       return snapshot.documents;
//     });
//   } catch (e) {
//   }
// }
///Obtiene los datos del usuario
Future<QuerySnapshot> getUsers() {
  final databaseReference = Firestore.instance;
  return databaseReference.collection('Usuarios').getDocuments();
}