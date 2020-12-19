class Activities{

  int id;
  int user_id;
  String nombre;
  String apellido;
  String email;
  String action;
  String content;
  String date;

  Activities(this.id, this.user_id, this.nombre, this.apellido, this.email, this.action, this.content, this.date);

  factory Activities.fromJson(dynamic json) {
    return Activities(
      json['id'] as int,
      json['user_id'] as int,
      json['nombre'] as String,
      json['apellido'] as String,
      json['email'] as String,
      json['action'] as String,
      json['content'] as String,
      json['date'] as String,
    );
  }

  @override
  String toString() {
  return '{ ${this.id}, ${this.user_id}, ${this.nombre}, ${this.apellido}, ${this.email}, ${this.action}, ${this.content}, ${this.date} }';
  }
}
