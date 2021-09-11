import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class PaginaTarifa extends StatefulWidget {
  @override
  _PaginaTarifa createState() => new _PaginaTarifa();
}

class _PaginaTarifa extends State<PaginaTarifa> {
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
        title: Text("Tarifa de pasajes"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.attach_money),
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
                      Text("Sector urbano                           1700",
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
                      Text("Paradero - Centro Pasca       2800",
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
                      Text("Paradero - Centro Silvania    2700",
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
                      Text("Paradero - Centro Arbelaez     3500",
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
