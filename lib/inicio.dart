import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:gradient_text/gradient_text.dart';
import 'main.dart';
import 'ubicacionInterfaz.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLogin createState() => new _PaginaLogin();
}

class _PaginaLogin extends State<PaginaLogin> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return ListView(
          children: <Widget>[
            withEmailPassword(context),
          ],
        );
      }),
    );
  }

  Widget withEmailPassword(context) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 40),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 05.0),
                child: GradientText("URBAN MAPPER",
                    gradient: LinearGradient(
                        colors: [Color(0xFF2c69b8), Color(0xFF800080)]),
                    style:
                        TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: TextFormField(
                      controller: _correo,
                      decoration: InputDecoration(
                        labelText: "Correo electronico",
                        hintText: "Correo electronico",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        icon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ingrese un correo';
                        }
                        return null;
                      })),
              Container(
                padding: const EdgeInsets.only(top: 30.0),
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Ingrese una contraseña';
                      }
                      return null;
                    }),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 32),
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      //_showAlertDialog(context);
                      _signInWithEmailAndPassword(context);
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
                        "ENTRAR",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    _correo.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword(context) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
              email: _correo.text, password: _password.text))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return PaginaUbicacion(
          user: user,
        );
        //
      }));
      showDialog(
          context: context,
          builder: (buildcontext) {
            return AlertDialog(
              content: GradientText("Bienvenido",
                  gradient: LinearGradient(
                      colors: [Color(0xFF2c69b8), Color(0xFF800080)]),
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            );
          });
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("No se pudo ingresar"),
      ));
      print(e);
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }

  void _showAlertDialog(context) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Mensaje"),
            content: Text("¡Bienvenido!",
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
