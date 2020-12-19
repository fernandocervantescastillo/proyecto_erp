import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Rol.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/Usuario.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/pages/NewProducto.dart';
import 'package:proyecto_erp/pages/reciclers/fondo_pantalla.dart';
import 'package:proyecto_erp/providers/Provider.dart';

import '../../preferencias_usuario.dart';
import 'UsuarioLogin.dart';



class UsuarioPage extends StatefulWidget{
  UsuarioPage_ createState() => UsuarioPage_();
}

class UsuarioPage_ extends State<UsuarioPage> {

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(title: Text('Usuario activo')),
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
  final UsuarioPage_ usuarioPage_;
  Timer _timer;

  FutureBuilderState(this.usuarioPage_);

  Provider provider;
  @override
  Widget build(Object context) {
    provider = new Provider();
    return FutureBuilder<Usuario>(
      future: provider.usuarioGetActivo(),
      builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
        if (snapshot.hasData) {
          final usuario = snapshot.data;
          return _builDatos(context, usuario);
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

  Widget _builDatos(BuildContext context, Usuario usuario) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Id: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
              Text('${usuario.id}', style: TextStyle(fontSize: 15, color: Colors.white),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Employee id: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
              Text('${usuario.employee_id}', style: TextStyle(fontSize: 15, color: Colors.white),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Password creada: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
              Text('${usuario.password_creada}', style: TextStyle(fontSize: 15, color: Colors.white),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Email: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
              Text('${usuario.email}', style: TextStyle(fontSize: 15, color: Colors.white),),
            ],
          ),
          FlatButton(
            child: Text("LogOut"),
            onPressed: () {
              final prefs = new PreferenciasUsuario();
              prefs.setToken("");
              /*Navigator.removeRouteBelow(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );*/
            }
          ),
        ],
      );
  }

}