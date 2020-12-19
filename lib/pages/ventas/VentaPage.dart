

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_erp/pages/reciclers/fondo_pantalla.dart';

class VentaPage extends StatefulWidget{
  VentaPage_ createState() => VentaPage_();
}

class VentaPage_ extends State<VentaPage> {

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(title: Text('Venta')),
      body: Stack(
        children: <Widget>[
          fondoPantalla(),
          //FutureBuilderState(this),
        ],

      ),
      //floatingActionButton: crearFloatingActionButton(context),
    );
  }
}