import 'package:flutter/services.dart';

class Producto{

  int id;
  String descripcion;
  String nombre;
  String precio;
  String costo;
  int category_id;
  String created_at;
  String updated_at;


  Producto(this.id, this.descripcion, this.nombre, this.precio, this.costo, this.category_id, this.created_at, this.updated_at);

  factory Producto.fromJson(dynamic json) {
    return Producto(
        json['id'] as int,
        json['descripcion'] as String,
        json['nombre'] as String,
        json['precio'] as String,
        json['costo'] as String,
        json['category_id'] as int,
        json['created_at'] as String,
        json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.descripcion}, ${this.nombre}, ${this.precio}, ${this.costo}, ${this.category_id}, ${this.created_at}, ${this.updated_at} }';
  }
}
