import 'package:find_my_tecky_1_0/negocios/class/simple_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black87,
        image: DecorationImage(
            image: AssetImage("assets/fondo.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: FadeAnimation(
                1,
                Container(
                  height: MediaQuery.of(context).size.height - 100,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100,left: 5,right: 5),
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
                          height: 20,
                        ),
                        _btnRegistrarse(),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget _textfieldNombre() {
    return TextField(
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
        hintText: 'Ingrese su correo electronico',
        labelText: 'Correo:',
        helperText: 'Solo usar correos con extension @itsmante.edu.mx',
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }

  Widget _textfieldContrasena() {
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
      obscureText: true,
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
      style: TextStyle(
        color: Colors.white,
      ),
      obscureText: true,
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

  _crearcuenta() {
    return RaisedButton(
      child: Text('Crea sesión'),
      elevation: (10),
      color: Colors.blue,
      textColor: Colors.white,
      shape: StadiumBorder(),
      onPressed: () {
        print('hola');
      },
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
            text: ' Politica de privaciada ',
            style: new TextStyle(color: Colors.blue),
            recognizer: new TapGestureRecognizer()..onTap = () {}),
        TextSpan(text: 'de Find My Tecky.'),
      ]),
    );
  }

  Widget _btnRegistrarse() {
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
        onPressed: () {
          print('hola');
        },
      ),
    );
  }
}
