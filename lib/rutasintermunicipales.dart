import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:um/maparutasintermunicipales.dart';
import 'dart:developer';

import 'main.dart';

class PaginaRutasIntermunicipales extends StatefulWidget {
  @override
  _PaginaRutasIntermunicipales createState() =>
      new _PaginaRutasIntermunicipales();
}

class _PaginaRutasIntermunicipales extends State<PaginaRutasIntermunicipales> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text("Ruta Intermunicipales"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.train),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF2c69b8), Color(0xFF800080)])),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                onTap: () {
                  value = "Pasca";
                  log('data: $value');
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.history,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Pasca",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17),
                              fontWeight: FontWeight.bold)),
                      Text("Museo arqueológico y balsa muisca de oro.",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 12))),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  value = "Silvania";
                  log('data: $value');
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.landscape,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Silvania",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 18),
                              fontWeight: FontWeight.bold)),
                      Text("Se conocía como Subia o Uzathama.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 12)))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  value = "Arbelaez";
                  log('data: $value');
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.cloud,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Arbelaez",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17),
                              fontWeight: FontWeight.bold)),
                      Text("Ciudad Tranquila y acogedora de Colombia.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 12)))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaginaMapasRutasInter(value)));
                  log('data: $value');
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.map,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("VER MAPA",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
