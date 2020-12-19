class Cliente{

  int id;
  String ci;
  String nombre;
  String apellido;
  String telefono;
  String created_at;
  String updated_at;

  Cliente(this.id, this.ci, this.nombre, this.apellido, this.telefono, this.created_at, this.updated_at);

  factory Cliente.fromJson(dynamic json) {
    return Cliente(
        json['id'] as int,
        json['ci'] as String,
        json['nombre'] as String,
        json['apellido'] as String,
        json['telefono'] as String,
        json['created_at'] as String,
        json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.ci}, ${this.nombre}, ${this.apellido}, ${this.telefono}, ${this.created_at}, ${this.updated_at} }';
  }
}
