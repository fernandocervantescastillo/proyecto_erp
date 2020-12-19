import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/providers/Provider.dart';


class NewSucursalPage extends StatefulWidget {
  @override
  _NewSucursalPageState createState() => _NewSucursalPageState();
}

class _NewSucursalPageState extends State<NewSucursalPage>{
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _cityIdController = new TextEditingController();

  Timer _timer;


  @override
  void dispose() {
    _nombreController.dispose();
    _cityIdController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _nombreController.text = "";
    _cityIdController.text = "";

    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar producto'),
        ),
        body: Form(
          key: _formKey,
          child:
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              _crearNombre(),
              Divider(),
              _crearcityId(),
              Divider(),
              _crearBoton(context),
            ],
          ),
        )
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      controller: _nombreController,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre del producto',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.location_city),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
        }
        return null;
      },
    );
  }

  Widget _crearcityId(){
    return TextFormField(
      controller: _cityIdController,
      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false,),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'City Id',
        labelText: 'City Id',
        suffixIcon: Icon(Icons.map),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
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

    Sucursal sucursal = new Sucursal(
        1,
        _nombreController.text,
        int.parse(_cityIdController.text),
        "",
        ""
    );

    Provider provider = new Provider();
    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');

      sucursal = await provider.sucursalNueva(sucursal);

      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se creo una nueva sucursal"),));
      _nombreController.text="";
      _cityIdController.text="";
    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));
    }
  }

}
