import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Almacen.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/providers/Provider.dart';


class EditAlmacenPage extends StatefulWidget {

  final Almacen almacen;

  const EditAlmacenPage({Key key, this.almacen}) : super(key: key);

  @override
  _EditAlmacenPage createState() => _EditAlmacenPage();
}

class _EditAlmacenPage extends State<EditAlmacenPage>{

  final _formKey = GlobalKey<FormState>();

  TextEditingController _ubicacionController = new TextEditingController();
  TextEditingController _officeIdController = new TextEditingController();

  Timer _timer;

  @override
  void dispose() {
    _ubicacionController.dispose();
    _officeIdController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _ubicacionController.text = widget.almacen.ubicacion;
    _officeIdController.text = widget.almacen.office_id.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar almacen'),
        ),
        body: Form(
          key: _formKey,
          child:
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              _crearUbicacion(),
              Divider(),
              _crearOfficeId(),
              Divider(),
              _crearBoton(context),
            ],
          ),
        )
    );
  }

  Widget _crearUbicacion(){
    return TextFormField(
      controller: _ubicacionController,
        textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Direccion del almacen',
        labelText: 'Direccion',
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

  Widget _crearOfficeId(){
    return TextFormField(
      controller: _officeIdController,
      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Office Id',
        labelText: 'Office Id',
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
              child: Text("Editar",style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.2,),
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

    Provider provider = new Provider();

    Almacen almacen = widget.almacen;
    almacen.ubicacion = _ubicacionController.text;
    almacen.office_id = int.parse(_officeIdController.text);

    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');


      almacen = await provider.almacenActualizar(almacen);

      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se edito el almacen"),));
    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));
    }
  }

}
