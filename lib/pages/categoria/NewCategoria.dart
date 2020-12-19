import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/providers/Provider.dart';


class NewCategoriaPage extends StatefulWidget {
  @override
  _NewCategoriaPageState createState() => _NewCategoriaPageState();
}

class _NewCategoriaPageState extends State<NewCategoriaPage>{
  Timer _timer;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _nombreController.text = "";
    _descripcionController.text = "";

    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar categoria'),
        ),
        body: Form(
          key: _formKey,
          child:
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              _crearNombre(),
              Divider(),
              _crearDescripcion(),
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
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre del proveedor',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.category),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
        }
        return null;
      },
    );
  }

  Widget _crearDescripcion(){
    return TextFormField(
      controller: _descripcionController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Descripción de la categoria',
        labelText: 'Descripción',
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


    Categoria categoria = new Categoria(
        1,
        _nombreController.text,
        _descripcionController.text,
        "",
        ""
    );

    Provider provider = new Provider();
    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');

      categoria = await provider.categoriaNueva(categoria);

      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se creo una nueva categoria"),));
      _nombreController.text="";
      _descripcionController.text="";
    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));
    }
  }

}
