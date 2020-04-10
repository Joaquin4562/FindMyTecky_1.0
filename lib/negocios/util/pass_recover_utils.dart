import 'package:find_my_tecky_1_0/datos/send_email.dart';
import 'package:find_my_tecky_1_0/negocios/class/usuario.dart';

const String subject = 'Recuperación de contraseña @FindMyTecky';
const String link = '[link]';

constructEmail(String name, String recipient) {
  String text = '''
Hola $name, se solicitó un cambio de contraseña en tu cuenta.
Para hacerlo accede al siguiente enlace:

$link

Si no reconoces esta actividad haz caso omiso a este correo.
  ''';

  return sendEmail(recipient, subject, text);

}

Usuario compareEmail(String email) {
  for (var user in Usuario.users) {
    if (user.correo == email) {
      return user;
    }
  }
  return null;
}