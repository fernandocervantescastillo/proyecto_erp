import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Almacen.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Cliente.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/providers/Provider.dart';


class NewClientePage extends StatefulWidget {
  @override
  _NewClientePageState createState() => _NewClientePageState();
}

class _NewClientePageState extends State<NewClientePage>{
  final _formKey = GlobalKey<FormState>();

  TextEditingController _ciController = new TextEditingController();
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _apellidoController = new TextEditingController();
  TextEditingController _telefonoController = new TextEditingController();

  Timer _timer;


  @override
  void dispose() {
    _ciController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _ciController.text = "";
    _nombreController.text = "";
    _apellidoController.text = "";
    _telefonoController.text = "";

    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar Cliente'),
        ),
        body: Form(
          key: _formKey,
          child:
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              _crearCi(),
              Divider(),
              _crearNombre(),
              Divider(),
              _crearApellido(),
              Divider(),
              _crearTelefono(),
              Divider(),
              _crearBoton(context),
            ],
          ),
        )
    );
  }

  Widget _crearCi(){
    return TextFormField(
      controller: _ciController,
      keyboardType: TextInputType.numberWithOptions(signed:false, decimal:false),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Cedula de identidad',
        labelText: 'CI',
        suffixIcon: Icon(Icons.contacts),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
        }

        try{
          int a = int.parse(value.toString());
          int n = 0;
          while(a>0){
            a = (a / 10).truncate();
            n=n+1;
          }
          if(n<5)
            return "Ingrese un numero mayor que 5 digitos";
        }catch(error){
          return "Debe de ingresar un numero entero";
        }


        return null;
      },
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      controller: _nombreController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.edit),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
        }
        return null;
      },
    );
  }

  Widget _crearApellido(){
    return TextFormField(
      controller: _apellidoController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Apellido',
        labelText: 'Apellido',
        suffixIcon: Icon(Icons.edit),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
        }
        return null;
      },
    );
  }

  Widget _crearTelefono(){
    return TextFormField(
      controller: _telefonoController,
      keyboardType: TextInputType.numberWithOptions(signed:false, decimal:false),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Telefono',
        labelText: 'Telefono',
        suffixIcon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
        }
        try{
          int a = int.parse(value.toString());
          int n = 0;
          while(a>0){
            a = (a / 10).truncate();
            n=n+1;
          }
          if(n<5)
            return "Ingrese un numero mayor que 5 digitos";
        }catch(error){
          return "Debe de ingresar un numero entero";
        }

        return null;
      },
    );
  }

  Widget _crearBoton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child:Builder(
        builder: (context) {
          return RaisedButton(
              child: Text("Crear",style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.2,),
              textColor: Colors.white,
              color: Colors.deepPurple,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              splashColor: Colors.grey,
              onPressed: () => {
                if (_formKey.currentState.validate()) {
                  llamar(context),
                },
              });
        },
      ),
    );
  }

  void llamar(BuildContext context) async {

    Cliente cliente = new Cliente(
        1,
        _ciController.text,
        _nombreController.text,
        _apellidoController.text,
        _telefonoController.text,
        "",
        ""
    );

    Provider provider = new Provider();
    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');

      cliente = await provider.clienteNueva(cliente);

      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se creo un nuevo cliente"),));
      _ciController.text = "";
      _nombreController.text = "";
      _apellidoController.text = "";
      _telefonoController.text = "";
    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));
    }
  }

}
