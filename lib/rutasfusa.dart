import 'dart:developer';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:um/mapaRutasFusa.dart';

import 'main.dart';

class PaginaRutasFusa extends StatefulWidget {
  @override
  _PaginaRutasFusa createState() => new _PaginaRutasFusa();
}

class _PaginaRutasFusa extends State<PaginaRutasFusa> {
  String value = "";

  bool disabledropdown = true;

  void secondvaluechanged(_value) {
    setState(() {
      value = _value;
    });
  }

  void valuechanged(_value) {
    if (_value == "Pekin") {
      _value == "2";
    } else if (_value == "Terminal") {
      _value == "3";
    } else if (_value == "Pampa") {
      _value == "4";
    } else if (_value == "Todas las rutas") {
      _value == "1";
    }
    setState(() {
      value = _value;
      disabledropdown = false;
    });
  }

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
        title: Text("Rutas Fusagasugá"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.directions_bus),
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
      //COMIENZO COMBO
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 30.0, left: 30.0),
              child: Text(
                  "El paseje municipal de Fusagasugá tiene un costo de 1.700 pesos",
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 20),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  textScaleFactor: 0.9),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: DropdownButton<String>(
                //dropdownColor: Colors.white10,
                hint: Text("Selecciona un destino",
                    style:
                        GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 18,
                items: [
                  DropdownMenuItem<String>(
                    value: "Todas las rutas",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Todas las rutas",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 20))),
                      ],
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "Pekin",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Pekin",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 20))),
                      ],
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "Terminal",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Terminal",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 20))),
                      ],
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "Pampa",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Pampa",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(fontSize: 20))),
                      ],
                    ),
                  ),
                ],
                onChanged: (_value) => valuechanged(_value),
              ),
            ),
            Text("Destino: ",
                style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
            Text(
              "$value",
              style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {
                log('ruta seleccionada: $value');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaginaMapasRutasFusa(value)));
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
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "VER",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
