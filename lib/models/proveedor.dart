class Proveedor{
  int id;
  String empresa;
  String direccion;
  String telefono;
  String created_at;
  String updated_at;

  Proveedor(this.id, this.empresa, this.direccion, this.telefono, this.created_at, this.updated_at);

  factory Proveedor.fromJson(dynamic json) {
    return Proveedor(
        json['id'] as int,
        json['empresa'] as String,
        json['direccion'] as String,
        json['telefono'] as String,
        json['created_at'] as String,
        json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.empresa}, ${this.direccion}, ${this.telefono}, ${this.created_at}, ${this.updated_at} }';
  }
}
