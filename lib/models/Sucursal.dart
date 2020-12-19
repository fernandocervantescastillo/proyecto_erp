class Sucursal{
  int id;
  String nombre;
  int city_id;
  String created_at;
  String updated_at;

  Sucursal(this.id, this.nombre, this.city_id, this.created_at, this.updated_at);

  factory Sucursal.fromJson(dynamic json) {
    return Sucursal(
        json['id'] as int,
        json['nombre'] as String,
        json['city_id'] as int,
        json['created_at'] as String,
        json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.nombre}, ${this.city_id}, ${this.created_at}, ${this.updated_at} }';
  }
}
