import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:find_my_tecky_1_0/datos/get_users.dart';

import 'package:find_my_tecky_1_0/negocios/class/usuario.dart';

void getAllUsers() {
  Usuario user;
  Future<QuerySnapshot> userDocuments = getUsers().then((QuerySnapshot snapshot){
    snapshot.documents.forEach((rawUser){
      user = Usuario.fromMap(rawUser.data);
      Usuario.users.add(user);
    });
  });
}