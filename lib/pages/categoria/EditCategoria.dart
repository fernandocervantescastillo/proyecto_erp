import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/providers/Provider.dart';


class EditCategoriaPage extends StatefulWidget {

  final Categoria categoria;

  const EditCategoriaPage({Key key, this.categoria}) : super(key: key);

  @override
  _EditCategoriaPage createState() => _EditCategoriaPage();
}

class _EditCategoriaPage extends State<EditCategoriaPage>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();
  Timer _timer;

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _nombreController.text = widget.categoria.nombre;
    _descripcionController.text = widget.categoria.descripcion;

    return Scaffold(
        appBar: AppBar(
          title: Text('Editar categoria'),
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
    Categoria categoria = widget.categoria;
    categoria.nombre = _nombreController.text;
    categoria.descripcion = _descripcionController.text;
    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');


      categoria = await provider.categoriaActualizar(widget.categoria);

      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se edito la categoria"),));
    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));
    }
  }

}
