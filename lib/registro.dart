import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:um/ubicacionInterfaz.dart';
import 'main.dart';

class PaginaRegistro extends StatefulWidget {
  @override
  _PaginaRegistro createState() => new _PaginaRegistro();
}

class _PaginaRegistro extends State<PaginaRegistro> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmarPassword = TextEditingController();
  bool _obscureText = true;

  bool _isSuccess;
  String _userEmail;

  @override
  void dispose() {
    _correo.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Text(""),
            Text(""),
            GradientText("URBAN MAPPER",
                gradient: LinearGradient(
                    colors: [Color(0xFF2c69b8), Color(0xFF800080)]),
                style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            //CORREO
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
              child: TextFormField(
                controller: _correo,
                decoration: InputDecoration(
                    labelText: "Correo electronico",
                    hintText: "Correo electronico",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.email)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Ingrese un correo';
                  }
                  return null;
                },
              ),
            ),
            //USUARIO
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
              child: TextFormField(
                controller: _displayName,
                decoration: InputDecoration(
                    labelText: "Usuario",
                    hintText: "Usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.person_outline)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Ingrese un nombre de usuario';
                  }
                  return null;
                },
              ),
            ),
            //CONTRASEÑA
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
              child: TextFormField(
                controller: _password,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    labelText: "Contraseña",
                    hintText: "Contraseña",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.enhanced_encryption),
                    suffixIcon: new GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: new Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Ingrese una contraseña';
                  }
                  return null;
                },
              ),
            ),
            //CONFIRMAR CONTRASEÑA
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
              child: TextFormField(
                controller: _confirmarPassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    labelText: "Confirmar contraseña",
                    hintText: "Confirmar contraseña",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.enhanced_encryption),
                    suffixIcon: new GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: new Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Ingrese la contraseña';
                  } else if (_confirmarPassword.text != _password.text) {
                    return 'Las contraseñas no son iguales';
                  }
                  return null;
                },
              ),
            ),
            //BOTON
            Container(
              padding: const EdgeInsets.only(top: 32, left: 35, right: 35),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _showAlertDialog();
                    _registerAcount();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2c69b8), Color(0xFF800080)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "REGISTRARSE",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _registerAcount() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
            email: _correo.text, password: _confirmarPassword.text))
        .user;
    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);
      final user1 = _auth.currentUser;
      log('Usuario: ${user.displayName}');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PaginaUbicacion(
                user: user1,
              )));
    } else {
      _isSuccess = false;
    }
  }

//Color(0xFF53379d)
  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Mensaje"),
            content: Text("¡Registro exitoso!",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
            actions: <Widget>[
              RaisedButton(
                color: Color(0xFF53379d),
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
