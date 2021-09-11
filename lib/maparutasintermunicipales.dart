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

class PaginaMapasRutasInter extends StatefulWidget {
  String value;
  PaginaMapasRutasInter(this.value);

  @override
  _PaginaMapasRutasInter createState() => new _PaginaMapasRutasInter();
}

class _PaginaMapasRutasInter extends State<PaginaMapasRutasInter> {
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

  Set<Polyline> Arbelaez = {};
  Set<Polyline> Pasca = {};
  Set<Polyline> Silvania = {};
  Set<Polyline> Prueba = {};

  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDnJuODuBzsoUflKVwyxD-_uTK4HThyRyg");

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
          title: Text("Ruta Intermunicipales"),
          actions: [
            IconButton(
              icon: Icon(Icons.train),
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
    if (this.widget.value == "Arbelaez") {
      Arbelaez = Prueba;
      log('valor: Pekin');
    } else if (this.widget.value == "Pasca") {
      Pasca = Prueba;
      log('valor: Terminal');
    } else if (this.widget.value == "Silvania") {
      Silvania = Prueba;
      log('valor: Pampa');
    }
    super.initState();
    Arbelaez.add(
      Polyline(
        polylineId: PolylineId("Arbelaez"),
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
                  title: Text("Fusagasugá - Arbelaez"),
                  content: Text("Centro Fusagasugá - Centro Arbelaez!",
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
          LatLng(4.325399, -74.396467), //
          LatLng(4.324859, -74.395692), //
          LatLng(4.324209, -74.394697), //
          LatLng(4.323286, -74.392178), //
          LatLng(4.323233, -74.391880), //
          LatLng(4.323169, -74.390662), //
          LatLng(4.322126, -74.389291), //
          LatLng(4.321829, -74.389106), //
          LatLng(4.321192, -74.389058), //
          LatLng(4.320713, -74.388385), //
          LatLng(4.320241, -74.388782), //
          LatLng(4.320241, -74.388782), //
          LatLng(4.320185, -74.389723),
          LatLng(4.320018, -74.390280), //
          LatLng(4.320133, -74.390921), //
          LatLng(4.319253, -74.391782), //
          LatLng(4.318148, -74.393204), //
          LatLng(4.317388, -74.393250), //
          LatLng(4.317150, -74.393424), //
          LatLng(4.316714, -74.394097), //
          LatLng(4.315930, -74.394430), //
          LatLng(4.315965, -74.394827), //
          LatLng(4.316527, -74.395452), //
          LatLng(4.316663, -74.396651), //
          LatLng(4.317128, -74.398032), //
          LatLng(4.316769, -74.398967), //
          LatLng(4.314355, -74.399617), //
          LatLng(4.313648, -74.400128), //
          LatLng(4.312690, -74.400482), //
          LatLng(4.312203, -74.401463), //
          LatLng(4.307102, -74.403668), //
          LatLng(4.306294, -74.404145), //
          LatLng(4.305652, -74.404070), //
          LatLng(4.304844, -74.404730),
          LatLng(4.301410, -74.405926), //
          LatLng(4.300051, -74.407975), //
          LatLng(4.299200, -74.409423), //
          LatLng(4.298922, -74.408811), //
          LatLng(4.298034, -74.408081), //
          LatLng(4.297777, -74.407180), //
          LatLng(4.297413, -74.407180), //
          LatLng(4.296418, -74.409186), //
          LatLng(4.296108, -74.409089), //
          LatLng(4.295841, -74.408038), //
          LatLng(4.295434, -74.408177), //
          LatLng(4.295787, -74.408703), //
          LatLng(4.295669, -74.410430), //
          LatLng(4.295819, -74.410741), //
          LatLng(4.295477, -74.410612), //
          LatLng(4.295370, -74.409378), //
          LatLng(4.294931, -74.408648), //
          LatLng(4.294931, -74.408648), //
          LatLng(4.294139, -74.407167), //
          LatLng(4.294182, -74.406480), //
          LatLng(4.293850, -74.406362),
          LatLng(4.292459, -74.406727), //
          LatLng(4.292085, -74.405890), //
          LatLng(4.291636, -74.405815), //
          LatLng(4.290876, -74.406448), //
          LatLng(4.291058, -74.407467), //
          LatLng(4.291796, -74.407821), //
          LatLng(4.291668, -74.408551), //
          LatLng(4.289592, -74.408637), //
          LatLng(4.289239, -74.407510), //
          LatLng(4.288009, -74.407928), //
          LatLng(4.285933, -74.407488), //
          LatLng(4.285419, -74.407778), //
          LatLng(4.285858, -74.409977), //
          LatLng(4.285505, -74.410031), //
          LatLng(4.284991, -74.409516), //
          LatLng(4.283975, -74.409945), //
          LatLng(4.284157, -74.410921), //
          LatLng(4.283964, -74.411264), //
          LatLng(4.283878, -74.411961), //
          LatLng(4.283193, -74.412315), //
          LatLng(4.282572, -74.411886),
          LatLng(4.282946, -74.410631), //
          LatLng(4.282186, -74.410095), //
          LatLng(4.282143, -74.410138), //
          LatLng(4.281790, -74.410481), //
          LatLng(4.281619, -74.410159), //
          LatLng(4.282031, -74.409800), //
          LatLng(4.281475, -74.409655), //
          LatLng(4.280753, -74.408893), //
          LatLng(4.280598, -74.408973), //
          LatLng(4.280598, -74.409418), //
          LatLng(4.279309, -74.410271), //
          LatLng(4.278357, -74.409949), //
          LatLng(4.277624, -74.409686), //
          LatLng(4.276602, -74.409949), //
          LatLng(4.276591, -74.410239), //
          LatLng(4.276992, -74.410834), //
          LatLng(4.276987, -74.410904), //
          LatLng(4.276368, -74.411408), //
          LatLng(4.275407, -74.414704), // TURIN PLAZA
          LatLng(4.274626, -74.414371), //
          LatLng(4.274185, -74.413733), //
          LatLng(4.272912, -74.414479), // FINAL
        ],
      ),
    );
    Silvania.add(
      Polyline(
        polylineId: PolylineId("Silvania"),
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
                  title: Text("Fusagasugá - Silvania"),
                  content: Text("Centro Fusagasugá - Centro Silvania!",
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
        },
        points: [
          LatLng(4.342586, -74.362932),
          LatLng(4.342742, -74.362943),
          LatLng(4.342709, -74.363282),
          LatLng(4.342518, -74.363954),
          LatLng(4.341870, -74.364664),
          LatLng(4.342785, -74.365141),
          LatLng(4.343400, -74.365243),
          LatLng(4.344074, -74.365302),
          LatLng(4.346693, -74.365319),
          LatLng(4.346968, -74.364457),
          LatLng(4.346937, -74.364448),
          LatLng(4.347135, -74.364620),
          LatLng(4.347330, -74.365342),
          LatLng(4.348503, -74.365935),
          LatLng(4.348845, -74.366442),
          LatLng(4.350659, -74.366855),
          LatLng(4.350894, -74.366735),
          LatLng(4.350983, -74.366498),
          LatLng(4.351309, -74.366514),
          LatLng(4.351662, -74.367759),
          LatLng(4.352090, -74.368939),
          LatLng(4.352170, -74.369352),
          LatLng(4.353582, -74.369475),
          LatLng(4.354642, -74.370119),
          LatLng(4.356790, -74.371746),
          LatLng(4.357037, -74.372407),
          LatLng(4.358566, -74.373718),
          LatLng(4.360342, -74.374893), //HACIENDA BETANIA
          LatLng(4.361688, -74.375874),
          LatLng(4.361729, -74.376134),
          LatLng(4.360959, -74.377679),
          LatLng(4.361055, -74.379063),
          LatLng(4.364061, -74.382657),
          LatLng(4.365449, -74.383043),
          LatLng(4.365942, -74.382685),
          LatLng(4.366667, -74.381931),
          LatLng(4.367424, -74.382154),
          LatLng(4.368070, -74.382731),
          LatLng(4.369483, -74.384955),
          LatLng(4.370058, -74.385335),
          LatLng(4.374116, -74.387261),
          LatLng(4.376561, -74.389319),
          LatLng(4.377524, -74.389233),
          LatLng(4.381311, -74.385263),
          LatLng(4.384306, -74.384973),
          LatLng(4.384959, -74.385799),
          LatLng(4.384232, -74.389930),
          LatLng(4.385163, -74.390917),
          LatLng(4.393068, -74.391486),
          LatLng(4.395507, -74.390241),
          LatLng(4.396983, -74.388621),
          LatLng(4.399732, -74.387237),
          LatLng(4.400620, -74.386422),
          LatLng(4.402214, -74.383933),
          LatLng(4.403829, -74.383375),
          LatLng(4.404032, -74.383536),
          LatLng(4.403904, -74.383831),
          LatLng(4.403738, -74.383858),
          LatLng(4.403767, -74.384628),
          LatLng(4.403500, -74.385768),
          LatLng(4.404195, -74.386451),
          LatLng(4.403229, -74.387852),
          LatLng(4.402836, -74.388222)
        ],
      ),
    );
    Pasca.add(
      Polyline(
        polylineId: PolylineId("Pasca"),
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
                  title: Text("Fusagasugá - Pasca"),
                  content: Text("Fusagasugá - Pasca!",
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
        },
        points: [
          LatLng(4.341041, -74.364362), // TERMINAL
          LatLng(4.341052, -74.364569), // CRUCE PALMAS
          LatLng(4.341523, -74.364574), //
          LatLng(4.341843, -74.363925),
          LatLng(4.341895, -74.363761), // PALMAS - FILIPO
          LatLng(4.342576, -74.362031),
          LatLng(4.342565, -74.360626), // BANCO POPULAR
          LatLng(4.342719, -74.359953),
          LatLng(4.343069, -74.359262), //GANAVICOLA
          LatLng(4.343481, -74.357843), //FILIPO PEKIN
          LatLng(4.343679, -74.357467),
          LatLng(4.343113, -74.356072),
          LatLng(4.343583, -74.355887),
          LatLng(4.343298, -74.355177),
          LatLng(4.342431, -74.354737),
          LatLng(4.342212, -74.354828),
          LatLng(4.342014, -74.355193),
          LatLng(4.341407, -74.355332),
          LatLng(4.340415, -74.354328),
          LatLng(4.339936, -74.354529),
          LatLng(4.339623, -74.354467),
          LatLng(4.338858, -74.354612),
          LatLng(4.338690, -74.354515),
          LatLng(4.338703, -74.354225),
          LatLng(4.338833, -74.353880),
          LatLng(4.338826, -74.353496),
          LatLng(4.338620, -74.353434),
          LatLng(4.338144, -74.353799),
          LatLng(4.337606, -74.353662),
          LatLng(4.336961, -74.354515),
          LatLng(4.336220, -74.354689),
          LatLng(4.335766, -74.354544),
          LatLng(4.334423, -74.353501),
          LatLng(4.334164, -74.353096),
          LatLng(4.333952, -74.352716),
          LatLng(4.333674, -74.352469),
          LatLng(4.333289, -74.352482),
          LatLng(4.332907, -74.351986),
          LatLng(4.332797, -74.351565),
          LatLng(4.332944, -74.351023),
          LatLng(4.332749, -74.350862),
          LatLng(4.331409, -74.350967),
          LatLng(4.330272, -74.351064),
          LatLng(4.330095, -74.350895),
          LatLng(4.330167, -74.350667),
          LatLng(4.330539, -74.350251),
          LatLng(4.330459, -74.350162),
          LatLng(4.330026, -74.349998),
          LatLng(4.329839, -74.349663),
          LatLng(4.329884, -74.349416),
          LatLng(4.330525, -74.348378),
          LatLng(4.330405, -74.348185),
          LatLng(4.329910, -74.348174),
          LatLng(4.329281, -74.347976),
          LatLng(4.329115, -74.347775),
          LatLng(4.329107, -74.347421),
          LatLng(4.328971, -74.347365),
          LatLng(4.328345, -74.347381),
          LatLng(4.327869, -74.347703),
          LatLng(4.327829, -74.347730),
          LatLng(4.327302, -74.347422),
          LatLng(4.327075, -74.346735),
          LatLng(4.326345, -74.346146),
          LatLng(4.326166, -74.345620),
          LatLng(4.325430, -74.345180),
          LatLng(4.325066, -74.344735),
          LatLng(4.323616, -74.344274),
          LatLng(4.322894, -74.343366),
          LatLng(4.322584, -74.342982),
          LatLng(4.322552, -74.342864),
          LatLng(4.322669, -74.342166),
          LatLng(4.322733, -74.341697),
          LatLng(4.322958, -74.341358),
          LatLng(4.323118, -74.341111),
          LatLng(4.322909, -74.340615),
          LatLng(4.323077, -74.340116),
          LatLng(4.322959, -74.339920),
          LatLng(4.322667, -74.339831),
          LatLng(4.322140, -74.340164),
          LatLng(4.321594, -74.340384),
          LatLng(4.321589, -74.340389),
          LatLng(4.321022, -74.340413),
          LatLng(4.320819, -74.340311),
          LatLng(4.319939, -74.339638),
          LatLng(4.319869, -74.339246),
          LatLng(4.319995, -74.338991),
          LatLng(4.320147, -74.338873),
          LatLng(4.320612, -74.338766),
          LatLng(4.320724, -74.338648),
          LatLng(4.320751, -74.338517),
          LatLng(4.320203, -74.337632),
          LatLng(4.320029, -74.337179),
          LatLng(4.320013, -74.336350),
          LatLng(4.320173, -74.335862),
          LatLng(4.319737, -74.335521),
          LatLng(4.319622, -74.335290),
          LatLng(4.319828, -74.334636),
          LatLng(4.320331, -74.334057),
          LatLng(4.320406, -74.333943),
          LatLng(4.320518, -74.333602),
          LatLng(4.320582, -74.333157),
          LatLng(4.320109, -74.332894),
          LatLng(4.320050, -74.332722),
          LatLng(4.320641, -74.331300),
          LatLng(4.320735, -74.331182),
          LatLng(4.320994, -74.331026),
          LatLng(4.321368, -74.330828),
          LatLng(4.321545, -74.330509),
          LatLng(4.321620, -74.330144),
          LatLng(4.321941, -74.329543),
          LatLng(4.322139, -74.328508),
          LatLng(4.322551, -74.327854),
          LatLng(4.322527, -74.327747),
          LatLng(4.322391, -74.327251),
          LatLng(4.322360, -74.326845),
          LatLng(4.322002, -74.326204),
          LatLng(4.321927, -74.324930),
          LatLng(4.320896, -74.322191),
          LatLng(4.321121, -74.321676),
          LatLng(4.321014, -74.321520),
          LatLng(4.320070, -74.321674),
          LatLng(4.320005, -74.321654),
          LatLng(4.318958, -74.320703),
          LatLng(4.318015, -74.319862),
          LatLng(4.317587, -74.319513),
          LatLng(4.316904, -74.319640),
          LatLng(4.316331, -74.319151),
          LatLng(4.315743, -74.319281),
          LatLng(4.315956, -74.319208),
          LatLng(4.315710, -74.319267),
          LatLng(4.315539, -74.319085),
          LatLng(4.315457, -74.318233),
          LatLng(4.315111, -74.317439),
          LatLng(4.314832, -74.316770),
          LatLng(4.314272, -74.315491),
          LatLng(4.314181, -74.314942),
          LatLng(4.313879, -74.314467),
          LatLng(4.313858, -74.313110),
          LatLng(4.313858, -74.312895),
          LatLng(4.313941, -74.312426),
          LatLng(4.313885, -74.312174),
          LatLng(4.313545, -74.311739),
          LatLng(4.313141, -74.311420),
          LatLng(4.313093, -74.311366),
          LatLng(4.313093, -74.311366),
          LatLng(4.313356, -74.309993),
          LatLng(4.313185, -74.309462),
          LatLng(4.313161, -74.308867),
          LatLng(4.312803, -74.307875),
          LatLng(4.312303, -74.306818),
          LatLng(4.312140, -74.306153),
          LatLng(4.311800, -74.305496),
          LatLng(4.311619, -74.305160),
          LatLng(4.311170, -74.304784),
          LatLng(4.311250, -74.303443),
          LatLng(4.311217, -74.302861),
          LatLng(4.310922, -74.301896),
          LatLng(4.310572, -74.301558),
          LatLng(4.310366, -74.301317),
          LatLng(4.310321, -74.300718),
          LatLng(4.309842, -74.299957),
          LatLng(4.309445, -74.300024),
          LatLng(4.309001, -74.300247),
          LatLng(4.308835, -74.300345)
        ],
      ),
    );
  }
}
