import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Rol.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/pages/NewProducto.dart';
import 'package:proyecto_erp/pages/reciclers/fondo_pantalla.dart';
import 'package:proyecto_erp/providers/Provider.dart';



class RolPage extends StatefulWidget{
  RolPage_ createState() => RolPage_();
}

class RolPage_ extends State<RolPage> {

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(title: Text('Roles')),
      body: Stack(
        children: <Widget>[
          fondoPantalla(),
          FutureBuilderState(this),
        ],

      ),
      //floatingActionButton: crearFloatingActionButton(context),
    );
  }

  /*
  crearFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () =>
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewSucursalPage()),).then((value) => setState(() {}))
        }
    );
  }
*/

}



class FutureBuilderState extends StatelessWidget{
  final RolPage_ rolPage_;
  Timer _timer;

  FutureBuilderState(this.rolPage_);

  Provider provider;
  @override
  Widget build(Object context) {
    provider = new Provider();
    return FutureBuilder<List<Rol>>(
      future: provider.rolGetLista(),
      builder: (BuildContext context, AsyncSnapshot<List<Rol>> snapshot) {
        if (snapshot.hasData) {
          final rol = snapshot.data;
          return ListView.builder(
            itemCount: rol.length, //los n elementos
            itemBuilder: (context, i) => _builTripCard(
                context, rol[i]), //un objeto en especifico
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

  Widget _builTripCard(BuildContext context, Rol rol) {
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
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                  child: Row(children: <Widget>[
                    Text('${ rol.name }',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        //color: Color(0xff00BCD4).withOpacity(0.5),
                      ),
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