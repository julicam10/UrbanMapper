import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class PaginaGuiaUm extends StatefulWidget {
  @override
  _PaginaGuiaUm createState() => new _PaginaGuiaUm();
}

class _PaginaGuiaUm extends State<PaginaGuiaUm> {
  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    queryData.size.width;
    queryData.size.height;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
          ),
          Container(
            height: 650,
            width: queryData.size.height,
            child: Image.asset('assets/images/imagenuno.jpeg'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
          ),
          Container(
            height: 650,
            width: queryData.size.height,
            child: Image.asset('assets/images/imagendos.jpeg'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
          ),
          Container(
            height: 650,
            width: queryData.size.height,
            child: Image.asset('assets/images/imagentres.jpeg'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
          ),
          Container(
            height: 650,
            width: queryData.size.height,
            child: Image.asset('assets/images/imagencuatro.jpeg'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      ),
    );
  }
}
