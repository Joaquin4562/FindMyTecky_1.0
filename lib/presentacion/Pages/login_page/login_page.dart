import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //String  _email = '';
  bool _isObscure = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: AssetImage("assets/fondo.png"), fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  children: <Widget>[
                    _textHeader(),
                    SizedBox(
                      height: 30,
                    ),
                    _textSubHead(),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Column(
                        children: <Widget>[
                          _inputCorreo(),
                          Divider(),
                          _inputContrasena(),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _olvidarcontrasena(),
                        SizedBox(
                          height: 20,
                        ),
                        _textCondiciones(),
                        SizedBox(
                          height: 20,
                        ),
                        _iniciarsesion(),
                        SizedBox(
                          child: Text('o',
                          style: TextStyle(color:Colors.white,fontSize: 15),
                          ),
                          height: 20,
                        ),
                        _iniciargoogle(),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget _inputCorreo() {
    return TextField(
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Ingrese su correo electronico',
        labelText: 'Correo:',
        helperStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        helperText: 'Solo usar correos con extension @itsmante.edu.mx',
        icon: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _inputContrasena() {
    return TextField(
      style: TextStyle(color: Colors.white),
      obscureText: _isObscure,
      decoration: InputDecoration(
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelStyle: TextStyle(color: Colors.white),
        hintText: 'Ingrese su Contraseña',
        labelText: 'Contraseña:',
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
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

  Widget _iniciarsesion() {
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
          'Iniciar Sesión',
          style: TextStyle(fontSize: 16),
        ),
        elevation: (10),
        color: Colors.blue,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          print('hola');
        },
      ),
    );
  }

  Widget _iniciargoogle() {
    return SignInButton(Buttons.Google,
        text: 'Iniciar con Google',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
        onPressed: () {});
  }

  Widget _olvidarcontrasena() {
    return FlatButton(
      child: Text(
        '¿Olvidaste tu contraseña?',
        style: TextStyle(fontSize: 17),
      ),
      textColor: Color.fromRGBO(0, 91, 160, 1),
      onPressed: () {
        Navigator.pushNamed(context, 'OlvidarcontraPage');
      },
    );
  }

  Widget _textHeader() {
    return Text(
      '¡Hola te extrañamos!',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 30, letterSpacing: 2),
    );
  }

  Widget _textSubHead() {
    return Text(
      '¡Inicia sesión para que no pierdas el tecky!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }

  Widget _textCondiciones() {
    return Text(
      'Al hacer click en "inicio de sesión", estas aceptando nuestras condiciones de Uso y Politica de privacidad',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
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
}
