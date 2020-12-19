import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Almacen.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/CompraProducto.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/pages/NewProducto.dart';
import 'package:proyecto_erp/pages/almacen/NewAlmacen.dart';
import 'package:proyecto_erp/pages/reciclers/fondo_pantalla.dart';
import 'package:proyecto_erp/providers/Provider.dart';




class CompraProductoPage extends StatefulWidget {

  final List<CompraProducto> compraProductos;

  const CompraProductoPage({Key key, this.compraProductos}) : super(key: key);
  @override
  _CompraProductoPage createState() => _CompraProductoPage();
}

class _CompraProductoPage extends State<CompraProductoPage> {

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de la compra')),
      body: Stack(
        children: <Widget>[
          fondoPantalla(),
          FutureBuilderState(this.widget.compraProductos),
        ],

      ),
    );
  }

}


class FutureBuilderState extends StatelessWidget{
  List<CompraProducto> compraProductos;

  FutureBuilderState (List<CompraProducto> compraProductos){
    this.compraProductos = compraProductos;
  }

  @override
  Widget build(Object context) {
    return ListView.builder(
                itemCount: compraProductos.length, //los n elementos
                itemBuilder: (context, i) => _builTripCard(context, compraProductos[i]), //un objeto en especifico
          );

  }

  Widget _builTripCard(BuildContext context, CompraProducto compraProducto) {
    return Container(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text('${ compraProducto.nombre }',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        //color: Color(0xff00BCD4).withOpacity(0.5),
                      ),
                    ),
                    Spacer(),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text('Cantidad: ${ compraProducto.cantidad.toString() }',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    Spacer(),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                  child: Row(children: <Widget>[
                    Text('Costo por unidad: ${ compraProducto.costo_por_unidad.toString() }',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    Spacer(),
                  ],),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
