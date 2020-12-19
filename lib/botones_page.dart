import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:proyecto_erp/pages/activities/ActivitiesPage.dart';
import 'package:proyecto_erp/pages/almacen/AlmacenPage.dart';
import 'package:proyecto_erp/pages/categoria/CategoriasPage.dart';
import 'package:proyecto_erp/pages/ciudades/CiudadPage.dart';
import 'package:proyecto_erp/pages/cliente/NewCliente.dart';
import 'package:proyecto_erp/pages/compra/CompraPage.dart';
import 'package:proyecto_erp/pages/producto/ProductosPage.dart';
import 'package:proyecto_erp/pages/proveedor/ProveedoresPage.dart';
import 'package:proyecto_erp/pages/roles/rolesPage.dart';
import 'package:proyecto_erp/pages/sucursal/SucursalPage.dart';
import 'package:proyecto_erp/pages/usuario/UsuarioPage.dart';
import 'package:proyecto_erp/pages/ventas/VentaPage.dart';

class BotonesPage extends StatelessWidget {

  static final String routeName = 'botones';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                _botonesRedondeados(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Configura el fondo de la app
  Widget _fondoApp(){

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin:  FractionalOffset(0.0, 0.6),
              end:    FractionalOffset(0.0, 1.0),
              colors: [
                Color.fromRGBO(52, 54, 101, 1.0),
                Color.fromRGBO(35, 37, 57, 1.0),
              ]
          ),
      ),
    );



    final cajaRosada = Transform.rotate(
      angle: -pi / 5,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70.0),
          gradient: LinearGradient(
              colors: [
                //Color.fromRGBO(236, 98, 188, 1.0),
                //Color.fromRGBO(241, 142, 172, 1.0)
                Colors.teal,
                Colors.blueGrey
              ]
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100,
          child: cajaRosada,
        )
      ],
    );

  }

  //Titulo que se muestra en la parte superior
  Widget _titulos(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Modulos ERP', style: TextStyle(color: Colors.white70, fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 5.0,),
            Text('Escoja el modulo con el que desea trabajar', style: TextStyle(color: Colors.white70, fontSize: 18.0))
          ],
        ),
      ),
    );
  }


  //Las opciones que debemos elegir, si aumentamos las opciones, debemos de
  //aumentar los botones aqui
  Widget _botonesRedondeados(BuildContext context){
    return Table(
      children: [
        TableRow(
            children: [
              _crearBotonRedondeado(context, Colors.deepPurple, Icons.category,
                  'Categorias', CategoriasPage() ),

              _crearBotonRedondeado(context, Colors.deepPurple, Icons.directions_bus,
                  'Proveedores', ProveedoresPage() )
            ]
        ),
        TableRow(
            children: [
              _crearBotonRedondeado( context, Colors.deepPurple, Icons.add_shopping_cart,
                  'compras', CompraPage()),

              _crearBotonRedondeado(context, Colors.deepPurple, Icons.local_convenience_store,
                  'Productos', ProductosPage() )
            ]
        ),
        TableRow(
            children: [
              _crearBotonRedondeado( context, Colors.deepPurple, Icons.perm_identity,
                  'Usuario', UsuarioPage() ),

              _crearBotonRedondeado(context, Colors.deepPurple, Icons.home,
                  'Almacen', AlmacenPage() )
            ]
        ),
        TableRow(
            children: [
              _crearBotonRedondeado( context, Colors.deepPurple, Icons.domain,
                  'Sucursal', SucursalPage() ),

              _crearBotonRedondeado(context, Colors.deepPurple, Icons.edit,
                  'Activities', ActivitiesPage() )
            ]
        ),
        TableRow(
            children: [

              _crearBotonRedondeado(context, Colors.deepPurple, Icons.monetization_on,
                  'Ventas', VentaPage() ),
              _crearBotonRedondeado( context, Colors.deepPurple, Icons.people,
                  'Clientes', NewClientePage() ),
           ]
        ),
        TableRow(
            children: [
              _crearBotonRedondeado(context, Colors.deepPurple, Icons.gps_fixed,
                  'Ciudades', CiudadPage() ),
              _crearBotonRedondeado( context, Colors.deepPurple, Icons.accessibility,
                  'Roles', RolPage() ),
            ]
        ),
      ],
    );
  }

  boton(){

  }

  Widget _crearBotonRedondeado( BuildContext context,Color color, IconData icono, String texto, url ){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 180.0,
            //margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(62, 66, 107, 0.7),
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox( height: 5.0, ),
                FloatingActionButton(
                  heroTag: 'btn${texto}',
                  backgroundColor: color,
                  foregroundColor: Colors.white70,
                  child: Icon(icono),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {return url;})
                  ),

                ),
                Text( texto, style: TextStyle( color: Colors.white70, fontSize: 20.0 ),  )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
