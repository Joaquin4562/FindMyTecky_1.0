import 'package:find_my_tecky_1_0/negocios/class/simple_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final databaseReference = Firestore.instance;
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final correoController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  bool _isObscure = false;

  @override
  void dispose()
  {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
            child: FadeAnimation(
                1,
                Container(
                  height: screenSize.height < 600 ? screenSize.height-50 : screenSize.height +50,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
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
      controller: password2Controller,
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
            text: ' Política de privaciada ',
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
                    if(_verificarCorreo() == true)
                    {

                    }
                    else
                    {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Recupera el texto que el usuario ha digitado utilizando nuestro
                            // TextEditingController
                            content: Text('Ya existe una cuenta con este correo'),
                          );
                        },
                      );
                    }
                  }
                  else
                  {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Recupera el texto que el usuario ha digitado utilizando nuestro
                          // TextEditingController
                          content: Text('Recuerda usar un correo valido del instituto'),
                        );
                      },
                    );
                  }
                }
                else
                {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // Recupera el texto que el usuario ha digitado utilizando nuestro
                        // TextEditingController
                        content: Text('Recuerda que la contraseña debe tener al entre 8 y 16 caracteres, al menos un dígito, al menos una minúscula y al menos una mayúscula.Puede tener otros símbolos.'),
                      );
                    },
                  );
                }
              }
              else
              {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Recupera el texto que el usuario ha digitado utilizando nuestro
                      // TextEditingController
                      content: Text('El nombre no es valido'),
                    );
                  },
                );
              }
            }
            else
            {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Recupera el texto que el usuario ha digitado utilizando nuestro
                    // TextEditingController
                    content: Text('Los passwords no coinciden'),
                  );
                },
              );
            }
          }
          else
          {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Recupera el texto que el usuario ha digitado utilizando nuestro
                  // TextEditingController
                  content: Text('Por favor ingresa todos los datos'),
                );
              },
            );
          }
        },
      ),
    );
  }

  void registrar() async { 

    await databaseReference.collection( "Usuarios" ) 
      .add({ 
        'apellido' : apellidoController.text , 
        'contraseña' : password1Controller.text,
        'correo' : correoController.text,
        'nombre' : nombreController.text
      });
  }

  void getData() { 
  databaseReference.collection("books").getDocuments().then((QuerySnapshot snapshot) { 
    snapshot.documents.forEach((f) => print('${f.data}}')); 
  }); 
}

  bool _verificarCorreo()
  {
    return true;
  }

  bool _evaluarCadena(String cadena)
  {
    RegExp exp = new RegExp(r"^([A-Z]{1}[a-z]+[ ]?){1,2}$");
    return exp.hasMatch(cadena);
  }

  bool _evaluarPassword(String password)
  {
    RegExp exp = new RegExp(r"^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$");
    return exp.hasMatch(password);
  }

  bool _evaluarCorreo(String correo)
  {
    RegExp exp = new RegExp(r"^([a-z0-9_\.-]+)@itsmante\.edu\.mx$");
    return exp.hasMatch(correo);
  }


}

