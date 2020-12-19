import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/models/Ciudad.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:proyecto_erp/providers/Provider.dart';


class NewCiudadPage extends StatefulWidget {
  @override
  _NewCiudadPageState createState() => _NewCiudadPageState();
}



class _NewCiudadPageState extends State<NewCiudadPage>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _countryIdController = new TextEditingController();

  Timer _timer;

  @override
  void dispose() {
    _nombreController.dispose();
    _countryIdController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _nombreController.text = "";
    _countryIdController.text = "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar ciudad'),
      ),
      body: Form(
        key: _formKey,
        child:
        ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[
            _crearNombre(),
            Divider(),
            _crearIdCountry(),
            Divider(),
            _crearBoton(context),
          ],
        ),
      ),
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
        hintText: 'Ciudad',
        labelText: 'Ciudad',
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

  Widget _crearIdCountry(){
    return TextFormField(
      controller: _countryIdController,
      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Id del pais',
        labelText: 'Id del pais',
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
    Ciudad ciudad = new Ciudad(
        1,
        _nombreController.text,
        int.parse(_countryIdController.text),
        "",
        ""
    );

    Provider provider = new Provider();
    try {
      _timer?.cancel();
      EasyLoading.show(status: 'loading...');


      ciudad = await provider.ciudadNueva(ciudad);
      //Navigator.pop(context);


      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Se creo una nueva ciudad"),));
      _nombreController.text="";
      _countryIdController.text="";

    }
    catch(error){
      _timer?.cancel();
      EasyLoading.dismiss();

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()),));

    }
  }

}
