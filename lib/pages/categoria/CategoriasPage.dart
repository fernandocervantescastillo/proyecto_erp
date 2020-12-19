import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/pages/reciclers/fondo_pantalla.dart';
import 'package:proyecto_erp/providers/Provider.dart';

import 'EditCategoria.dart';
import 'NewCategoria.dart';
import '../proveedor/NewProveedor.dart';

class CategoriasPage extends StatefulWidget{
  CategoriasPage_ createState() => CategoriasPage_();
}

class CategoriasPage_ extends State<CategoriasPage> {

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(title: Text('Categorias')),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewCategoriaPage()),).then((value) => setState(() {}))
        }
    );
  }

}



class FutureBuilderState extends StatelessWidget{
  final CategoriasPage_ categoriasPage_;

  FutureBuilderState(this.categoriasPage_);

  Provider provider;
  @override
  Widget build(Object context) {
    provider = new Provider();
    return FutureBuilder<List<Categoria>>(
      future: provider.categoriaGetLista(),
      builder: (BuildContext context, AsyncSnapshot<List<Categoria>> snapshot) {
        if (snapshot.hasData) {
          final categorias = snapshot.data;
          return ListView.builder(
            itemCount: categorias.length, //los n elementos
            itemBuilder: (context, i) => _builTripCard(
                context, categorias[i]), //un objeto en especifico
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

  Widget _builTripCard(BuildContext context, Categoria categoria) {
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
                    Text('${ categoria.nombre }',
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
                    Text('Descripción: ${ categoria.descripcion }',
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditCategoriaPage(categoria:categoria)),).then((value) => categoriasPage_.setState(() {}))
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