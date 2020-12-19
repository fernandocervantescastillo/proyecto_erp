import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/pages/NewProducto.dart';
import 'package:proyecto_erp/pages/reciclers/fondo_pantalla.dart';
import 'package:proyecto_erp/providers/Provider.dart';
import 'EditSucursal.dart';
import 'NewSucursal.dart';


class SucursalPage extends StatefulWidget{
  SucursalPage_ createState() => SucursalPage_();
}

class SucursalPage_ extends State<SucursalPage> {

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(title: Text('Sucursal')),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewSucursalPage()),).then((value) => setState(() {}))
        }
    );
  }

}








class FutureBuilderState extends StatelessWidget{
  final SucursalPage_ sucursalPage_;
  Timer _timer;

  FutureBuilderState(this.sucursalPage_);

  Provider provider;
  @override
  Widget build(Object context) {
    provider = new Provider();
    return FutureBuilder<List<Sucursal>>(
      future: provider.sucursalGetLista(),
      builder: (BuildContext context, AsyncSnapshot<List<Sucursal>> snapshot) {
        if (snapshot.hasData) {
          final sucursal = snapshot.data;
          return ListView.builder(
            itemCount: sucursal.length, //los n elementos
            itemBuilder: (context, i) => _builTripCard(
                context, sucursal[i]), //un objeto en especifico
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

  Widget _builTripCard(BuildContext context, Sucursal sucursal) {
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
                    Text('${ sucursal.nombre }',
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
                  padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                  child: Row(children: <Widget>[
                    Text('City id: ${ sucursal.city_id }',
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
                      child: Icon(Icons.edit),
                      textColor: Colors.white,
                      color: Colors.deepPurple,
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditSucursalPage(sucursal:sucursal)),).then((value) => sucursalPage_.setState(() {}))
                      },
                    ),
                    Spacer(),
                    RaisedButton(
                      child: Icon(Icons.delete),
                      textColor: Colors.white,
                      color: Colors.deepPurple,
                      onPressed: () => {
                        deleteItem(sucursal, context),
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

  void deleteItem(Sucursal sucursal, BuildContext context22){
    showDialog(
      context: sucursalPage_.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Eliminar item?", style: TextStyle(color: Colors.white),),
          content: Text("Esta seguro?", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepPurple,
          actions: [
            FlatButton(
              child: Text("Si", style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop(); // dismiss dialog
                llamar(sucursal, context22);
              },
            ),
            FlatButton(
              child: Text("No", style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop(); // dismiss dialog
              },
            ),
          ],
        );
      },
    );
  }


  void llamar(Sucursal sucursal, BuildContext context) async {

    Provider provider = new Provider();
    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');

      String t = await provider.sucursalEliminar(sucursal);

      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se elimino el sucursal"),));
      sucursalPage_.setState(() { });
    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));
    }
  }
}