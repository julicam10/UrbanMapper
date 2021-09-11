import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:um/inicio.dart';
import 'inicio.dart';
import 'registro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Urban Mapper',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        buttonTheme: ButtonThemeData(height: 36),
        dividerColor: Color(0xFFb3d7ff),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaginaIncio(),
    );
  }
}

MediaQueryData queryData;

class PaginaIncio extends StatefulWidget {
  @override
  _PaginaIncio createState() => new _PaginaIncio();
}

class _PaginaIncio extends State<PaginaIncio> {
  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    return Scaffold(
        body: Center(
      child: Container(
          height: 2000,
          width: 2000,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF2c69b8), Color(0xFF800080)],
                  //stops: [0.3,0.5],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("BIENVENIDO",
                  style: TextStyle(color: Colors.white, fontSize: 38.0)),
              Text("URBAN MAPPER",
                  style: TextStyle(color: Colors.white, fontSize: 38.0)),
              Text(""),
              Text(""),
              OutlineButton(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                child: Text("CREAR CUENTA",
                    style: TextStyle(fontSize: 23.0, color: Colors.white)),
                shape: StadiumBorder(),
                //onPressed: () => _pushPage(context, PaginaRegistro())
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaginaRegistro()));
                },
              ),
              OutlineButton(
                borderSide: BorderSide(color: Colors.white, width: 1.5),
                child: Text("INGRESAR CON CUENTA",
                    style: TextStyle(fontSize: 23.0, color: Colors.white)),
                shape: StadiumBorder(),
                //onPressed: () => _pushPage(context, PaginaLogin())
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaginaLogin()));
                },
              ),
            ],
          )),
    ));
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
