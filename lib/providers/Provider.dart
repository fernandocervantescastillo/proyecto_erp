import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_erp/models/Activities.dart';
import 'package:proyecto_erp/models/Almacen.dart';
import 'package:proyecto_erp/models/Categoria.dart';
import 'package:proyecto_erp/models/Ciudad.dart';
import 'package:proyecto_erp/models/Cliente.dart';
import 'package:proyecto_erp/models/Compra.dart';
import 'package:proyecto_erp/models/CompraProducto.dart';
import 'package:proyecto_erp/models/Login.dart';
import 'package:proyecto_erp/models/Producto.dart';
import 'package:proyecto_erp/models/Rol.dart';
import 'package:proyecto_erp/models/Sucursal.dart';
import 'package:proyecto_erp/models/Usuario.dart';
import 'package:proyecto_erp/models/proveedor.dart';
import 'package:http/http.dart' as http;

class Provider{
    String t = 'http://ec2-13-58-202-32.us-east-2.compute.amazonaws.com';
    String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWMwNmRhMGUxM2RhYjVmZWFmMjBmODNiNGVjZjA2OTg1Y2QxMDFmNmY2OGI4ZTI4OTZkODFhOWE2NjY2ZGY1OWM4NDVlM2YyY2Y3MTY0OGEiLCJpYXQiOjE2MDI1MDgyMDcsIm5iZiI6MTYwMjUwODIwNywiZXhwIjoxNjM0MDQ0MjA3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.J6JyRyRe4uDwvBXgAWtVK_YuiTvmhmZ3v6_6s0Vgr08K51JVu2Zhkkg6Ii6L_hhegKd6_w4CBIMwB3duAxK1eKPLb9cDqGcOR63WGvRkY4WPLG5uUrHmyqA8bVW_jbIzP7Kc858x32Y0nipQoOylSUA_5mmffuSfuMVh-vV05qKzgm0clCFGY5u79h8VfMs-PUBzsz8oJfDImOlR36374Cc3UhfWgXrlclAYYbCP2jCgf_ZaBNy0L7YJ2XvON929RXC7JnTxb2QJj0JH-ZiNtAl7LYhexnhPwCgpuQc2A09Sh1reKNd6S8Y62Ec5tSvH1YywREEQpw4xabsnQ64TrAZ5QFNuSyE_zD3TWoGv8mb8o-RFzSHTjmd0n1CI8fSuuqNE0_6qUHzWw6ku3FmwfCe6VnTRKQXUA8JiI7ck1CQfH_KBHd6Rq6PCzRSD1KX9gQT1a3Xzw3y3wHKaErSKPDN8QU6vW4Q87A6kCRbXJx8KVWZGAiYPIDVxVx5UyydwApE6vBZsO8EBc6aE4P1z6_vuyo_RhJXQCJR-yHwweWuq03s3rVMGmlJj9quuh29CufzFu0y3QWB-cv46H8k8SgVjMXOQ4lCAo2gzrCZXg0grZxGtKzy4aFASqBEmq4Pv9wgYu8vxFES5a1T_S2HimOsJSdEuU758YpUY-vdEJ6Y";
  //Proveedor
  //*****************************************************************************************
  Future<List<Proveedor>> proveedorGetLista() async {
    var url = t + '/api/providers';
    try{
      var response = await http.get(url,);
      if (response.statusCode == 200) {
        var tagObjsJson = jsonDecode(response.body) as List;
        List<Proveedor> tagObjs = tagObjsJson.map((tagJson) => Proveedor.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){

      throw "No se puede conectar con el servidor";
    }
  }

  Future<Proveedor> proveedorNuevoProveedor(Proveedor proveedor) async {
    var url = t +'/api/provider';
    Map<String, String> bodys = {
      'empresa'  : proveedor.empresa,
      'direccion' : proveedor.direccion,
      'telefono' : proveedor.telefono.toString()
    };

    try{
      var response = await http.post(url,body:bodys);
      if (response.statusCode == 200) {
        Proveedor tagObjs = Proveedor.fromJson(jsonDecode(response.body));
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }
  //*****************************************************************************************



  //Categoria
  //*****************************************************************************************
  Future<List<Categoria>> categoriaGetLista() async {
    var url = t + '/api/categories';
    try{
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var tagObjsJson = jsonDecode(response.body) as List;
        List<Categoria> tagObjs = tagObjsJson.map((tagJson) => Categoria.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Categoria> categoriaNueva(Categoria categoria) async {
    var url = t + '/api/category';
    Map<String, String> bodys = {
      'nombre'  : categoria.nombre,
      'descripcion' : categoria.descripcion,
    };

    try{
      var response = await http.post(url,body:bodys);
      if (response.statusCode == 200) {
        Categoria tagObjs = Categoria.fromJson(jsonDecode(response.body));
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Categoria> categoriaActualizar(Categoria categoria) async {
    var url = t + '/api/category/' + categoria.id.toString();
    Map<String, String> bodys = {
      'nombre'  : categoria.nombre,
      'descripcion' : categoria.descripcion,
    };

    try{
      var response = await http.put(url,body:bodys);
      if (response.statusCode == 200) {
        Categoria tagObjs = Categoria.fromJson(jsonDecode(response.body));
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }
  //*****************************************************************************************



  //Producto
  //*****************************************************************************************
  Future<List<Producto>> productoGetLista() async {
    var url = t + '/api/products';
    try{
      var response = await http.get(url);
      if (response.statusCode == 200) {

        var tagObjsJson = jsonDecode(response.body) as List;
        List<Producto> tagObjs = tagObjsJson.map((tagJson) => Producto.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Producto> productoNueva(Producto producto) async {
    var url = t + '/api/product';
    Map<String, String> bodys = {
      "descripcion":producto.descripcion,
      "nombre":producto.nombre,
      "precio":producto.precio.toString(),
      "costo":producto.costo.toString(),
      "category_id":producto.category_id.toString()
    };
    try{
      var response = await http.post(url,body:bodys);
      if (response.statusCode == 200) {
        //Producto tagObjs = Producto.fromJson(jsonDecode(response.body));
        //return tagObjs;
        return null;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Producto> productoActualizar(Producto producto) async {
    var url = t + '/api/product'+ '/' + producto.id.toString();
    Map<String, String> bodys = {
      "nombre":producto.nombre,
      "descripcion":producto.descripcion,
      "precio":producto.precio.toString(),
      "costo":producto.costo.toString(),
      "category_id":producto.category_id.toString()
    };

    try{
      var response = await http.put(url,body:bodys);
      if (response.statusCode == 200) {
        //Producto tagObjs = Producto.fromJson(jsonDecode(response.body));
        //return tagObjs;
        return null;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<String> productoEliminar(Producto producto) async {
    var url = t + '/api/product'+ '/' + producto.id.toString();
    try{
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        String tagObjs = response.body.toString();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }
//*****************************************************************************************





  //Sucursal
  //*****************************************************************************************
  Future<List<Sucursal>> sucursalGetLista() async {
    var url = t + '/api/offices';
    try{
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var tagObjsJson = jsonDecode(response.body) as List;
        List<Sucursal> tagObjs = tagObjsJson.map((tagJson) => Sucursal.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Sucursal> sucursalNueva(Sucursal sucursal) async {
    var url = t + '/api/office';
    Map<String, String> bodys = {
      "nombre":sucursal.nombre,
      "city_id":sucursal.city_id.toString()
    };
    try{
      var response = await http.post(url,body:bodys);
      if (response.statusCode == 200) {
        //Producto tagObjs = Producto.fromJson(jsonDecode(response.body));
        //return tagObjs;
        return null;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Sucursal> sucursalActualizar(Sucursal sucursal) async {
    var url = t + '/api/office'+ '/' + sucursal.id.toString();
    Map<String, String> bodys = {
      "nombre":sucursal.nombre,
      "city_id":sucursal.city_id.toString()
    };
    try{
      var response = await http.put(url,body:bodys);
      if (response.statusCode == 200) {
        //Producto tagObjs = Producto.fromJson(jsonDecode(response.body));
        //return tagObjs;
        return null;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<String> sucursalEliminar(Sucursal sucursal) async {
    var url = t + '/api/office'+ '/' + sucursal.id.toString();

    try{
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        String tagObjs = response.body.toString();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }
//*****************************************************************************************



  //Almacen
  //*****************************************************************************************
  Future<List<Almacen>> almacenGetLista() async {
    var url = t + '/api/deposits';
    try{
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var tagObjsJson = jsonDecode(response.body) as List;
        List<Almacen> tagObjs = tagObjsJson.map((tagJson) => Almacen.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Almacen> almacenNueva(Almacen almacen) async {
    var url = t + '/api/deposit';
    Map<String, String> bodys = {
      "ubicacion":almacen.ubicacion,
      "office_id":almacen.office_id.toString()
    };
    try{
      var response = await http.post(url,body:bodys);
      if (response.statusCode == 200) {
        //Producto tagObjs = Producto.fromJson(jsonDecode(response.body));
        //return tagObjs;
        return null;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Almacen> almacenActualizar(Almacen almacen) async {
    var url = t + '/api/deposit'+ '/' + almacen.id.toString();
    Map<String, String> bodys = {
      "ubicacion":almacen.ubicacion,
      "office_id":almacen.office_id.toString()
    };
    try{
      var response = await http.put(url,body:bodys);
      if (response.statusCode == 200) {
        //Producto tagObjs = Producto.fromJson(jsonDecode(response.body));
        //return tagObjs;
        return null;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<String> almacenEliminar(Almacen almacen) async {
    var url = t + '/api/deposit'+ '/' + almacen.id.toString();

    try{
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        String tagObjs = response.body.toString();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }
//*****************************************************************************************


  //Ciudad
  //*****************************************************************************************
  Future<List<Ciudad>> ciudadGetLista() async {
    var url = t + '/api/cities';
    try{
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var tagObjsJson = jsonDecode(response.body) as List;
        List<Ciudad> tagObjs = tagObjsJson.map((tagJson) => Ciudad.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }

  Future<Ciudad> ciudadNueva(Ciudad ciudad) async {
    var url = t + '/api/city';
    Map<String, String> bodys = {
      "nombre":ciudad.nombre,
      "country_id":ciudad.country_id.toString()
    };

    try{
      var response = await http.post(url,body:bodys);
      if (response.statusCode == 200) {
        //Producto tagObjs = Producto.fromJson(jsonDecode(response.body));
        //return tagObjs;
        return null;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }
//*****************************************************************************************


  //Cliente
  //*****************************************************************************************

  Future<Cliente> clienteNueva(Cliente cliente) async {
    var url = t + '/api/client';
    Map<String, String> bodys = {
      "ci":cliente.ci,
      "nombre":cliente.nombre,
      "apellido":cliente.apellido,
      "telefono":cliente.telefono
    };

    try{
      var response = await http.post(url,body:bodys);
      if (response.statusCode == 200) {
        //Producto tagObjs = Producto.fromJson(jsonDecode(response.body));
        //return tagObjs;
        return null;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }
//*****************************************************************************************


  //Rol
  //*****************************************************************************************

  Future<List<Rol>> rolGetLista() async {
    var url = t + '/api/roles';
    try{
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var tagObjsJson = jsonDecode(response.body) as List;
        List<Rol> tagObjs = tagObjsJson.map((tagJson) => Rol.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";
    }
  }
  //*****************************************************************************************


  //Compras
  //*****************************************************************************************

  Future<List<Compra>> compraGetLista() async {
    var url = t + '/api/purchases';
    try{
      Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type" : "application/json",
      "Authorization" : "Bearer " + token
      };
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var tagObjsJson = jsonDecode(response.body) as List;
        int i;
        List<Compra> tagObjs = tagObjsJson.map((tagJson) => Compra.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";

    }
  }
  //*****************************************************************************************


  //Activities
  //*****************************************************************************************

  Future<List<Activities>> activitiesGetLista() async {
    var url = t + '/api/activities';
    try{
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type" : "application/json",
        "Authorization" : "Bearer " + token
      };
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var tagObjsJson = jsonDecode(response.body) as List;
        int i;
        List<Activities> tagObjs = tagObjsJson.map((tagJson) => Activities.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";

    }
  }
//*****************************************************************************************




//Usuario
  //*****************************************************************************************

  Future<Usuario> usuarioGetActivo() async {
    var url = t + '/api/user';
    try{
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type" : "application/json",
        "Authorization" : "Bearer " + token
      };
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        Usuario tagObjs = Usuario.fromJson(jsonDecode(response.body));
        return tagObjs;
      } else {
        throw "Error del servidor";
      }
    } catch (err){
      throw "No se puede conectar con el servidor";

    }
  }




  Future<Login> usuarioLogin(String user, String password) async {
    var url = t + '/api/login';

    Map<String, String> headers = {
      "Accept": "application/json",
    };

    Map<String, String> bodys = {
      "email":user,
      "password":password
    };

    try{
      var response = await http.post(url, headers: headers, body:bodys);
      if (response.statusCode == 200) {
        Login tagObjs = Login.fromJson(jsonDecode(response.body));
        return tagObjs;
      } else {
        throw response.body.toString();
      }
    } catch (err){
      throw err.toString() ;
    }
  }
//*****************************************************************************************


}
