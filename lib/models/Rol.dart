class Rol{
  int id;
  String name;
  String created_at;
  String updated_at;

  Rol(this.id, this.name, this.created_at, this.updated_at);

  factory Rol.fromJson(dynamic json) {
    return Rol(
        json['id'] as int,
        json['name'] as String,
        json['created_at'] as String,
        json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.created_at}, ${this.updated_at} }';
  }
}