class Usuario {

  static List<Usuario> users = new List<Usuario>();

  String nombre;
  String apellidos;
  String correo;
  String contrasena;

  Usuario({this.nombre, this.apellidos, this.correo, this.contrasena});

  Usuario.fromMap(Map<String, dynamic> map) {
    this.nombre = map['nombre'];
    this.apellidos = map['apellido'];
    this.correo = map['correo'];
    this.contrasena = map['contraseña'];
  }

}