import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/pages/reciclers/fondo_pantalla.dart';
import 'package:proyecto_erp/providers/Provider.dart';

import 'NewProveedor.dart';




class ProveedoresPage extends StatefulWidget{
  ProveedoresPage_ createState() => ProveedoresPage_();
}

class ProveedoresPage_ extends State<ProveedoresPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Proveedores')),
      body: Stack(
        children: <Widget>[
          fondoPantalla(),
          FutureBuilderState(),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewProveedorPage()),).then((value) => setState(() {}))
        }
    );
  }

}



class FutureBuilderState extends StatelessWidget{
  Provider provider;

  @override
  Widget build(Object context) {
    provider = new Provider();
    return FutureBuilder<List<Proveedor>>(
      future: provider.proveedorGetLista(),
      builder: (BuildContext context, AsyncSnapshot<List<Proveedor>> snapshot) {
        if (snapshot.hasData) {
          final proveedores = snapshot.data;
          return ListView.builder(
            itemCount: proveedores.length, //los n elementos
            itemBuilder: (context, i) => _builTripCard(
                context, proveedores[i]), //un objeto en especifico
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

  Widget _builTripCard(BuildContext context, Proveedor proveedor) {
    return Container(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            /*image: DecorationImage(
                image: NetworkImage("https://picsum.photos/250?image=9"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                //alignment: Alignment.topCenter
              )*/
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text('${ proveedor.empresa }',
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
                    Text('Dirección: ${ proveedor.direccion }',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    Spacer(),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(children: <Widget>[
                    Text('Teléfono: ${ proveedor.telefono }',
                        style: TextStyle(fontSize: 25.0)),
                    Spacer(),
                  ],),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}