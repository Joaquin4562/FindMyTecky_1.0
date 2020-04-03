import 'package:find_my_tecky_1_0/negocios/class/simple_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_my_tecky_1_0/datos/send_email.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final databaseReference = Firestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final correoController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    correoController.dispose();
    password1Controller.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black87,
        image: DecorationImage(
            image: AssetImage("assets/fondo.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
              child: FadeAnimation(
                  1,
                  Container(
                    height: screenSize.height < 600
                        ? screenSize.height + 50
                        : screenSize.height - 100,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Crea una cuenta',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                _textfieldNombre(),
                                _textfieldApellido(),
                                _textfieldCorreo(),
                                _textfieldContrasena(),
                                _textfieldConfirma()
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          _textCondiciones(),
                          SizedBox(
                            height: 30,
                          ),
                          _btnRegistrarse(context),
                        ],
                      ),
                    ),
                  )),
            ),
          );
        }),
      ),
    );
  }

  Widget _textfieldNombre() {
    return TextField(
      controller: nombreController,
      style: TextStyle(
        color: Colors.white,
      ),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: 'Ingrese su nombre',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelText: 'Nombre:',
      ),
    );
  }

  Widget _textfieldApellido() {
    return TextField(
      controller: apellidoController,
      style: TextStyle(
        color: Colors.white,
      ),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: 'Ingrese su apellido',
        labelText: 'Apellido:',
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }

  Widget _textfieldCorreo() {
    return TextField(
      controller: correoController,
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        helperStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: 'Ingrese su correo electrónico',
        labelText: 'Correo:',
        helperText: 'Solo usar correos con extensión @itsmante.edu.mx',
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }

  Widget _textfieldContrasena() {
    return TextField(
      controller: password1Controller,
      style: TextStyle(
        color: Colors.white,
      ),
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: 'Ingrese su Contraseña',
        labelText: 'Contraseña:',
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          child: (_isObscure ? _iconOn() : _iconOff()),
        ),
      ),
    );
  }

  Widget _textfieldConfirma() {
    return TextField(
      controller: password2Controller,
      style: TextStyle(
        color: Colors.white,
      ),
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: 'Ingrese su Contraseña',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        labelText: 'Contraseña:',
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          child: (_isObscure ? _iconOn() : _iconOff()),
        ),
      ),
    );
  }

  Widget _iconOn() {
    return Icon(
      Icons.visibility,
      color: Colors.white,
    );
  }

  Widget _iconOff() {
    return Icon(
      Icons.visibility_off,
      color: Colors.white,
    );
  }

  Widget _textCondiciones() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(text: 'Al registratse aceptas las  '),
        TextSpan(
            text: 'Condiciones de servicio ',
            style: new TextStyle(color: Colors.blue),
            recognizer: new TapGestureRecognizer()..onTap = () {}),
        TextSpan(text: 'y la'),
        TextSpan(
            text: ' Política de privaciada ',
            style: new TextStyle(color: Colors.blue),
            recognizer: new TapGestureRecognizer()..onTap = () {}),
        TextSpan(text: 'de Find My Tecky.'),
      ]),
    );
  }

  Widget _btnRegistrarse(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 0,
            offset: Offset(0, 4.0))
      ]),
      child: RaisedButton(
        child: Text(
          'Registrate',
          style: TextStyle(fontSize: 16),
        ),
        elevation: (10),
        color: Color.fromRGBO(32, 173, 244, 1),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: (){
          if(nombreController.text != '' && apellidoController.text != '' && correoController.text != '' && password1Controller.text != '' && password2Controller.text != '')
          {
            if(password2Controller.text == password1Controller.text)
            {
              if(_evaluarCadena(nombreController.text) == true && _evaluarCadena(apellidoController.text) == true)
              {
                if(_evaluarPassword(password1Controller.text) == true)
                {
                  if(_evaluarCorreo(correoController.text) == true)
                  {
                    registrar(context);
                  }
                } else {
                  _showSnackBar(context,
                      'Recuerda que la contraseña debe tener al entre 8 y 16 caracteres, al menos un dígito, al menos una minúscula y al menos una mayúscula.Puede tener otros símbolos.', Icons.error,Colors.red);
                }
              } else {
                _showSnackBar(context, "el nombre es invalido", Icons.error,Colors.red);
              }
            } else {
              _showSnackBar(context, "las contraseñas no coinciden", Icons.error,Colors.red);
            }
          }
        },
      ),
    );
  }

  registrar(context) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: correoController.text, password: password1Controller.text);
      print("si");
      await databaseReference.collection("Usuarios").add({
        'apellido': apellidoController.text,
        'contraseña': password1Controller.text,
        'correo': correoController.text,
        'nombre': nombreController.text
      });
     _showSnackBar(context, 'Registro exitoso', Icons.verified_user,Colors.green);
     final String  mensaje = 'Estimado ${nombreController.text} ${apellidoController.text}.\nTe damos la bienvenida a Find My Tecky.\nSi no has creado la cuenta, por favor haz clic en el siguiente enlace:\n[link]\n¡Muchas gracias por usar nuestra app!';
    return sendEmail(correoController.text, 'Verificacion de cuenta', mensaje);
    } catch (e) {
    _showSnackBar(context, e.message, Icons.error,Colors.red);
    }
  }

  bool _evaluarCadena(String cadena)
  {
    RegExp exp = new RegExp(r"^([A-Z]{1}[a-z]+[ ]?){1,2}$");
    return exp.hasMatch(cadena);
  }

  bool _evaluarPassword(String password) {
    RegExp exp = new RegExp(r"^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$");
    return exp.hasMatch(password);
  }

  bool _evaluarCorreo(String correo) {
    RegExp exp = new RegExp(r"^([a-z0-9_\.-]+)@itsmante\.edu\.mx$");
    return exp.hasMatch(correo);
  }

  void _showSnackBar(context, String mensaje, IconData iconData, Color color) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Icon(
                  iconData,
                  color: color,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  mensaje,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
