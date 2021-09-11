import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:um/menu.dart';
import 'configuracion.dart';
import 'guiaurban.dart';
import 'main.dart';

class PaginaUbicacion extends StatefulWidget {
  final User user;
  const PaginaUbicacion({Key key, this.user}) : super(key: key);
  @override
  _PaginaUbicacion createState() => new _PaginaUbicacion();
}

class _PaginaUbicacion extends State<PaginaUbicacion> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<ScreenHiddenDrawer> items = new List();

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Menú",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20.0),
          colorLineSelected: Colors.white,
        ),
        PaginaMenu()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Tu Guía",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20.0),
          colorLineSelected: Colors.white,
        ),
        PaginaGuiaUm()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    return HiddenDrawerMenu(
      backgroundColorMenu: Color(0xFF53379d),
      backgroundColorAppBar: Color(0xFF53379d),
      screens: items,
      slidePercent: 30.0,
      contentCornerRadius: 40.0,
      verticalScalePercent: 90.0,
      //    typeOpen: TypeOpen.FROM_RIGHT,
      //    disableAppBarDefault: false,
      //    enableScaleAnimin: true,
      //    enableCornerAnimin: true,
      //    iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //    styleAutoTittleName: TextStyle(color: Colors.red),
      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
      //    elevationAppBar: 4.0,
      //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
      //    enableShadowItensMenu: true,
      //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}
