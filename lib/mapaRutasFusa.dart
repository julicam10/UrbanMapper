import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'main.dart';

class PaginaMapasRutasFusa extends StatefulWidget {
  String value = "";
  PaginaMapasRutasFusa(this.value);

  @override
  _PaginaMapasRutasFusa createState() => new _PaginaMapasRutasFusa();
}

class _PaginaMapasRutasFusa extends State<PaginaMapasRutasFusa> {
  bool _isVisible = true;
  bool _darkMode = false;
  StreamSubscription _streamSubscription;
  Location _tracker = Location();
  Marker marker;
  Circle circle;
  Completer<GoogleMapController> _controller = Completer();

  GoogleMapController _googleMapController;

  static final CameraPosition camaraPosicion =
      CameraPosition(target: LatLng(4.33646, -74.36378), zoom: 14.4746);

  void showMenuOptions() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  bool switchValue = false;
  changeMapMode() {
    setState(() {
      if (_darkMode == true) {
        getJsonFile("assets/json/night.json").then(setMapStyle);
      } else {
        getJsonFile("assets/json/light.json").then(setMapStyle);
      }
    });
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _googleMapController.setMapStyle(mapStyle);
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
    }
    super.dispose();
  }

  //Function for updateMarkerAndCircle
  void updateMarker(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("marcador"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("carro"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  Future<Uint8List> getMarkerCar() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/telefono.png");
    return byteData.buffer.asUint8List();
  }

  //Function for capture your current position
  void getCurrentLocationCar() async {
    try {
      Uint8List imageData = await getMarkerCar();
      var location = await _tracker.getLocation();

      updateMarker(location, imageData);

      if (_streamSubscription != null) {
        _streamSubscription.cancel();
      }

      _streamSubscription = _tracker.onLocationChanged.listen((newLocalData) {
        if (_googleMapController != null) {
          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 100,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarker(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDnJuODuBzsoUflKVwyxD-_uTK4HThyRyg");
  Set<Polyline> Todas = {};
  Set<Polyline> PekinTerminal = {};
  Set<Polyline> PekinPampa = {};
  Set<Polyline> TerminalPampa = {};
  Set<Polyline> TerminalPekin = {};
  Set<Polyline> PampaPekin = {};
  Set<Polyline> PampaTerminal = {};
  Set<Polyline> Prueba = {};

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    if (_darkMode) {
      setState(() {
        changeMapMode();
      });
    }
    log('ruta: ${this.widget.value}');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text("Ruta Fusagasugá"),
          actions: [
            IconButton(
              icon: Icon(Icons.directions_bus),
              onPressed: () {
                showMenuOptions();
              },
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
        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              zoomGesturesEnabled: true,
              initialCameraPosition: camaraPosicion,
              markers: Set.of((marker != null) ? [marker] : []),
              circles: Set.of((circle != null) ? [circle] : []),
              onMapCreated: (GoogleMapController controller) {
                _googleMapController = controller;
              },
              polylines: Prueba,
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: EdgeInsets.only(top: 80, right: 10),
              alignment: Alignment.centerRight,
              color: Color(0xFF808080).withOpacity(0.5),
              height: 130,
              width: 70,
              child: Column(children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                new Switch(
                  activeColor: Colors.black87,
                  onChanged: (newValue) {
                    setState(() {
                      this.switchValue = newValue;
                      _darkMode = newValue;
                      changeMapMode();
                      //print('Changing the Map Type');
                    });
                  },
                  value: switchValue,
                ),
                SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                      child: Icon(Icons.location_searching),
                      elevation: 5,
                      backgroundColor: Color(0xFF53379d),
                      onPressed: () {
                        getCurrentLocationCar();
                      }),
                ),
              ]),
            ),
          )
        ]));
  }

  @override
  void initState() {
    if (this.widget.value == "Pekin") {
      PekinTerminal = Prueba;
      PekinPampa = Prueba;
      log('valor: Pekin');
    } else if (this.widget.value == "Terminal") {
      TerminalPampa = Prueba;
      TerminalPekin = Prueba;
      log('valor: Terminal');
    } else if (this.widget.value == "Pampa") {
      PampaPekin = Prueba;
      PampaTerminal = Prueba;
      log('valor: Pampa');
    } else if (this.widget.value == "Todas las rutas") {
      PekinTerminal = Prueba;
      PekinPampa = Prueba;
      TerminalPampa = Prueba;
      log('valor: Todas');
    }
    super.initState();
    TerminalPekin.add(
      Polyline(
        polylineId: PolylineId("TerminalPekin"),
        consumeTapEvents: true,
        endCap: Cap.buttCap,
        width: 3,
        geodesic: true,
        color: Colors.green,
        onTap: () {
          showDialog(
              context: context,
              builder: (buildcontext) {
                return AlertDialog(
                  title: Text("Terminal - Pekin"),
                  content: Text("Galeria - Centro - Banco Popular - Pekin",
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
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
          log('Terminal - Pekin');
        },
        points: [
          //TERMINAL - PEKIN

          LatLng(4.345739, -74.377461), // TERMINAL
          LatLng(4.343385, -74.376098), // CRUCE PALMAS
          LatLng(4.343321, -74.374435), //
          LatLng(4.343289, -74.372482), //
          LatLng(4.342829, -74.371087), // PALMAS DE HUPANEL
          LatLng(4.342155, -74.369049), // AGROMICOS ORIENTE
          LatLng(4.341706, -74.368223), //
          LatLng(4.341225, -74.367182), //
          LatLng(4.341054, -74.366238), // CRUCE PALMAS - SANTANITA
          LatLng(4.341054, -74.366238), // DAVIVIENDA PALMAS
          LatLng(4.341895, -74.363761), // COLEGIO SANTANDER
          LatLng(4.341895, -74.363761), // PALMAS - FILIPO
          LatLng(4.342576, -74.362031),
          LatLng(4.342565, -74.360626), // BANCO POPULAR
          LatLng(4.342719, -74.359953),
          LatLng(4.343069, -74.359262), //GANAVICOLA
          LatLng(4.343481, -74.357843), //FILIPO PEKIN
          LatLng(4.344542, -74.357929), //
          LatLng(4.344678, -74.357806), //
          LatLng(4.344646, -74.357642), //
          LatLng(4.344199, -74.357261), //
          LatLng(4.344048, -74.357118), //
          LatLng(4.343575, -74.355887), //
          LatLng(4.345316, -74.356217), //
          LatLng(4.345747, -74.354329), //
          LatLng(4.345862, -74.353752), //
          LatLng(4.346429, -74.352526), //
          LatLng(4.346544, -74.352156) //
        ],
      ),
    );
    TerminalPampa.add(
      Polyline(
        polylineId: PolylineId("TerminalPampa"),
        consumeTapEvents: true,
        endCap: Cap.buttCap,
        width: 3,
        geodesic: true,
        color: Colors.blue,
        onTap: () {
          showDialog(
              context: context,
              builder: (buildcontext) {
                return AlertDialog(
                  title: Text("Terminal - Pampa"),
                  content: Text(
                      "Galeria - Centro - Universidad - Hospital - Indio",
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
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
          log('Terminal - Pekin');
        },
        points: [
          LatLng(4.345739, -74.377461), // TERMINAL
          LatLng(4.343385, -74.376098), // CRUCE PALMAS
          LatLng(4.343321, -74.374435), //
          LatLng(4.343289, -74.372482), //
          LatLng(4.342829, -74.371087), // PALMAS DE HUPANEL
          LatLng(4.342155, -74.369049), // AGROMICOS ORIENTE
          LatLng(4.341706, -74.368223), //
          LatLng(4.341225, -74.367182), //
          LatLng(4.341054, -74.366238), // CRUCE PALMAS - SANTANITA
          LatLng(4.341054, -74.366238), // DAVIVIENDA PALMAS
          LatLng(4.341895, -74.363761), // COLEGIO SANTANDER
          LatLng(4.341895, -74.363761), // PALMAS - FILIPO
          LatLng(4.341573, -74.363178), // PARADERO FLIPO!!
          LatLng(4.341090, -74.363188), //
          LatLng(4.340405, -74.363079), // OPUS
          LatLng(4.339905, -74.362791), // LA 11
          LatLng(4.339247, -74.363676), // PUENTE DEL AGUILA
          LatLng(4.339058, -74.363904), // BOMBA PUENTE DEL AGUILA
          LatLng(4.337377, -74.365220), // LOZANO
          LatLng(4.336457, -74.365853), // CLINICA BELEN
          LatLng(4.335202, -74.367550), // LA 18 (LA MANZANA)
          LatLng(4.334012, -74.369272), // UNIVERSIDAD
          LatLng(4.333434, -74.370106), // LA 22 (EXITO)
          LatLng(4.333239, -74.370484), //
          LatLng(4.332715, -74.372294), // SAN MATEO
          LatLng(4.331808, -74.375153), // CC COLSUBSIDIO
          LatLng(4.331434, -74.377859), // INDIO
          LatLng(4.330331, -74.379049), // URBANIZACION EL ENCANTO
          LatLng(4.330026, -74.379524), // CRUCE ENCANTO
          LatLng(4.330106, -74.380267), //
          LatLng(4.330031, -74.380758), // PARRA
          LatLng(4.329879, -74.381544), // AUTOLAVADO CATAMA
          LatLng(4.329521, -74.383298), // MAMAJUANA
          LatLng(4.328927, -74.386071), // CRUCE VILLA PATRICIA
          LatLng(4.328654, -74.387409), // CC LA QUERENCIA
          LatLng(4.328294, -74.389183), // ENTRADA LA GRAN COLOMBIA
          LatLng(4.327858, -74.391164), //
          LatLng(4.327564, -74.392494), // LUBRICANTES MILENIUM
          LatLng(4.327457, -74.393079), //
          LatLng(4.326874, -74.395045), // CHEVROLET
          LatLng(4.326710, -74.395807), // CRUCE ARBELAEZ
          LatLng(4.326712, -74.409122), //
          LatLng(4.326567, -74.409448), //
          LatLng(4.328064, -74.409962), //
          LatLng(4.327237, -74.413051) //
        ],
      ),
    );
    PekinTerminal.add(
      Polyline(
        polylineId: PolylineId("TerminalPekin"),
        consumeTapEvents: true,
        endCap: Cap.buttCap,
        width: 3,
        geodesic: true,
        color: Colors.red,
        onTap: () {
          showDialog(
              context: context,
              builder: (buildcontext) {
                return AlertDialog(
                  title: Text("Terminal - Pekin"),
                  content: Text("Galeria - Centro",
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
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
          log('Terminal - Pekin');
        },
        points: [
          LatLng(4.345739, -74.377461), // TERMINAL
          LatLng(4.343385, -74.376098), // CRUCE PALMAS
          LatLng(4.343321, -74.374435), //
          LatLng(4.343289, -74.372482), //
          LatLng(4.342829, -74.371087), // PALMAS DE HUPANEL
          LatLng(4.342155, -74.369049), // AGROMICOS ORIENTE
          LatLng(4.341706, -74.368223), //
          LatLng(4.341225, -74.367182), //
          LatLng(4.341054, -74.366238), // CRUCE PALMAS - SANTANITA
          LatLng(4.341054, -74.366238), // DAVIVIENDA PALMAS
          LatLng(4.341895, -74.363761), // COLEGIO SANTANDER
          LatLng(4.341895, -74.363761), // PALMAS - FILIPO
          LatLng(4.342576, -74.362031),
          LatLng(4.342565, -74.360626), // BANCO POPULAR
          LatLng(4.342719, -74.359953),
          LatLng(4.343069, -74.359262), //GANAVICOLA
          LatLng(4.343481, -74.357843), //FILIPO PEKIN
          LatLng(4.344542, -74.357929), //
          LatLng(4.344678, -74.357806), //
          LatLng(4.344646, -74.357642), //
          LatLng(4.344199, -74.357261), //
          LatLng(4.344048, -74.357118), //
          LatLng(4.343575, -74.355887), //
          LatLng(4.345316, -74.356217), //
          LatLng(4.345747, -74.354329), //
          LatLng(4.345862, -74.353752), //
          LatLng(4.346429, -74.352526), //
          LatLng(4.346544, -74.352156) //
        ],
      ),
    );
    PekinPampa.add(
      Polyline(
        polylineId: PolylineId("PekinPampa"),
        consumeTapEvents: true,
        endCap: Cap.buttCap,
        width: 3,
        geodesic: true,
        color: Colors.blue,
        onTap: () {
          showDialog(
              context: context,
              builder: (buildcontext) {
                return AlertDialog(
                  title: Text("Pekin - Pampa"),
                  content: Text("Centro - Universidad - Hospital",
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
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
          log('Pekin - Pampa');
        },
        points: [
          // PAMPA - PEKIN

          LatLng(4.346544, -74.352156), //
          LatLng(4.346429, -74.352526), //
          LatLng(4.345862, -74.353752), //
          LatLng(4.345747, -74.354329), //
          LatLng(4.345316, -74.356217), //
          LatLng(4.343575, -74.355887), //
          LatLng(4.344048, -74.357118), //
          LatLng(4.344199, -74.357261), //
          LatLng(4.344646, -74.357642), //
          LatLng(4.344678, -74.357806), //
          LatLng(4.344542, -74.357929), //
          LatLng(4.343481, -74.357843), //FILIPO PEKIN
          LatLng(4.343069, -74.359262), //GANAVICOLA
          LatLng(4.342719, -74.359953),
          LatLng(4.342565, -74.360626), // BANCO POPULAR
          LatLng(4.342576, -74.362031),
          LatLng(4.341895, -74.363761), // PALMAS - FILIPO
          LatLng(4.341573, -74.363178), // PARADERO FLIPO!!
          LatLng(4.341090, -74.363188), //
          LatLng(4.340405, -74.363079), // OPUS
          LatLng(4.339905, -74.362791), // LA 11
          LatLng(4.339247, -74.363676), // PUENTE DEL AGUILA
          LatLng(4.339058, -74.363904), // BOMBA PUENTE DEL AGUILA
          LatLng(4.337377, -74.365220), // LOZANO
          LatLng(4.336457, -74.365853), // CLINICA BELEN
          LatLng(4.335202, -74.367550), // LA 18 (LA MANZANA)
          LatLng(4.334012, -74.369272), // UNIVERSIDAD
          LatLng(4.333434, -74.370106), // LA 22 (EXITO)
          LatLng(4.333239, -74.370484), //
          LatLng(4.332715, -74.372294), // SAN MATEO
          LatLng(4.331808, -74.375153), // CC COLSUBSIDIO
          LatLng(4.331434, -74.377859), // INDIO
          LatLng(4.330331, -74.379049), // URBANIZACION EL ENCANTO
          LatLng(4.330026, -74.379524), // CRUCE ENCANTO
          LatLng(4.330106, -74.380267), //
          LatLng(4.330031, -74.380758), // PARRA
          LatLng(4.329879, -74.381544), // AUTOLAVADO CATAMA
          LatLng(4.329521, -74.383298), // MAMAJUANA
          LatLng(4.328927, -74.386071), // CRUCE VILLA PATRICIA
          LatLng(4.328654, -74.387409), // CC LA QUERENCIA
          LatLng(4.328294, -74.389183), // ENTRADA LA GRAN COLOMBIA
          LatLng(4.327858, -74.391164), //
          LatLng(4.327564, -74.392494), // LUBRICANTES MILENIUM
          LatLng(4.327457, -74.393079), //
          LatLng(4.326874, -74.395045), // CHEVROLET
          LatLng(4.326710, -74.395807), // CRUCE ARBELAEZ
          LatLng(4.326712, -74.409122), //
          LatLng(4.326567, -74.409448), //
          LatLng(4.328064, -74.409962), //
          LatLng(4.327237, -74.413051) //
        ],
      ),
    );
    PampaPekin.add(
      Polyline(
        polylineId: PolylineId("PampaPekin"),
        consumeTapEvents: true,
        endCap: Cap.buttCap,
        width: 3,
        geodesic: true,
        color: Colors.green,
        onTap: () {
          showDialog(
              context: context,
              builder: (buildcontext) {
                return AlertDialog(
                  title: Text("Pampa - Pekin"),
                  content: Text(
                      "Universidad - Hospital - Centro - Banco Popular - Pekin",
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
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
          log('Terminal - Pampa');
        },
        points: [
          //Pampa Pekin
          LatLng(4.346544, -74.352156), //
          LatLng(4.346429, -74.352526), //
          LatLng(4.345862, -74.353752), //
          LatLng(4.345747, -74.354329), //
          LatLng(4.345316, -74.356217), //
          LatLng(4.343575, -74.355887), //
          LatLng(4.344048, -74.357118), //
          LatLng(4.344199, -74.357261), //
          LatLng(4.344646, -74.357642), //
          LatLng(4.344678, -74.357806), //
          LatLng(4.344542, -74.357929), //
          LatLng(4.343481, -74.357843), //FILIPO PEKIN
          LatLng(4.343069, -74.359262), //GANAVICOLA
          LatLng(4.342719, -74.359953),
          LatLng(4.342565, -74.360626), // BANCO POPULAR
          LatLng(4.342576, -74.362031),
          LatLng(4.341895, -74.363761), // PALMAS - FILIPO
          LatLng(4.341573, -74.363178), // PARADERO FLIPO!!
          LatLng(4.341090, -74.363188), //
          LatLng(4.340405, -74.363079), // OPUS
          LatLng(4.339905, -74.362791), // LA 11
          LatLng(4.339247, -74.363676), // PUENTE DEL AGUILA
          LatLng(4.339058, -74.363904), // BOMBA PUENTE DEL AGUILA
          LatLng(4.337377, -74.365220), // LOZANO
          LatLng(4.336457, -74.365853), // CLINICA BELEN
          LatLng(4.335202, -74.367550), // LA 18 (LA MANZANA)
          LatLng(4.334012, -74.369272), // UNIVERSIDAD
          LatLng(4.333434, -74.370106), // LA 22 (EXITO)
          LatLng(4.333239, -74.370484), //
          LatLng(4.332715, -74.372294), // SAN MATEO
          LatLng(4.331808, -74.375153), // CC COLSUBSIDIO
          LatLng(4.331434, -74.377859), // INDIO
          LatLng(4.330331, -74.379049), // URBANIZACION EL ENCANTO
          LatLng(4.330026, -74.379524), // CRUCE ENCANTO
          LatLng(4.330106, -74.380267), //
          LatLng(4.330031, -74.380758), // PARRA
          LatLng(4.329879, -74.381544), // AUTOLAVADO CATAMA
          LatLng(4.329521, -74.383298), // MAMAJUANA
          LatLng(4.328927, -74.386071), // CRUCE VILLA PATRICIA
          LatLng(4.328654, -74.387409), // CC LA QUERENCIA
          LatLng(4.328294, -74.389183), // ENTRADA LA GRAN COLOMBIA
          LatLng(4.327858, -74.391164), //
          LatLng(4.327564, -74.392494), // LUBRICANTES MILENIUM
          LatLng(4.327457, -74.393079), //
          LatLng(4.326874, -74.395045), // CHEVROLET
          LatLng(4.326710, -74.395807), // CRUCE ARBELAEZ
          LatLng(4.326712, -74.409122), //
          LatLng(4.326567, -74.409448), //
          LatLng(4.328064, -74.409962), //
          LatLng(4.327237, -74.413051) //
        ],
      ),
    );
    PampaTerminal.add(
      Polyline(
        polylineId: PolylineId("PampaTerminal"),
        consumeTapEvents: true,
        endCap: Cap.buttCap,
        width: 3,
        geodesic: true,
        color: Colors.red,
        onTap: () {
          showDialog(
              context: context,
              builder: (buildcontext) {
                return AlertDialog(
                  title: Text("Pampa - Terminal"),
                  content: Text(" Universidad - Hospital - Centro - Galeria ",
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: TextStyle(fontSize: 20))),
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
          log('Pampa - Terminal');
        },
        points: [
          //PAMPA - TERMINAL

          LatLng(4.345739, -74.377461), // TERMINAL
          LatLng(4.343385, -74.376098), // CRUCE PALMAS
          LatLng(4.343321, -74.374435), //
          LatLng(4.343289, -74.372482), //
          LatLng(4.342829, -74.371087), // PALMAS DE HUPANEL
          LatLng(4.342155, -74.369049), // AGROMICOS ORIENTE
          LatLng(4.341706, -74.368223), //
          LatLng(4.341225, -74.367182), //
          LatLng(4.341054, -74.366238), // CRUCE PALMAS - SANTANITA
          LatLng(4.341054, -74.366238), // DAVIVIENDA PALMAS
          LatLng(4.341895, -74.363761), // COLEGIO SANTANDER
          LatLng(4.341895, -74.363761), // PALMAS - FILIPO
          LatLng(4.341573, -74.363178), // PARADERO FLIPO!!
          LatLng(4.341090, -74.363188), //
          LatLng(4.340405, -74.363079), // OPUS
          LatLng(4.339905, -74.362791), // LA 11
          LatLng(4.339247, -74.363676), // PUENTE DEL AGUILA
          LatLng(4.339058, -74.363904), // BOMBA PUENTE DEL AGUILA
          LatLng(4.337377, -74.365220), // LOZANO
          LatLng(4.336457, -74.365853), // CLINICA BELEN
          LatLng(4.335202, -74.367550), // LA 18 (LA MANZANA)
          LatLng(4.334012, -74.369272), // UNIVERSIDAD
          LatLng(4.333434, -74.370106), // LA 22 (EXITO)
          LatLng(4.333239, -74.370484), //
          LatLng(4.332715, -74.372294), // SAN MATEO
          LatLng(4.331808, -74.375153), // CC COLSUBSIDIO
          LatLng(4.331434, -74.377859), // INDIO
          LatLng(4.330331, -74.379049), // URBANIZACION EL ENCANTO
          LatLng(4.330026, -74.379524), // CRUCE ENCANTO
          LatLng(4.330106, -74.380267), //
          LatLng(4.330031, -74.380758), // PARRA
          LatLng(4.329879, -74.381544), // AUTOLAVADO CATAMA
          LatLng(4.329521, -74.383298), // MAMAJUANA
          LatLng(4.328927, -74.386071), // CRUCE VILLA PATRICIA
          LatLng(4.328654, -74.387409), // CC LA QUERENCIA
          LatLng(4.328294, -74.389183), // ENTRADA LA GRAN COLOMBIA
          LatLng(4.327858, -74.391164), //
          LatLng(4.327564, -74.392494), // LUBRICANTES MILENIUM
          LatLng(4.327457, -74.393079), //
          LatLng(4.326874, -74.395045), // CHEVROLET
          LatLng(4.326710, -74.395807), // CRUCE ARBELAEZ
          LatLng(4.326712, -74.409122), //
          LatLng(4.326567, -74.409448), //
          LatLng(4.328064, -74.409962), //
          LatLng(4.327237, -74.413051) //
        ],
      ),
    );
  }
}
