import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class PaginaHorarios extends StatefulWidget {
  @override
  _PaginaHorarios createState() => new _PaginaHorarios();
}

class _PaginaHorarios extends State<PaginaHorarios> {
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
        title: Text("Horarios de trabajo"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.timer),
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
          crossAxisCount: 1,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.local_florist,
                        size: 120.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("FUSAGASUGÁ",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 25),
                              fontWeight: FontWeight.bold)),
                      Text(" "),
                      Text("Lunes a domingo   5 am - 9 pm",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.italiana(
                              textStyle: TextStyle(fontSize: 17),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.history,
                        size: 120.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("PASCA",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17),
                              fontWeight: FontWeight.bold)),
                      Text(" "),
                      Text("Lunes a domingo   5 am - 8 pm",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.italiana(
                              textStyle: TextStyle(fontSize: 17),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.landscape,
                        size: 120.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("SILVANIA",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 18),
                              fontWeight: FontWeight.bold)),
                      Text(" "),
                      Text("Lunes a domingo   5 am - 7 pm",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.italiana(
                              textStyle: TextStyle(fontSize: 17),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.cloud,
                        size: 120.0,
                        color: Color(0xFF53379d),
                      ),
                      Text("ARBELAEZ",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 17),
                              fontWeight: FontWeight.bold)),
                      Text(" "),
                      Text("Lunes a domingo   6 am - 8 pm",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.italiana(
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
