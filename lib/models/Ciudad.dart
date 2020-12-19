class Ciudad{
  int id;
  String nombre;
  int country_id;
  String created_at;
  String updated_at;

  Ciudad(this.id, this.nombre, this.country_id, this.created_at, this.updated_at);

  factory Ciudad.fromJson(dynamic json) {
    return Ciudad(
      json['id'] as int,
      json['nombre'] as String,
      json['country_id'] as int,
      json['created_at'] as String,
      json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.nombre}, ${this.country_id.toString()}, ${this.created_at}, ${this.updated_at} }';
  }
}
