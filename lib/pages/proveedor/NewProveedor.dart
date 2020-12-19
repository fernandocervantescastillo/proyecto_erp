import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/providers/Provider.dart';


class NewProveedorPage extends StatefulWidget {
  @override
    _NewProveedorPageState createState() => _NewProveedorPageState();
}





class _NewProveedorPageState extends State<NewProveedorPage>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController _empresaController = new TextEditingController();
  TextEditingController _direccionController = new TextEditingController();
  TextEditingController _telefonoController = new TextEditingController();
  Timer _timer;

  @override
  void dispose() {
    _empresaController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _empresaController.text = "";
    _direccionController.text = "";
    _telefonoController.text = "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar proveedor'),
      ),
      body: Form(
        key: _formKey,
        child:
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              _crearEmpresa(),
              Divider(),
              _crearDireccion(),
              Divider(),
              _crearTelefono(),
              Divider(),
              _crearBoton(context),
            ],
          ),
      ),
    );
  }

  Widget _crearEmpresa(){
    return TextFormField(
      controller: _empresaController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre de la empresa',
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

  Widget _crearDireccion(){
    return TextFormField(
      controller: _direccionController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Dirección de la empresa',
        labelText: 'Dirección',
        suffixIcon: Icon(Icons.gps_fixed),
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
        hintText: 'Número de teléfono de la empresa',
        labelText: 'Teléfono:',
        suffixIcon: Icon(Icons.phone),
      ),
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
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
    Proveedor proveedor = new Proveedor(
        1,
        _empresaController.text,
        _direccionController.text,
        _telefonoController.text,
        "",
        ""
    );

    Provider provider = new Provider();
    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');


      proveedor = await provider.proveedorNuevoProveedor(proveedor);
      //Navigator.pop(context);


      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se creo un nuevo proveedor"),));
      _empresaController.text="";
      _direccionController.text="";
      _telefonoController.text="";

    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));

    }
  }

}
