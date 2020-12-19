class Categoria{
  int id;
  String nombre;
  String descripcion;
  String created_at;
  String updated_at;

  Categoria(this.id, this.nombre, this.descripcion, this.created_at, this.updated_at);

  factory Categoria.fromJson(dynamic json) {
    return Categoria(
        json['id'] as int,
        json['nombre'] as String,
        json['descripcion'] as String,
        json['created_at'] as String,
        json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.nombre}, ${this.descripcion}, ${this.created_at}, ${this.updated_at} }';
  }
}
