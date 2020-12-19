import 'dart:convert';

import 'package:flutter/material.dart';

import 'CompraProducto.dart';

class Compra{
  int id;
  String costoTotal;
  List<CompraProducto> productos;


  Compra(this.id, this.costoTotal, this.productos,);

  factory Compra.fromJson(dynamic json) {
    List<CompraProducto> compraProducto;
    if(json['productos'].toString()=="[]")
      compraProducto = new List<CompraProducto> ();
    else
      compraProducto = obtenerListaCompraProducto(json['productos'].toString());

    return Compra(
        json['id'] as int,
        json['costoTotal'] as String,
        compraProducto
    );
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.costoTotal}, ${this.productos}}';
  }
}


List<CompraProducto> obtenerListaCompraProducto(String t){
  List<String> u = new List<String>();
  List<CompraProducto> uu = new List<CompraProducto>();
  String v;
  String s;

  s="";
  for(int i=0;i<t.length;i++){
    v = t.substring(i,i+1);
    if(v!="["){
      if(v!="{"){
        if(v=="}"){
          u.add(s);
          s="";
        }
        else{
          s=s+v;
        }
      }
      else{
        s="";
      }
    }
  }

  for(int i=0;i<u.length;i++){
    uu.add(compraProducto(u[i]));
  }
  return uu;
}

CompraProducto compraProducto(String t){
  List<String> u = new List<String>();
  String a= "";
  String b = "";
  String v;
  String s="";
  t=t+",";
  for(int i=0;i<t.length;i++){
    v = t.substring(i,i+1);
    if(v==","){
      u.add(s);
      a="";
      b="";
    }
    else {
      if (a + b == ": ") {
        s = s + v;
      }
      else {
        a = b;
        b = v;
        s = "";
      }
    }
  }
  CompraProducto compraProducto = new CompraProducto(u[0], u[1], int.parse(u[2]));
  return compraProducto;
}