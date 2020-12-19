class Almacen{

  int id;
  String ubicacion;
  int office_id;
  String created_at;
  String updated_at;

  Almacen(this.id, this.ubicacion, this.office_id, this.created_at, this.updated_at);

  factory Almacen.fromJson(dynamic json) {
    return Almacen(
        json['id'] as int,
        json['ubicacion'] as String,
        json['office_id'] as int,
        json['created_at'] as String,
        json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.ubicacion}, ${this.office_id}, ${this.created_at}, ${this.updated_at} }';
  }
}
