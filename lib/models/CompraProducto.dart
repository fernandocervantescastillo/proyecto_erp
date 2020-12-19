class CompraProducto{
  String nombre;
  String costo_por_unidad;
  int cantidad;

  CompraProducto(this.nombre, this.costo_por_unidad, this.cantidad);

  factory CompraProducto.fromJson(dynamic json) {
    return CompraProducto(
        json['nombre'] as String,
        json['costo_por_unidad'] as String,
        json['cantidad'] as int);
  }

  @override
  String toString() {
    return '{ ${this.nombre}, ${this.costo_por_unidad}, ${this.cantidad}}';
  }
}
