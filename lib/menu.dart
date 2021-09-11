import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:um/horariosdetrabajo.dart';
import 'package:um/miubicacion.dart';
import 'package:um/paraderos.dart';
import 'package:um/rutasfusa.dart';
import 'package:um/rutasintermunicipales.dart';
import 'package:um/tarifa.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class PaginaMenu extends StatefulWidget {
  @override
  _PaginaMenu createState() => new _PaginaMenu();
}

class _PaginaMenu extends State<PaginaMenu> {
  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaginaMiUbicacion()));
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Mi ubicación",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17)))
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
                          builder: (context) => PaginaRutasFusa()));
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.directions_bus,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Rutas Fusagasugá",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 18)))
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
                          builder: (context) => PaginaRutasIntermunicipales()));
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.train,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Rutas Intermunicipales",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17)))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaginaTarifa()));
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.attach_money,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Tarifa de Pasajes",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17)))
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
                          builder: (context) => PaginaHorarios()));
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.timer,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Horarios de trabajo",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17)))
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
                          builder: (context) => PaginaParaderos()));
                },
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.traffic,
                        size: 70.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("Paraderos",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17)))
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
