import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_my_tecky_1_0/negocios/class/simple_animation.dart';
import 'package:find_my_tecky_1_0/negocios/util/preferencias_de_usuario.dart';
import 'package:find_my_tecky_1_0/presentacion/Pages/mapa_page/mapa_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();
}

class _LoginPageState extends State<LoginPage> {
  //String  _email = '';
  bool _isObscure = true;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Firestore _firestoreReference = Firestore.instance;
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
                child: FadeAnimation(
                    1,
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          children: <Widget>[
                            _textHeader(),
                            SizedBox(
                              height: 30,
                            ),
                            _textSubHead(),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
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
                                _divider(),
                                _iniciargoogle(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ]),
          )),
    );
  }

  Widget _inputCorreo() {
    return TextField(
      controller: _controllerEmail,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Ingrese su correo electrónico',
        labelText: 'Correo',
        helperStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        icon: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _inputContrasena() {
    return TextField(
      controller: _controllerPass,
      style: TextStyle(color: Colors.white),
      obscureText: _isObscure,
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelStyle: TextStyle(color: Colors.white),
        hintText: 'Ingrese su Contraseña',
        labelText: 'Contraseña',
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
        color: Color.fromRGBO(32, 173, 244, 1),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          //PRUEBAS
          // Navigator.pushReplacementNamed(context, 'MapaPage');
          String correo = _controllerEmail.text;

          bool _evaluarCorreo(String correo) {
            RegExp exp = new RegExp(
                r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");
            return exp.hasMatch(correo);
          }

          if (_evaluarCorreo(correo) != false && _controllerPass.text != '') {
            _autenticar(_controllerEmail.text, _controllerPass.text);
          } else {
            Fluttertoast.showToast(msg: "Rellena los campos");
          }
        },
      ),
    );
  }

  Widget _iniciargoogle() {
    return SignInButton(Buttons.Google,
        text: 'Iniciar con Google',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
        onPressed: () {
      signInWithGoogle().whenComplete(() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MapaPage();
            },
          ),
        );
      });
    });
  }

  Widget _olvidarcontrasena() {
    return Padding(
      padding: const EdgeInsets.only(right: 140, top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'RecuperarPage');
        },
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height < 600 ? 14 : 17,
            color: Color.fromRGBO(32, 173, 244, 1),
          ),
        ),
      ),
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

  Future _autenticar(String email, String pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (result != null) {
        final prefs = PreferenciasUsuario();
        prefs.isLogged = true;
        FirebaseUser user = result.user;
        _firestoreReference
            .collection('Usuarios')
            .getDocuments()
            .then((value) => value.documents.forEach((element) {
                  if (element.data.values.contains(email)) {
                    prefs.documentUserID = element.documentID;
                    print(prefs.documentUserID);
                  }
                }));
        Navigator.pushReplacementNamed(context, 'MapaPage');
        print(user.email);
      } else {
        Fluttertoast.showToast(msg: "error al iniciar sesión");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.message);
    }
  }

  Widget _textCondiciones() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            text:
                'Al hacer click en "iniciar sesión", estas aceptando nuestras  '),
        TextSpan(
            text: 'Condiciones de servicio ',
            style: new TextStyle(color: Colors.blue),
            recognizer: new TapGestureRecognizer()..onTap = () {_showDialog('Los presentes términos y condiciones contienen los acuerdos entre los miembros de la Sociedad Find My Tecky, para establecer que las personas descarguen cualquier aplicación desarrollada por la Sociedad Find My Tecky, así como las marcas, los productos y los servicios que preste la misma sociedad.\nAl descargar la Aplicación, el Usuario deberá manifestar su aceptación de los presentes Términos y Condiciones de la Aplicación a efecto de poder usar la Aplicación, y en caso de que no los acepte, el Usuario deberá de abstenerse de usar la Aplicación.\nFind My Tecky pone a disposición del Usuario, la presente Aplicación para que así este mismo pueda realizar de manera eficiente la prestación de los Servicios.' 
            +'\nLa Aplicación de Find My Tecky proporcionará al Usuario el servicio de ubicación del transporte escolar, y visualización en tiempo real del mapa con la ubicación para proporcionar al Usuario una mejor experiencia en el transporte escolar. \n Los datos ingresados por los Usuarios a través de la app y obtenidos por la sociedad serán almacenados bajo estándares internacionales de alta seguridad, los cuales ayudarán a la prestación de los Servicios por medio de la misma.'
            +'Para que la sociedad pueda prestar los Servicios, el Usuario se obliga a ingresar los datos solicitados en la aplicación.',1);}),
        TextSpan(text: 'y la'),
        TextSpan(
            text: ' Política de privaciada ',
            style: new TextStyle(color: Colors.blue),
            recognizer: new TapGestureRecognizer()..onTap = () {_showDialog('La presente Política de Privacidad establece los términos en que Find My Tecky usa y protege la información que es proporcionada por sus usuarios al momento de utilizar su app.\nEsta compañía está comprometida con la seguridad de los datos de sus usuarios. Cuando le pedimos llenar los campos de información personal con la cual usted pueda ser identificado, lo hacemos asegurando que sólo se empleará de acuerdo con los términos de este documento. Sin embargo, esta Política de Privacidad puede cambiar con el tiempo o ser actualizada por lo que le recomendamos y enfatizamos revisar continuamente esta página para asegurarse que está de acuerdo con dichos cambios. \n Nuestra app podrá recoger información personal, por ejemplo: Nombre, información de contacto como su dirección de correo electrónico e información demográfica. Así mismo cuando sea necesario podrá ser requerida información específica en caso de que pierda su contraseña.\nNuestra app emplea la información con el fin de proporcionar el mejor servicio posible, particularmente para mantener un registro de usuarios, de pedidos en caso que aplique, y mejorar nuestro servicio\nFind My Tecky está altamente comprometido para cumplir con el compromiso de mantener su información segura. Usamos los sistemas más avanzados y los actualizamos constantemente para asegurarnos que no exista ningún acceso no autorizado.',2);}),
        TextSpan(text: 'de Find My Tecky.'),
      ]),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
          ),
          Text(
            'o',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  _showDialog(String texto, int tipo) {
    showDialog(
        context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Aceptar'))
              ],
              title: tipo == 1? Text('Condiciónes de servicio'):Text('Politica de privacidad'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(child: SingleChildScrollView(child: Text('$texto',textAlign: TextAlign.justify,))),
                ],
              ));
        });
  }
}
