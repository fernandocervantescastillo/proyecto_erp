import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/providers/Provider.dart';


class EditProductoPage extends StatefulWidget {

  final Producto producto;

  const EditProductoPage({Key key, this.producto}) : super(key: key);

  @override
  _EditProductoPage createState() => _EditProductoPage();
}

class _EditProductoPage extends State<EditProductoPage>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();
  TextEditingController _precioController = new TextEditingController();
  TextEditingController _costoController = new TextEditingController();
  TextEditingController _categoriaController = new TextEditingController();
  Timer _timer;

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    _costoController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _nombreController.text = widget.producto.nombre;
    _descripcionController.text = widget.producto.descripcion;
    _precioController.text = widget.producto.precio.toString();
    _costoController.text = widget.producto.costo.toString();
    _categoriaController.text = widget.producto.category_id.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text('Editar producto'),
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
              _crearPrecio(),
              Divider(),
              _crearCosto(),
              Divider(),
              _crearCategoria(),
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
      textCapitalization: TextCapitalization.words, //Primera letra mayuscula de cada palabra
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre del producto',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.people),
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
      textCapitalization: TextCapitalization.sentences, //Primera letra mayuscula de cada palabra
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Descripción del producto',
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

  Widget _crearCosto(){
    return TextFormField(
      controller: _costoController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Costo del producto',
        labelText: 'Costo',
        suffixIcon: Icon(Icons.monetization_on),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
        }

        try{
          double a = double.parse(value.toString());
          print("**************************************");
          print(a.toString());
          if(a<0)
            return "Ingrese un numero positivo";
        }
        catch(error){
          return "Debe ingresar un numero real";
        }


        return null;
      },
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      controller: _precioController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Precio del producto',
        labelText: 'Precio',
        suffixIcon: Icon(Icons.monetization_on),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese dato';
        }

        try{
          double a = double.parse(value.toString());
          print("**************************************");
          print(a.toString());
          if(a<0)
            return "Ingrese un numero positivo";
        }
        catch(error){
          return "Debe ingresar un numero real";
        }


        return null;
      },
    );
  }

  Widget _crearCategoria(){
    return TextFormField(
      controller: _categoriaController,
      textCapitalization: TextCapitalization.sentences, //Primera letra mayuscula de cada palabra
      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false,),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Categoria del producto',
        labelText: 'Categoria',
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
    Producto producto = widget.producto;
    producto.nombre = _nombreController.text;
    producto.descripcion = _descripcionController.text;
    producto.costo = _costoController.text;
    producto.precio = _precioController.text;
    producto.category_id = int.parse(_categoriaController.text);

    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');


      producto = await provider.productoActualizar(widget.producto);

      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se edito el producto"),));
    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));
    }
  }

}
