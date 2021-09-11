import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'main.dart';

class PaginaParaderos extends StatefulWidget {
  PaginaParaderos({Key key, this.title = ''}) : super(key: key);
  final String title;
  @override
  _PaginaParaderos createState() => new _PaginaParaderos();
}

class _PaginaParaderos extends State<PaginaParaderos> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition camaraPosicion =
      CameraPosition(target: LatLng(4.33646, -74.36378), zoom: 14.4746);

  Set<Marker> _markers = {};
  LatLng paraderoTerminal = LatLng(4.345400, -74.378121);
  LatLng paraderoFilipo = LatLng(4.341599, -74.363211);
  LatLng paraderoPekin = LatLng(4.345999, -74.353294);
  LatLng paraderoPabloBello = LatLng(4.323922, -74.362025);
  LatLng paraderoPampa = LatLng(4.325549, -74.413414);
  LatLng paraderoPasca = LatLng(4.341062, -74.364267);
  LatLng paraderoArbelaez = LatLng(4.345877, -74.377761);
  LatLng paraderoSilvania = LatLng(4.341062, -74.364267);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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
        title: Text("Paraderos"),
        actions: [
          IconButton(
            icon: Icon(Icons.traffic),
            onPressed: () {},
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
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        myLocationEnabled: true,
        initialCameraPosition: camaraPosicion,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers.add(Marker(
              markerId: MarkerId('paraderoTerminal'),
              position: paraderoTerminal,
              infoWindow: InfoWindow(
                  title: 'Paradero Terminal',
                  snippet: 'Terminal de transporte'),
            ));
            _markers.add(Marker(
              markerId: MarkerId('ParaderoPasca'),
              position: paraderoPasca,
              infoWindow:
                  InfoWindow(title: 'Paradero Pasca', snippet: 'Cl 10 #9-55'),
            ));
            _markers.add(Marker(
              markerId: MarkerId('paraderoArbelaez'),
              position: paraderoArbelaez,
              infoWindow: InfoWindow(
                  title: 'Paradero Arbelaez',
                  snippet: 'Terminal de transporte'),
            ));
            _markers.add(Marker(
              markerId: MarkerId('paraderoFilipo'),
              position: paraderoFilipo,
              infoWindow:
                  InfoWindow(title: 'Paradero Filipo', snippet: 'Cra 8 #9-43'),
            ));
            _markers.add(Marker(
              markerId: MarkerId('paraderoPekin'),
              position: paraderoPekin,
              infoWindow:
                  InfoWindow(title: 'Paradero Pekin', snippet: 'Cl 5 #6 este'),
            ));
            _markers.add(Marker(
              markerId: MarkerId('paraderoPabloBello'),
              position: paraderoPabloBello,
              infoWindow: InfoWindow(
                  title: 'Paradero Pablo Bello', snippet: 'Cl 26 #2'),
            ));
            _markers.add(Marker(
              markerId: MarkerId('paraderoSilvania'),
              position: paraderoSilvania,
              infoWindow: InfoWindow(
                  title: 'Paradero Silvania', snippet: 'Cl 8a #7-83'),
            ));
            _markers.add(Marker(
              markerId: MarkerId('paraderoPampa'),
              position: paraderoPampa,
              infoWindow:
                  InfoWindow(title: 'Paradero Pampa', snippet: 'Cl 24 #78'),
            ));
          });
        },
      ),
    );
  }
}
