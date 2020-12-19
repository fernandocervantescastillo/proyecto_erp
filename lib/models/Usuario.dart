class Usuario{
  int id;
  String email;
  bool password_creada;
  int employee_id;
  int rol_id;
  String created_at;
  String updated_at;

  Usuario(this.id, this.email, this.password_creada, this.employee_id, this.rol_id, this.created_at, this.updated_at);

  factory Usuario.fromJson(dynamic json) {
    return Usuario(
        json['id'] as int,
        json['email'] as String,
        json['password_creada'] as bool,
        json['employee_id'] as int,
        json['rol_id'] as int,
        json['created_at'] as String,
        json['updated_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.email}, ${this.password_creada}, ${this.employee_id}, ${this.rol_id}, ${this.created_at}, ${this.updated_at} }';
  }
}
