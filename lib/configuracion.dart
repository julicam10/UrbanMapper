import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';

import 'main.dart';

class PaginaCcuenta extends StatefulWidget {
  final User user;

  const PaginaCcuenta({Key key, this.user}) : super(key: key);

  @override
  _PaginaCcuenta createState() => new _PaginaCcuenta();
}

class _PaginaCcuenta extends State<PaginaCcuenta> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Image(
              image: AssetImage('assets/images/imgusuario.png'),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80),
                  Text(" Usuario: ",
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 20),
                          fontWeight: FontWeight.bold)),
                  Text("*Usuario*",
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 17),
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 80),
                Text("Contraseña",
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 20),
                        fontWeight: FontWeight.bold)),
                Text(" *Contraseña*",
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 17),
                        fontWeight: FontWeight.bold))
              ],
            )),
            OutlineButton(
                borderSide: BorderSide(color: Color(0xFF53379d), width: 1.5),
                child: Text("CERRAR SESION",
                    style: TextStyle(fontSize: 23.0, color: Color(0xFF53379d))),
                shape: StadiumBorder(),
                onPressed: () {
                  _signOut().whenComplete(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  });
                })
          ],
        ),
      ),
    );
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}
