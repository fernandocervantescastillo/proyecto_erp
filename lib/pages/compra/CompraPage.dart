import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Almacen.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Compra.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/pages/NewProducto.dart';
import 'package:proyecto_erp/pages/almacen/NewAlmacen.dart';
import 'package:proyecto_erp/pages/reciclers/fondo_pantalla.dart';
import 'package:proyecto_erp/providers/Provider.dart';

import 'ListarCompraProducto.dart';



class CompraPage extends StatefulWidget{
  CompraPage_ createState() => CompraPage_();
}

class CompraPage_ extends State<CompraPage> {

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(title: Text('Compras')),
      body: Stack(
        children: <Widget>[
          fondoPantalla(),
          FutureBuilderState(this),
        ],

      ),
      floatingActionButton: crearFloatingActionButton(context),
    );
  }

  crearFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () =>
        {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => NewCompraPage()),).then((value) => setState(() {}))
        }
    );
  }

}








class FutureBuilderState extends StatelessWidget{
  final CompraPage_ compraPage_;
  Timer _timer;

  FutureBuilderState(this.compraPage_);

  Provider provider;
  @override
  Widget build(Object context) {
    provider = new Provider();
    return FutureBuilder<List<Compra>>(
      future: provider.compraGetLista(),
      builder: (BuildContext context, AsyncSnapshot<List<Compra>> snapshot) {
        if (snapshot.hasData) {
          final compras = snapshot.data;
          return ListView.builder(
            itemCount: compras.length, //los n elementos
            itemBuilder: (context, i) => _builTripCard(
                context, compras[i]), //un objeto en especifico
          );
        }else if (snapshot.hasError) {
          return Column(
              children:<Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.error,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('${snapshot.error}',style: TextStyle(fontSize: 12),),
                    )
                ),

              ]
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Widget _builTripCard(BuildContext context, Compra compra) {
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
                    Text('Compra: ${ compra.id }',
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
                    Text('Cantidad de productos: ${ compra.productos.length.toString() }',
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
                    Text('Costo total: ${ compra.costoTotal.toString() }',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    Spacer(),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    RaisedButton(
                      child: Icon(Icons.library_books),
                      textColor: Colors.white,
                      color: Colors.deepPurple,
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CompraProductoPage(compraProductos:compra.productos)),)
                      },
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