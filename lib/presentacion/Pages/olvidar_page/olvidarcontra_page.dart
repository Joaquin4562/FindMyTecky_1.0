import 'package:flutter/material.dart';

class OlvidarcontraPage extends StatefulWidget {
  @override
  _OlvidarcontraPageState createState() => _OlvidarcontraPageState();
}

class _OlvidarcontraPageState extends State<OlvidarcontraPage> {
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 220),
          child: FloatingActionButton(
            onPressed: () {},
            
            backgroundColor: Colors.blue,
            child: Center(
              child: Icon(Icons.send),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            color: Colors.grey.withOpacity(0.3),
            height: 200,
            width: 360,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 45,
                left: 30,
                right: 30
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    cursorWidth: 2,
                    showCursor: true,
                    cursorColor: Colors.amber,
                    cursorRadius: Radius.circular(12),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'Ingrese su correo electrónico',
                      labelText: 'Correo:',
                      helperStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      helperText:
                          'Solo usar correos con extensión @itsmante.edu.mx',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _validar() {
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(0, 91, 160, 100),
      child: Icon(Icons.send),
      onPressed: () {},
    );
  }
}
