class Usuario {

  static List<Usuario> users = new List<Usuario>();
  ///Guarda el nombre del
  String nombre;
  ///Guarda el apellido del usuario
  String apellidos;
  ///Guarda el correo del usuario
  String correo;
  ///Guarda la contraseña del usuario
  String contrasena;

  ///Manda a llamar el método con todos los valores
  Usuario({this.nombre, this.apellidos, this.correo, this.contrasena});

  ///Metodo para darle los valores a las variables 
  Usuario.fromMap(Map<String, dynamic> map) {
    this.nombre = map['nombre'];
    this.apellidos = map['apellido'];
    this.correo = map['correo'];
    this.contrasena = map['contraseña'];
  }

}